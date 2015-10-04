function varargout = cbox(varargin)
% CBOX MATLAB code for cbox.fig
%      CBOX, by itself, creates a new CBOX or raises the existing
%      singleton*.
%
%      H = CBOX returns the handle to a new CBOX or the handle to
%      the existing singleton*.
%
%      CBOX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CBOX.M with the given input arguments.
%
%      CBOX('Property','Value',...) creates a new CBOX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cbox_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cbox_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cbox

% Last Modified by GUIDE v2.5 04-Oct-2015 15:02:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cbox_OpeningFcn, ...
                   'gui_OutputFcn',  @cbox_OutputFcn, ...
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


% --- Executes just before cbox is made visible.
function cbox_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cbox (see VARARGIN)

% Choose default command line output for cbox
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cbox wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cbox_OutputFcn(hObject, eventdata, handles) 
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
