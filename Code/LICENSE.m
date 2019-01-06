function varargout = LICENSE(varargin)
% LICENSE MATLAB code for LICENSE.fig
%      LICENSE, by itself, creates a new LICENSE or raises the existing
%      singleton*.
%
%      H = LICENSE returns the handle to a new LICENSE or the handle to
%      the existing singleton*.
%
%      LICENSE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LICENSE.M with the given input arguments.
%
%      LICENSE('Property','Value',...) creates a new LICENSE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LICENSE_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LICENSE_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LICENSE

% Last Modified by GUIDE v2.5 20-Dec-2018 20:11:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LICENSE_OpeningFcn, ...
                   'gui_OutputFcn',  @LICENSE_OutputFcn, ...
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


% --- Executes just before LICENSE is made visible.
function LICENSE_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LICENSE (see VARARGIN)

% -- GLOBALS -- %
global slash
global resourcePath

% -- INSERT LOGO -- %
axes(handles.Logo)
[im, ~, alpha] = imread([resourcePath slash 'Logo.png']);
logo = imshow(im);
set(logo, 'AlphaData', alpha);

% -- CENTER PAGE -- %
set(handles.license,'Units', 'pixels');
screenSize = get(0, 'ScreenSize');
position = get(handles.license,'Position');
position(1) = (screenSize(3)-position(3))/2;
position(2) = (screenSize(4)-position(4))/2;
set(handles.license,'Position', position);

% -- SET LICENSE TEXT -- %
string = {'R2017b Update 9 (9.3.0.9483333)';...
    '';'Musaic allows you to see and understant sound in another way.';...
    '';'License ©2018 MUSAIC';...
    '';'Toolboxes used in MUSAIC:';...
    '';'-- Signal Processing Toolbox';'-- Image Processing Toolbox';'-- Computer Vision System Toolbox'};
set(handles.text,'String',string);

% Choose default command line output for LICENSE
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LICENSE wait for user response (see UIRESUME)
% uiwait(handles.license);


% --- Outputs from this function are returned to the command line.
function varargout = LICENSE_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
