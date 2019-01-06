function varargout = BUILDINFO(varargin)
% BUILDINFO MATLAB code for BUILDINFO.fig
%      BUILDINFO, by itself, creates a new BUILDINFO or raises the existing
%      singleton*.
%
%      H = BUILDINFO returns the handle to a new BUILDINFO or the handle to
%      the existing singleton*.
%
%      BUILDINFO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BUILDINFO.M with the given input arguments.
%
%      BUILDINFO('Property','Value',...) creates a new BUILDINFO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BUILDINFO_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BUILDINFO_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BUILDINFO

% Last Modified by GUIDE v2.5 20-Dec-2018 20:07:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BUILDINFO_OpeningFcn, ...
                   'gui_OutputFcn',  @BUILDINFO_OutputFcn, ...
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


% --- Executes just before BUILDINFO is made visible.
function BUILDINFO_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BUILDINFO (see VARARGIN)

% -- GLOBALS -- %
global slash
global resourcePath

% -- CENTER PAGE -- %
set(handles.buildinfo,'Units', 'pixels');
screenSize = get(0, 'ScreenSize');
position = get(handles.buildinfo,'Position');
position(1) = (screenSize(3)-position(3))/2;
position(2) = (screenSize(4)-position(4))/2;
set(handles.buildinfo,'Position', position);

% -- SET INFORMATION -- %
axes(handles.image)
IM = imread([resourcePath slash 'buildinfo.png']);
imshow(IM);

% Choose default command line output for BUILDINFO
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BUILDINFO wait for user response (see UIRESUME)
% uiwait(handles.buildinfo);


% --- Outputs from this function are returned to the command line.
function varargout = BUILDINFO_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
