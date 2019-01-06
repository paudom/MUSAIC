function varargout = COMPAREINFO(varargin)
% COMPAREINFO MATLAB code for COMPAREINFO.fig
%      COMPAREINFO, by itself, creates a new COMPAREINFO or raises the existing
%      singleton*.
%
%      H = COMPAREINFO returns the handle to a new COMPAREINFO or the handle to
%      the existing singleton*.
%
%      COMPAREINFO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMPAREINFO.M with the given input arguments.
%
%      COMPAREINFO('Property','Value',...) creates a new COMPAREINFO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before COMPAREINFO_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to COMPAREINFO_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help COMPAREINFO

% Last Modified by GUIDE v2.5 23-Dec-2018 11:59:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @COMPAREINFO_OpeningFcn, ...
                   'gui_OutputFcn',  @COMPAREINFO_OutputFcn, ...
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


% --- Executes just before COMPAREINFO is made visible.
function COMPAREINFO_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to COMPAREINFO (see VARARGIN)

% -- GLOBALS -- %
global slash
global resourcePath

% -- CENTER PAGE -- %
set(handles.compareinfo,'Units', 'pixels');
screenSize = get(0, 'ScreenSize');
position = get(handles.compareinfo,'Position');
position(1) = (screenSize(3)-position(3))/2;
position(2) = (screenSize(4)-position(4))/2;
set(handles.compareinfo,'Position', position);

% -- SET INFORMATION -- %
axes(handles.image)
IM = imread([resourcePath slash 'compareinfo.png']);
imshow(IM);

% Choose default command line output for COMPAREINFO
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes COMPAREINFO wait for user response (see UIRESUME)
% uiwait(handles.compareinfo);


% --- Outputs from this function are returned to the command line.
function varargout = COMPAREINFO_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
