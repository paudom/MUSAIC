function varargout = BUILD(varargin)
% BUILD MATLAB code for BUILD.fig
%      BUILD, by itself, creates a new BUILD or raises the existing
%      singleton*.
%
%      H = BUILD returns the handle to a new BUILD or the handle to
%      the existing singleton*.
%
%      BUILD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BUILD.M with the given input arguments.
%
%      BUILD('Property','Value',...) creates a new BUILD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BUILD_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BUILD_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BUILD

% Last Modified by GUIDE v2.5 20-Dec-2018 20:02:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BUILD_OpeningFcn, ...
                   'gui_OutputFcn',  @BUILD_OutputFcn, ...
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


% --- Executes just before BUILD is made visible.
function BUILD_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BUILD (see VARARGIN)

% -- CENTER PAGE -- %
set(handles.figure1,'Units', 'pixels');
screenSize = get(0, 'ScreenSize');
position = get(handles.figure1,'Position');
position(1) = (screenSize(3)-position(3))/2;
position(2) = (screenSize(4)-position(4))/2;
set(handles.figure1,'Position', position);

% -- SET DEFAULT VALUES -- %
handles.default = ones(1,2050);
set(handles.numHarm,'Value',3);
set(handles.method,'Value',2);
set(handles.Status,'String','Not Ready');
axes(handles.musaic)
imshow(ones(360)*0.95);
axes(handles.octave);
histogram(handles.default,'FaceColor',[0.6 0.725 0.3921]);
xlim([0.5 8.5]);
title('OCTAVE HISTOGRAM');
axes(handles.note)
histogram(handles.default,'FaceColor',[0.98 0.682 0.102]);
xlim([0.5 12.5]);
title('NOTES HISTOGRAM');

% Choose default command line output for BUILD
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BUILD wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BUILD_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in selector.
function selector_Callback(hObject, eventdata, handles)
% hObject    handle to selector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% -- GLOBALS -- %
global musicPath

% -- GET FILE -- %
handles.fileName = uigetfile({'*.wav;*.m4a;*.mp3;*.ogg;*.flac;*.aiff'},'Select a Song',musicPath);
if(handles.fileName==0)
    msgbox('No song was selected.', 'Warning','warn');
    set(handles.Status,'String','Not Ready');
else
    set(handles.Status,'String','Ready');
end

% -- SAVE HANDLES -- %
guidata(hObject, handles);

% --- Executes on button press in build.
function build_Callback(hObject, eventdata, handles)
% hObject    handle to build (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
execute(hObject, eventdata, handles)

% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
% hObject    handle to back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hins = findobj('Name','BUILDINFO');
if(~isempty(hins))
    close(hins)
end
delete(handles.figure1)
MUSAIC

% --- Executes on selection change in numHarm.
function numHarm_Callback(hObject, eventdata, handles)
% hObject    handle to numHarm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns numHarm contents as cell array
%        contents{get(hObject,'Value')} returns selected item from numHarm


% --- Executes during object creation, after setting all properties.
function numHarm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numHarm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in method.
function method_Callback(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from method


% --- Executes during object creation, after setting all properties.
function method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function instructions_Callback(hObject, eventdata, handles)
% hObject    handle to instructions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
BUILDINFO

% --------------------------------------------------------------------
function execute(hObject, eventdata, handles)
% hObject    handle to instructions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% -- GLOBALS -- %
global slash
global musicPath
global mosaicPath

% -- EXECUTE -- %
status = get(handles.Status,'String');
switch status
    case 'Ready'
        % -- GET DATA -- %
        numHarm = get(handles.numHarm,'Value');
        method = get(handles.method,'Value');
        
        % -- TRANSFORM AUDIO INTO HSV IMAGE -- %
        [HSV,outFile,octave,note] = music2colour([musicPath slash handles.fileName],numHarm,method);

        % -- BUILD MOSAIC -- %
        M = build_mosaic(HSV,[mosaicPath slash outFile]);
        cla(handles.musaic)
        axes(handles.musaic)
        imshow(M)
        
        % -- SET STATISTICS -- %
        cla(handles.octave)
        axes(handles.octave)
        histogram(octave+1,'FaceColor',[0.6 0.725 0.3921]);
        xlim([0.5 8.5]);
        title('OCTAVE HISTOGRAM');
        cla(handles.note)
        axes(handles.note)
        histogram(note+1,'FaceColor',[0.98 0.682 0.102]);
        xlim([0.5 12.5]);
        title('NOTES HISTOGRAM');
    case 'Not Ready'
        msgbox('Build is not ready. Please make sure you have selected a song.', 'Error','error');
end

% -- SAVE HANDLES -- %
guidata(hObject, handles);
