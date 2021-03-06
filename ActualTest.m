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

% Last Modified by GUIDE v2.5 08-Oct-2015 12:01:44

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
global percentWhite sHeight sWidth prob Ns dispTime waitTime;
global waitTimer dispTimer timeLeft;
global targ;
global outFile correct totTime;

%Load parameters
Inputs = getappdata(BeginTest, 'userData');
set(BeginTest, 'Visible', 'off');
percentWhite = str2double(Inputs{3});
prob = str2double(Inputs{4});
sHeight = str2double(Inputs{5});
sWidth = sHeight;
Ns = str2double(Inputs{6});
dispTime = str2double(Inputs{7});
waitTime = str2double(Inputs{8});

set(handles.timerText, 'String', num2str(waitTime));

correct = 0;
totTime = 0;

%plot the patterns
targ = getappdata(0, 'targ');
invTarg = getappdata(0, 'invTarg');
displayTarget(invTarg, handles.targetReminder);

axes(handles.stimulus);
delete(get(handles.stimulus, 'Children'));
hold on;
res = genStimulus(prob, sHeight, sWidth, percentWhite, targ, handles.stimulus);
set(gcf, 'UserData', res);

%Next we are going to store some more data:
testNum = 1;
s = sprintf('Test: %d/%d', testNum, Ns);
set(handles.testCountLabel, 'String', s);
set(handles.testCountLabel, 'UserData', testNum);

% Choose default command line output for ActualTest
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%%Create the output folder%%
[folder, ~, ~] = fileparts(mfilename('fullpath'));
if isdeployed
    folder = pwd;
end
resFolder = 'Results';
resFolder = fullfile(folder, resFolder);
if ~exist(resFolder, 'dir')
    mkdir(resFolder);
end

ln = Inputs{2};
fn = Inputs{1};

fileName = sprintf('%s-%s-out.txt', fn, ln);
outFile = fullfile(resFolder, fileName);

fid = fopen(outFile, 'at');
fprintf(fid, 'Name: %s, %s\n', ln, fn);
fprintf(fid, '%s\n', datestr(now));
fprintf(fid, '\nTest Parameters:\n');
fprintf(fid, 'Stimulus no. of dots per dimension: %d\n', sHeight);
fprintf(fid, 'Percentage of whitespace: %f\n', percentWhite);
fprintf(fid, 'Probability of target presence: %f\n', prob);
fprintf(fid, 'Number of trials: %d\n', Ns);
fprintf(fid, 'Display Time for each stimulus: %f sec\n', dispTime);
fprintf(fid, 'Wait time between consecutive trials: %f sec\n', waitTime);
fprintf(fid, '\n');
fclose(fid);

%Now we have to set up the timer before displaying the
%stimulus
waitTimer = timer;
waitTimer.period = 1;
set(waitTimer,'ExecutionMode','fixedrate','StartDelay',1);
set(waitTimer, 'TimerFcn', {@countDown, handles});
set(waitTimer, 'StopFcn', {@timesup, handles});

%Set up display timer, but of course don't start it until wait timer
%is done
dispTimer = timer;
dispTimer.period = 1;
set(dispTimer,'ExecutionMode','fixedrate','StartDelay', 0);
set(dispTimer, 'TimerFcn', {@dispTimeGoing, handles});
set(dispTimer, 'StopFcn', {@dispTimesUp, handles});
timeLeft = dispTime;

%begin the actual test
start(waitTimer);

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
response(hObject, eventdata, handles, 1);


% --- Executes on button press in noButton.
function noButton_Callback(hObject, eventdata, handles)
% hObject    handle to noButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
response(hObject, eventdata, handles, 0);

% --- Executes on mouse press over axes background.
function stimulus_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to stimulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%---Timer Callbacks---
%wait timer callbacks
function countDown(hObject, eventdata, handles)
global waitTimer dispTimer;
stop(dispTimer);
c = str2double(get(handles.timerText, 'String'));
c = c - 1;
set(handles.timerText, 'String', num2str(c));
if c <= 0
   stop(waitTimer); 
end

function timesup(hObject, eventdata, handles)
set(handles.yesButton, 'Enable', 'on');
set(handles.noButton, 'Enable', 'on');
set(handles.timerText, 'Visible', 'off');
restartDispTimer(handles)
tic;

function restartWaitTimer(handles)
global waitTimer waitTime;
set(handles.yesButton, 'Enable', 'off');
set(handles.noButton, 'Enable', 'off');
set(handles.timerText, 'String', num2str(waitTime));
set(handles.timerText, 'Visible', 'on');
start(waitTimer);

%Display timer callbacks
function dispTimesUp(hObject, eventdata, handles)
%Empty function

function dispTimeGoing(hObject, eventdata, handles)
global dispTimer timeLeft;
timeLeft = timeLeft - 1;
if timeLeft < 0
    stop(dispTimer);
    drawBlankStim(handles);
end

function restartDispTimer(handles)
global dispTimer timeLeft dispTime;
timeLeft = dispTime;
start(dispTimer);

%%Helpers
%Records User Response
function response(hObject, eventdata, handles, isYes)
global percentWhite sHeight sWidth prob targ Ns;
global outFile correct totTime dispTimer;
stop(dispTimer);

timeSpent = toc;
totTime = totTime + timeSpent;

axes(handles.stimulus);
delete(get(handles.stimulus, 'Children'));
hold on;

%Record response:
testNum = get(handles.testCountLabel, 'UserData');
res = get(gcbf, 'UserData');

resStr = 'No';
if res == 1
    resStr = 'Yes';
end

userStr = 'No';
if isYes == 1
    userStr = 'Yes';
end

if res == isYes
    correct = correct + 1;
end

s = sprintf('Trial %d of %d\tUser: %s\tActual: %s\tResponse time: %f sec',...
    testNum, Ns, userStr, resStr, timeSpent);
fid = fopen(outFile, 'at');
fprintf(fid, '%s', s);
fprintf(fid, '\n');
fclose(fid);

testNum = testNum + 1;

if testNum > Ns
   hitRate = 100*correct/Ns;
   avgTime = totTime/Ns;
   fid = fopen(outFile, 'at');
   fprintf(fid, '\nYou got %d out of %d correct\n', correct, Ns);
   fprintf(fid, 'Hit Rate: %f percent\n', hitRate);
   fprintf(fid, 'Average response time: %f sec\n', avgTime);
   fprintf(fid, '----------\n');
   fclose(fid);
   
   close(gcbf);
   close(BeginTest);
   figure(BeginTest);
else
    s = sprintf('Test: %d/%d', testNum, Ns);
    set(handles.testCountLabel, 'String', s);
    set(handles.testCountLabel, 'UserData', testNum);
    restartWaitTimer(handles);
    res = genStimulus(prob, sHeight, sWidth, percentWhite, targ, handles.stimulus);
    set(gcbf, 'UserData', res);
end

%draw blank stimulus
function drawBlankStim(handles)
global sHeight sWidth;
axes(handles.stimulus);
delete(get(handles.stimulus, 'Children'));
hold on;
blankStimulus(sHeight, sWidth, handles.stimulus);


% --- Executes on key press with focus on actualTest or any of its controls.
function actualTest_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to actualTest (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
switch eventdata.Key
  case 'y'
     if strcmp(get(handles.yesButton, 'Enable'), 'on')
        yesButton_Callback(hObject, eventdata, handles) 
     end
  case 'n'
      if strcmp(get(handles.noButton, 'Enable'), 'on')
        noButton_Callback(hObject, eventdata, handles)
      end
end


% --- Executes during object deletion, before destroying properties.
function actualTest_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to actualTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
