function varargout = BeginTest(varargin)
% BEGINTEST MATLAB code for BeginTest.fig
%      BEGINTEST, by itself, creates a new BEGINTEST or raises the existing
%      singleton*.
%
%      H = BEGINTEST returns the handle to a new BEGINTEST or the handle to
%      the existing singleton*.
%
%      BEGINTEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEGINTEST.M with the given input arguments.
%
%      BEGINTEST('Property','Value',...) creates a new BEGINTEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BeginTest_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BeginTest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BeginTest

% Last Modified by GUIDE v2.5 04-Oct-2015 17:53:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BeginTest_OpeningFcn, ...
                   'gui_OutputFcn',  @BeginTest_OutputFcn, ...
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


% --- Executes just before BeginTest is made visible.
function BeginTest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BeginTest (see VARARGIN)

%Most recent datavpath = null
global latestData;

dataFolder = 'UserData';
latestDataFile = 'latest.txt';
if ~exist(dataFolder, 'dir')
   mkdir(dataFolder); 
end

latestData = fullfile(dataFolder, latestDataFile);
if ~exist(latestData, 'file')
   fid = fopen(latestData, 'wt+'); 
   fclose(fid);
end

fid = fopen(latestData, 'r');
latestFile = fgetl(fid);
fclose(fid);

if ischar(latestFile)
    %There is latest file path
    %Load it
    A = loadUserData(latestFile);
    setappdata(gcf, 'userData', A);
    
    set(handles.lnLabel, 'String', A{2});
    set(handles.fnLabel, 'String', A{1});
    set(handles.wsLabel, 'String', A{3});
    set(handles.pLabel, 'String', A{4});
    set(handles.dimLabel, 'String', A{5});
    set(handles.nsLabel, 'String', A{6});
else
    set(handles.okayButton, 'enable', 'off');
end

% Choose default command line output for BeginTest
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BeginTest wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BeginTest_OutputFcn(hObject, eventdata, handles) 
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
figure(DrawTarget);
set(gcbf, 'Visible', 'off');


% --- Executes on button press in quitButton.
function quitButton_Callback(hObject, eventdata, handles)
% hObject    handle to quitButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcbf);


% --- Executes on button press in loadDataButton.
function loadDataButton_Callback(hObject, eventdata, handles)
% hObject    handle to loadDataButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global latestData;

[fileName, pathName] = uigetfile('*.din', 'Please Select a .din file');
file = fullfile(pathName, fileName);

%update latest file
fid = fopen(latestData, 'rt+');
fprintf(fid, '%s', file);
fclose(fid);

A = loadUserData(file);
setappdata(gcbf, 'userData', A);

%This section updates the info on the begin test panel
set(handles.lnLabel, 'String', A{2});
set(handles.fnLabel, 'String', A{1});
set(handles.wsLabel, 'String', A{3});
set(handles.pLabel, 'String', A{4});
set(handles.dimLabel, 'String', A{5});
set(handles.nsLabel, 'String', A{6});

%Turn on Begin Test Button
okHandle = findobj(BeginTest, 'Tag', 'okayButton');
set(okHandle, 'Enable', 'on');

% --- Executes on button press in enterDataButton.
function enterDataButton_Callback(hObject, eventdata, handles)
% hObject    handle to enterDataButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure(EnterDataBox);


% --- Executes on button press in credits.
function credits_Callback(hObject, eventdata, handles)
% hObject    handle to credits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure(cbox);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over titleLabel.
function titleLabel_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to titleLabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
