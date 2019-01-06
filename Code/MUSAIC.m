function varargout = MUSAIC(varargin)
% MUSAIC MATLAB code for MUSAIC.fig
%      MUSAIC, by itself, creates a new MUSAIC or raises the existing
%      singleton*.
%
%      H = MUSAIC returns the handle to a new MUSAIC or the handle to
%      the existing singleton*.
%
%      MUSAIC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MUSAIC.M with the given input arguments.
%
%      MUSAIC('Property','Value',...) creates a new MUSAIC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MUSAIC_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MUSAIC_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MUSAIC

% Last Modified by GUIDE v2.5 20-Dec-2018 20:02:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MUSAIC_OpeningFcn, ...
                   'gui_OutputFcn',  @MUSAIC_OutputFcn, ...
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


% --- Executes just before MUSAIC is made visible.
function MUSAIC_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MUSAIC (see VARARGIN)

% -- GLOBALS -- %
global slash
global resourcePath
global musicPath
global mosaicPath
global chunkPath

% -- DEFINING GLOBALS -- %
slash = check_os();
resourcePath = [pwd slash 'Resources'];
musicPath = [pwd slash 'MusicFiles'];
mosaicPath = [pwd slash 'Mosaics'];
chunkPath = [pwd slash 'SampleChunks'];

% -- INSERT LOGO -- %
axes(handles.Logo)
[im, ~, alpha] = imread([resourcePath slash 'Logo.png']);
logo = imshow(im);
set(logo, 'AlphaData', alpha);

% -- CENTER PAGE -- %
set(handles.figure1,'Units', 'pixels');
screenSize = get(0, 'ScreenSize');
position = get(handles.figure1,'Position');
position(1) = (screenSize(3)-position(3))/2;
position(2) = (screenSize(4)-position(4))/2;
set(handles.figure1,'Position', position);

% Choose default command line output for MUSAIC
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MUSAIC wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MUSAIC_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in BUILD.
function BUILD_Callback(hObject, eventdata, handles)
% hObject    handle to BUILD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hlicense = findobj('Name','LICENSE');
hinfo = findobj('Name','INFO');
if(~isempty(hlicense))
    close(hlicense)
end
if(~isempty(hinfo))
    close(hinfo)
end
delete(handles.figure1)
BUILD

% --- Executes on button press in COMPARE.
function COMPARE_Callback(hObject, eventdata, handles)
% hObject    handle to COMPARE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hlicense = findobj('Name','LICENSE');
hinfo = findobj('Name','INFO');
if(~isempty(hlicense))
    close(hlicense)
end
if(~isempty(hinfo))
    close(hinfo)
end
delete(handles.figure1)
COMPARE

% --- Executes on button press in MATCH.
function MATCH_Callback(hObject, eventdata, handles)
% hObject    handle to MATCH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mosaicPath
global slash
numFiles = dir([mosaicPath slash '*.png']);
if(~isempty(numFiles))
    hlicense = findobj('Name','LICENSE');
    hinfo = findobj('Name','INFO');
    if(~isempty(hlicense))
        close(hlicense)
    end
    if(~isempty(hinfo))
        close(hinfo)
    end
    delete(handles.figure1)
    MATCH
else
   msgbox('There are no Musaics created. Please make sure you first Build Musaics', 'Warning','warn'); 
end

% --------------------------------------------------------------------
function musaic_tab_Callback(hObject, eventdata, handles)
% hObject    handle to musaic_tab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function about_tab_Callback(hObject, eventdata, handles)
% hObject    handle to about_tab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
LICENSE

% --------------------------------------------------------------------
function info_tab_Callback(hObject, eventdata, handles)
% hObject    handle to info_tab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
INFORMATION
