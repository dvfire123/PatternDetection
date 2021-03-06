function varargout = previewStimulus(varargin)
% PREVIEWSTIMULUS MATLAB code for previewStimulus.fig
%      PREVIEWSTIMULUS, by itself, creates a new PREVIEWSTIMULUS or raises the existing
%      singleton*.
%
%      H = PREVIEWSTIMULUS returns the handle to a new PREVIEWSTIMULUS or the handle to
%      the existing singleton*.
%
%      PREVIEWSTIMULUS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PREVIEWSTIMULUS.M with the given input arguments.
%
%      PREVIEWSTIMULUS('Property','Value',...) creates a new PREVIEWSTIMULUS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before previewStimulus_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to previewStimulus_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help previewStimulus

% Last Modified by GUIDE v2.5 13-Oct-2015 14:07:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @previewStimulus_OpeningFcn, ...
                   'gui_OutputFcn',  @previewStimulus_OutputFcn, ...
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


% --- Executes just before previewStimulus is made visible.
function previewStimulus_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to previewStimulus (see VARARGIN)
global sHeight sWidth percentWhite;

%These are for updating the stimulus dimensions data
global dataFolder Inputs targ; 

[folder, ~, ~] = fileparts(mfilename('fullpath'));
if isdeployed
    folder = pwd;
end

userFolder = 'UserData';
dataFolder = fullfile(folder, userFolder);

Inputs = getappdata(BeginTest, 'userData');
set(BeginTest, 'Visible', 'off');
percentWhite = str2double(Inputs{3});
sHeight = str2double(Inputs{5});
sWidth = sHeight;
set(handles.sDim, 'String', num2str(sHeight));
set(handles.ws, 'String', num2str(percentWhite));
targ = getappdata(0, 'invTarg2');

axes(handles.previewStim);
getStimSample(sHeight, sWidth, percentWhite, targ, handles.previewStim);

% Choose default command line output for previewStimulus
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes previewStimulus wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = previewStimulus_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in okayButton.
function okayButton_Callback(hObject, eventdata, handles)
% hObject    handle to okayButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;



function sDim_Callback(hObject, eventdata, handles)
% hObject    handle to sDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sDim as text
%        str2double(get(hObject,'String')) returns contents of sDim as a double
global sHeight;
sDim = str2double(get(hObject, 'String'));
sHeight = max(10, min(sDim, 100));
set(hObject, 'String', num2str(sHeight));


% --- Executes during object creation, after setting all properties.
function sDim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in changeButton.
function changeButton_Callback(hObject, eventdata, handles)
% hObject    handle to changeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sHeight sWidth percentWhite;
global Inputs targ dataFolder;
Inputs{5} = num2str(sHeight);
Inputs{3} = num2str(percentWhite);
updateUserData(Inputs, dataFolder);
setappdata(BeginTest, 'userData', Inputs);
set(BeginTest, 'visible', 'off');

sWidth = sHeight;
axes(handles.previewStim);
getStimSample(sHeight, sWidth, percentWhite, targ, handles.previewStim);


function ws_Callback(hObject, eventdata, handles)
% hObject    handle to ws (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ws as text
%        str2double(get(hObject,'String')) returns contents of ws as a double
global percentWhite;
ws = str2double(get(hObject, 'String'));
percentWhite = max(0, min(ws, 100));
set(hObject, 'String', num2str(percentWhite));


% --- Executes during object creation, after setting all properties.
function ws_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ws (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
