function varargout = EnterDataBox(varargin)
% ENTERDATABOX MATLAB code for EnterDataBox.fig
%      ENTERDATABOX, by itself, creates a new ENTERDATABOX or raises the existing
%      singleton*.
%
%      H = ENTERDATABOX returns the handle to a new ENTERDATABOX or the handle to
%      the existing singleton*.
%
%      ENTERDATABOX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENTERDATABOX.M with the given input arguments.
%
%      ENTERDATABOX('Property','Value',...) creates a new ENTERDATABOX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EnterDataBox_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EnterDataBox_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EnterDataBox

% Last Modified by GUIDE v2.5 04-Oct-2015 17:33:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EnterDataBox_OpeningFcn, ...
                   'gui_OutputFcn',  @EnterDataBox_OutputFcn, ...
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


% --- Executes just before EnterDataBox is made visible.
function EnterDataBox_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EnterDataBox (see VARARGIN)

%Load latest save info if exists
global dataFolder latestData; 
[folder, ~, ~] = fileparts(mfilename('fullpath'));
userFolder = 'UserData';
dataFolder = fullfile(folder, userFolder);

latestDataFile = 'latest.txt';

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
    set(handles.lastName, 'String', A{2});
    set(handles.firstName, 'String', A{1});
    set(handles.wspace, 'String', A{3});
    set(handles.p, 'String', A{4});
    set(handles.sDim, 'String', A{5});
    set(handles.Ns, 'String', A{6});
end

% Choose default command line output for EnterDataBox
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EnterDataBox wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EnterDataBox_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function lastName_Callback(hObject, eventdata, handles)
% hObject    handle to lastName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lastName as text
%        str2double(get(hObject,'String')) returns contents of lastName as a double


% --- Executes during object creation, after setting all properties.
function lastName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lastName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function firstName_Callback(hObject, eventdata, handles)
% hObject    handle to firstName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of firstName as text
%        str2double(get(hObject,'String')) returns contents of firstName as a double



% --- Executes during object creation, after setting all properties.
function firstName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to firstName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function wspace_Callback(hObject, eventdata, handles)
% hObject    handle to wspace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wspace as text
%        str2double(get(hObject,'String')) returns contents of wspace as a double


% --- Executes during object creation, after setting all properties.
function wspace_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wspace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p_Callback(hObject, eventdata, handles)
% hObject    handle to p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p as text
%        str2double(get(hObject,'String')) returns contents of p as a double


% --- Executes during object creation, after setting all properties.
function p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sDim_Callback(hObject, eventdata, handles)
% hObject    handle to sDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sDim as text
%        str2double(get(hObject,'String')) returns contents of sDim as a double


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

% --- Executes during object creation, after setting all properties.
function sWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in okayButton.
function okayButton_Callback(hObject, eventdata, handles)
% hObject    handle to okayButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Save user data
global dataFolder latestData;
file = saveUserData(gcbf, dataFolder);

%write latest save path to latest.dat
fid = fopen(latestData, 'rt+');
fprintf(fid, '%s', file);
fclose(fid);

%load saved file
A = loadUserData(file);
setappdata(BeginTest, 'userData', A);

%This section updates the info on the begin test panel
lnHandle = findobj(BeginTest, 'Tag', 'lnLabel');
fnHandle = findobj(BeginTest, 'Tag', 'fnLabel');
wsHandle = findobj(BeginTest, 'Tag', 'wsLabel');
probHandle = findobj(BeginTest, 'Tag', 'pLabel');
dimHandle = findobj(BeginTest, 'Tag', 'dimLabel');
nsHandle = findobj(BeginTest, 'Tag', 'nsLabel');

set(lnHandle, 'String', A{2});
set(fnHandle, 'String', A{1});
set(wsHandle, 'String', A{3});
set(probHandle, 'String', A{4});
set(dimHandle, 'String', A{5});
set(nsHandle, 'String', A{6});

%Turn on Begin Test Button
okHandle = findobj(BeginTest, 'Tag', 'okayButton');
set(okHandle, 'Enable', 'on');

close(gcbf);

% --- Executes on button press in cancelButton.
function cancelButton_Callback(hObject, eventdata, handles)
% hObject    handle to cancelButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcbf);


function Ns_Callback(hObject, eventdata, handles)
% hObject    handle to Ns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ns as text
%        str2double(get(hObject,'String')) returns contents of Ns as a double


% --- Executes during object creation, after setting all properties.
function Ns_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
