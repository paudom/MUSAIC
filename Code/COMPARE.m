function varargout = COMPARE(varargin)
% COMPARE MATLAB code for COMPARE.fig
%      COMPARE, by itself, creates a new COMPARE or raises the existing
%      singleton*.
%
%      H = COMPARE returns the handle to a new COMPARE or the handle to
%      the existing singleton*.
%
%      COMPARE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMPARE.M with the given input arguments.
%
%      COMPARE('Property','Value',...) creates a new COMPARE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before COMPARE_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to COMPARE_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help COMPARE

% Last Modified by GUIDE v2.5 22-Dec-2018 18:46:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @COMPARE_OpeningFcn, ...
                   'gui_OutputFcn',  @COMPARE_OutputFcn, ...
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


% --- Executes just before COMPARE is made visible.
function COMPARE_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to COMPARE (see VARARGIN)

% -- CENTER PAGE -- %
set(handles.figure1,'Units', 'pixels');
screenSize = get(0, 'ScreenSize');
position = get(handles.figure1,'Position');
position(1) = (screenSize(3)-position(3))/2;
position(2) = (screenSize(4)-position(4))/2;
set(handles.figure1,'Position', position);

% -- SET DEFAULT VALUES -- %
set(handles.mse,'String','0');
set(handles.method1,'String','None');
set(handles.numHarm1,'String','None');
set(handles.method2,'String','None');
set(handles.numHarm2,'String','None');
axes(handles.image1)
imshow(ones(360)*0.95);
axes(handles.image2)
imshow(ones(360)*0.95);
axes(handles.difference)
imshow(ones(360)*0.95);
handles.fileName1 = [];
handles.fileName2 = [];

% Choose default command line output for COMPARE
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes COMPARE wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = COMPARE_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in select1.
function select1_Callback(hObject, eventdata, handles)
% hObject    handle to select1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% -- GLOBALS -- %
global slash
global mosaicPath

% -- GET FILE -- %
handles.fileName1 = uigetfile({'*.png'},'Select a Musaic',mosaicPath);
fileName = [mosaicPath slash handles.fileName1];

if(handles.fileName1==0)
    msgbox('You have not selected any musaic.','Warning','warn');
else
    % -- PRESENT IMAGE -- %
    cla(handles.image1)
    axes(handles.image1)
    IM = imread(fileName);
    imshow(IM);

    % -- SET INFORMATION -- %
    str = strsplit(handles.fileName1,'.');
    str = strsplit(str{1},'_');
    method = str2double(str{2});
    numHarm = str{3};
    switch method
        case 1
            set(handles.method1,'String','Monophonic');
        case 2
            set(handles.method1,'String','Polyphonic');
        case 3
            set(handles.method1,'String','Ad.Polyphonic');
    end
    set(handles.numHarm1,'String',numHarm);

    % -- SAVE DATA -- %
    guidata(hObject,handles);
end

% --- Executes on button press in select2.
function select2_Callback(hObject, eventdata, handles)
% hObject    handle to select2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% -- GLOBALS -- %
global slash
global mosaicPath

% -- GET FILE -- %
handles.fileName2 = uigetfile({'*.png'},'Select a Musaic',mosaicPath);
fileName = [mosaicPath slash handles.fileName2];

if(handles.fileName2==0)
    msgbox('You have not selected any musaic.','Warning','warn');
else
    % -- PRESENT IMAGE -- %
    cla(handles.image2);
    axes(handles.image2)
    IM = imread(fileName);
    imshow(IM);

    % -- SET INFORMATION -- %
    str = strsplit(handles.fileName2,'.');
    str = strsplit(str{1},'_');
    method = str2double(str{2});
    numHarm = str{3};
    switch method
        case 1
            set(handles.method2,'String','Monophonic');
        case 2
            set(handles.method2,'String','Polyphonic');
        case 3
            set(handles.method2,'String','Ad.Polyphonic');
    end
    set(handles.numHarm2,'String',numHarm);

    % -- SAVE DATA -- %
    guidata(hObject,handles);
end

% --- Executes on button press in compare.
function compare_Callback(hObject, eventdata, handles)
% hObject    handle to compare (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% -- GLOBALS -- %
global slash
global mosaicPath

% -- EXECUTE -- %
if(isempty(handles.fileName1)||isempty(handles.fileName2))
     msgbox('Please select first the Musaics you want to compare.', 'Error','error');
else
    fileName1 = [mosaicPath slash handles.fileName1];
    fileName2 = [mosaicPath slash handles.fileName2];
    [MSE,ADF] = compare_mosaic(fileName1,fileName2);
    cla(handles.difference)
    axes(handles.difference)
    imshow(ADF);
    set(handles.mse,'String',num2str(MSE));
end

% -- SAVE DATA -- %
guidata(hObject,handles)

% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
% hObject    handle to back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hins = findobj('Name','COMPAREINFO');
if(~isempty(hins))
    close(hins)
end
delete(handles.figure1)
MUSAIC


% --------------------------------------------------------------------
function instructions_Callback(hObject, eventdata, handles)
% hObject    handle to instructions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
COMPAREINFO
