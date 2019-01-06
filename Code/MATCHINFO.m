function varargout = MATCHINFO(varargin)
% MATCHINFO MATLAB code for MATCHINFO.fig
%      MATCHINFO, by itself, creates a new MATCHINFO or raises the existing
%      singleton*.
%
%      H = MATCHINFO returns the handle to a new MATCHINFO or the handle to
%      the existing singleton*.
%
%      MATCHINFO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MATCHINFO.M with the given input arguments.
%
%      MATCHINFO('Property','Value',...) creates a new MATCHINFO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MATCHINFO_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MATCHINFO_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MATCHINFO

% Last Modified by GUIDE v2.5 30-Dec-2018 12:09:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MATCHINFO_OpeningFcn, ...
                   'gui_OutputFcn',  @MATCHINFO_OutputFcn, ...
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


% --- Executes just before MATCHINFO is made visible.
function MATCHINFO_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MATCHINFO (see VARARGIN)

% -- GLOBALS -- %
global slash
global resourcePath

% -- CENTER PAGE -- %
set(handles.matchinfo,'Units', 'pixels');
screenSize = get(0, 'ScreenSize');
position = get(handles.matchinfo,'Position');
position(1) = (screenSize(3)-position(3))/2;
position(2) = (screenSize(4)-position(4))/2;
set(handles.matchinfo,'Position', position);

% -- SET INFORMATION -- %
axes(handles.image)
IM = imread([resourcePath slash 'matchinfo.png']);
imshow(IM);

% Choose default command line output for MATCHINFO
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MATCHINFO wait for user response (see UIRESUME)
% uiwait(handles.matchinfo);


% --- Outputs from this function are returned to the command line.
function varargout = MATCHINFO_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
