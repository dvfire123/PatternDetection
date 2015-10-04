function varargout = ActualTest(varargin)
% ACTUALTEST MATLAB code for ActualTest.fig
%      ACTUALTEST, by itself, creates a new ACTUALTEST or raises the existing
%      singleton*.
%
%      H = ACTUALTEST returns the handle to a new ACTUALTEST or the handle to
%      the existing singleton*.
%
%      ACTUALTEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ACTUALTEST.M with the given input arguments.
%
%      ACTUALTEST('Property','Value',...) creates a new ACTUALTEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ActualTest_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ActualTest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ActualTest

% Last Modified by GUIDE v2.5 30-Sep-2015 21:19:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ActualTest_OpeningFcn, ...
                   'gui_OutputFcn',  @ActualTest_OutputFcn, ...
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


% --- Executes just before ActualTest is made visible.
function ActualTest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ActualTest (see VARARGIN)
global percentWhite sHeight sWidth prob targ;

%Set up the stimulus
percentWhite = 90;
sHeight = 50;
sWidth = sHeight;

%Prob. of target in stim
prob = 0.7;

%plot the patterns
targ = getappdata(0, 'targ');
invTarg = getappdata(0, 'invTarg');
displayTarget(invTarg, handles.targetReminder);

axes(handles.stimulus);
delete(get(handles.stimulus, 'Children'));
hold on;
genStimulus(prob, sHeight, sWidth, percentWhite, targ, handles.stimulus);

%Next we are going to store some more data:
NS = 10;
set(handles.stimulusLabel, 'UserData', NS);
testNum = 1;
s = sprintf('Test: %d/%d', testNum, NS);
set(handles.testCountLabel, 'String', s);
set(handles.testCountLabel, 'UserData', testNum);

% Choose default command line output for ActualTest
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ActualTest wait for user response (see UIRESUME)
% uiwait(handles.actualTest);


% --- Outputs from this function are returned to the command line.
function varargout = ActualTest_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in yesButton.
function yesButton_Callback(hObject, eventdata, handles)
% hObject    handle to yesButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Gets the next image
global percentWhite sHeight sWidth prob targ;

axes(handles.stimulus);
delete(get(handles.stimulus, 'Children'));
hold on;
genStimulus(prob, sHeight, sWidth, percentWhite, targ, handles.stimulus);

%TODO: record yes response
testNum = get(handles.testCountLabel, 'UserData');
NS = get(handles.stimulusLabel, 'UserData');
testNum = testNum + 1;

if testNum > NS
   figure(BeginTest);
   close(ActualTest);
else
    s = sprintf('Test: %d/%d', testNum, NS);
    set(handles.testCountLabel, 'String', s);
    set(handles.testCountLabel, 'UserData', testNum);
end


% --- Executes on button press in noButton.
function noButton_Callback(hObject, eventdata, handles)
% hObject    handle to noButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Gets the next image
global percentWhite sHeight sWidth prob targ;

axes(handles.stimulus);
delete(get(handles.stimulus, 'Children'));
hold on;
genStimulus(prob, sHeight, sWidth, percentWhite, targ, handles.stimulus);

%TODO: record no response
testNum = get(handles.testCountLabel, 'UserData');
testNum = testNum + 1;
NS = get(handles.stimulusLabel, 'UserData');

if testNum > NS
   figure(BeginTest);
   close(ActualTest);
else
    s = sprintf('Test: %d/%d', testNum, NS);
    set(handles.testCountLabel, 'String', s);
    set(handles.testCountLabel, 'UserData', testNum);
end

% --- Executes on mouse press over axes background.
function stimulus_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to stimulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
