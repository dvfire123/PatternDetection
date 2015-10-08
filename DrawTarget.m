function varargout = DrawTarget(varargin)
% DRAWTARGET MATLAB code for DrawTarget.fig
%      DRAWTARGET, by itself, creates a new DRAWTARGET or raises the existing
%      singleton*.
%
%      H = DRAWTARGET returns the handle to a new DRAWTARGET or the handle to
%      the existing singleton*.
%
%      DRAWTARGET('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DRAWTARGET.M with the given input arguments.
%
%      DRAWTARGET('Property','Value',...) creates a new DRAWTARGET or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DrawTarget_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DrawTarget_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DrawTarget

% Last Modified by GUIDE v2.5 08-Oct-2015 12:04:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DrawTarget_OpeningFcn, ...
                   'gui_OutputFcn',  @DrawTarget_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before DrawTarget is made visible.
function DrawTarget_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DrawTarget (see VARARGIN)
targ = ones(10, 10);
setappdata(0, 'targ', targ);
setappdata(0, 'invTarg', targ);
set(handles.drawTarget, 'UserData', targ);

% Choose default command line output for DrawTarget
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DrawTarget wait for user response (see UIRESUME)
% uiwait(handles.beginTest);

% --- Outputs from this function are returned to the command line.
function varargout = DrawTarget_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in beginTestButton.
function beginTestButton_Callback(hObject, eventdata, handles)
% hObject    handle to beginTestButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Transfers the current target to the new target window
targ = get(handles.drawTarget, 'UserData');
newTarg = targ;
[m, ~] = size(targ);
for i = 1:m
   newTarg(i, :) = targ(m + 1 - i, :);
end

setappdata(0, 'invTarg', newTarg);
setappdata(0, 'targ', targ);
close(gcbf);
figure(ActualTest);


% --- Executes on button press in saveTargetButton.
function saveTargetButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveTargetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%sdt stands for signal detection target
[FileName, pathName] = uiputfile('*.sdt', 'Saving your target');

%If the dialog box is cancelled
if pathName == 0
    return;
end

file = fullfile(pathName, FileName);

fid = fopen(file, 'wt+');
targ = get(handles.drawTarget, 'UserData');

%The target is stored as a column vector of 0 and 1's
for i = 1:10
   %10 is the height of the targ
   for j = 1:10
       %10 is the width of the targ
      fprintf(fid, '%d\n', targ(i, j)); 
   end
end

fclose(fid);

% --- Executes on button press in loadTargetButton.
function loadTargetButton_Callback(hObject, eventdata, handles)
% hObject    handle to loadTargetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

targ = ones(10, 10);
[fileName, pathName] = uigetfile('*.sdt', 'Please Select a .sdt file');
if pathName == 0
    return;
end

delete(get(handles.drawTarget, 'Children'));
axes(handles.drawTarget);
hold on;

file = fullfile(pathName, fileName);
fid = fopen(file, 'r');

B = fscanf(fid, '%d');

Bindx = 0;

%Sorry for the hardcoded magic numbers
%but it is the most efficient way

for i = 1:10
    for j = 1:10
      Bindx = Bindx + 1;
      targ(i, j) = B(Bindx);
    end
end

newTarg = targ;
[m, ~] = size(targ);
for i = 1:m
   newTarg(i, :) = targ(m + 1 - i, :);
end

set(handles.drawTarget, 'UserData', targ);
targHandle = displayTarget(targ, handles.drawTarget);
set(targHandle, 'HitTest', 'off');


% --- Executes on button press in clearButton.
function clearButton_Callback(hObject, eventdata, handles)
% hObject    handle to clearButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.drawTarget);
targ = ones(10, 10);
set(handles.drawTarget, 'UserData', targ);
delete(get(handles.drawTarget, 'Children'));

% --- Executes on mouse press over axes background.
function drawTarget_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to drawTarget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%The user data contains the target
%(10 x 10 matrix)
hold on;
delete(get(hObject, 'Children'));
coordinates = get(hObject, 'CurrentPoint'); 
coordinates = coordinates(1, 1:2);

pix = getPix(coordinates);
targ = get(hObject, 'UserData');
xpix = pix(1);
ypix = pix(2);

if targ(xpix, ypix) == 0
    targ(xpix, ypix) = 1;
else
    targ(xpix, ypix) = 0;
end

targHandle = displayTarget(targ, hObject);
set(hObject, 'UserData', targ);
set(targHandle, 'HitTest', 'off');

% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function beginTest_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to beginTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function beginTest_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to beginTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
