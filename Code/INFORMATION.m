function varargout = INFORMATION(varargin)
% INFORMATION MATLAB code for INFORMATION.fig
%      INFORMATION, by itself, creates a new INFORMATION or raises the existing
%      singleton*.
%
%      H = INFORMATION returns the handle to a new INFORMATION or the handle to
%      the existing singleton*.
%
%      INFORMATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INFORMATION.M with the given input arguments.
%
%      INFORMATION('Property','Value',...) creates a new INFORMATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before INFO_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to INFO_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help INFORMATION

% Last Modified by GUIDE v2.5 20-Dec-2018 20:10:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @INFO_OpeningFcn, ...
                   'gui_OutputFcn',  @INFO_OutputFcn, ...
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


% --- Executes just before INFORMATION is made visible.
function INFO_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to INFORMATION (see VARARGIN)

% -- GLOBALS -- %
global slash
global resourcePath

% -- INSERT LOGO -- %
axes(handles.Logo)
[im, ~, alpha] = imread([resourcePath slash 'Logo.png']);
logo = imshow(im);
set(logo, 'AlphaData', alpha);

% -- CENTER PAGE -- %
set(handles.info,'Units', 'pixels');
screenSize = get(0, 'ScreenSize');
position = get(handles.info,'Position');
position(1) = (screenSize(3)-position(3))/2;
position(2) = (screenSize(4)-position(4))/2;
set(handles.info,'Position', position);

% -- SET INFORMATION TEXT -- %
axes(handles.image)
IM = imread([resourcePath slash 'info.png']);
imshow(IM)

% Choose default command line output for INFORMATION
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes INFORMATION wait for user response (see UIRESUME)
% uiwait(handles.information);


% --- Outputs from this function are returned to the command line.
function varargout = INFO_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
