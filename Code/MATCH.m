function varargout = MATCH(varargin)
% MATCH MATLAB code for MATCH.fig
%      MATCH, by itself, creates a new MATCH or raises the existing
%      singleton*.
%
%      H = MATCH returns the handle to a new MATCH or the handle to
%      the existing singleton*.
%
%      MATCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MATCH.M with the given input arguments.
%
%      MATCH('Property','Value',...) creates a new MATCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MATCH_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MATCH_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MATCH

% Last Modified by GUIDE v2.5 29-Dec-2018 15:19:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MATCH_OpeningFcn, ...
                   'gui_OutputFcn',  @MATCH_OutputFcn, ...
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


% --- Executes just before MATCH is made visible.
function MATCH_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MATCH (see VARARGIN)

% -- CENTER PAGE -- %
set(handles.figure1,'Units', 'pixels');
screenSize = get(0, 'ScreenSize');
position = get(handles.figure1,'Position');
position(1) = (screenSize(3)-position(3))/2;
position(2) = (screenSize(4)-position(4))/2;
set(handles.figure1,'Position', position);

% -- SET DEFAULT VALUES -- %
axes(handles.musaic)
imshow(ones(360)*0.95);
handles.default = zeros(1,100);
axes(handles.difference)
plot(handles.default);
ylim([0 1]);
set(handles.numHarm,'Value',3);
set(handles.method,'Value',2);
set(handles.Status,'String','Not Ready');
set(handles.songTitle,'String','None');
set(handles.error,'String','0');

% Choose default command line output for MATCH
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MATCH wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MATCH_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
% hObject    handle to back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hins = findobj('Name','MATCHINFO');
if(~isempty(hins))
    close(hins)
end
delete(handles.figure1)
MUSAIC

% --- Executes on button press in match.
function match_Callback(hObject, eventdata, handles)
% hObject    handle to match (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Execute(hObject,eventdata,handles);

% --- Executes on button press in select.
function select_Callback(hObject, eventdata, handles)
% hObject    handle to select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% -- GLOBALS -- %
global chunkPath

% -- GET FILE -- %
handles.fileName = uigetfile({'*.wav;*.mp3;*.ogg;*.flac;*.aiff'},'Select a sample chunk',chunkPath);
if(handles.fileName==0)
    msgbox('No sample was selected.', 'Warning','warn');
    set(handles.Status,'String','Not Ready');
else
    set(handles.Status,'String','Ready');
end

% -- SAVE HANDLES -- %
guidata(hObject, handles);

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
function Execute(hObject, eventdata, handles)
% hObject    handle to Instructions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% -- GLOBALS -- %
global slash
global chunkPath
global musicPath
global mosaicPath

% -- CHECK STATUS -- %
status = get(handles.Status,'String');
switch status
    case 'Ready'
        % -- MATCH CHUNK TO MUSAIC -- %
        numHarm = get(handles.numHarm,'Value');
        method = get(handles.method,'Value');
        [outFile,error,match] = match_mosaic([chunkPath slash handles.fileName],[mosaicPath slash],method,numHarm);
        if(~strcmp(outFile,'None'))
            w = waitbar(0,'PRESENTING RESULTS...');
            % -- SET RESULT VALUES -- %
            set(handles.error,'String',num2str(1-error));
            songTitle = strsplit(outFile,'_'); set(handles.songTitle,'String',songTitle{1});
            IM = imread([mosaicPath slash outFile]);
            waitbar(1/3,w,'PRESENTING MUSAIC...');
            % -- MARK MATCH -- %
            IM = mark_match(IM,match);
            cla(handles.musaic);
            axes(handles.musaic)
            imshow(IM)
            % -- SET DIFFERENCE PLOT -- %
            waitbar(2/3,w,'PRESENTING PLOT...');
            [x,~,~] = wave_format([chunkPath slash handles.fileName]);
            file = dir([musicPath slash songTitle{1} '.*']);
            [y,sampleRate,~] = wave_format([musicPath slash file.name]);
            time = 128E-3/2; frameLength = 2^nextpow2(time*sampleRate);
            numY = ceil(length(y)/frameLength); limitA = frameLength*match(1)-numY;
            y = y(limitA:limitA+length(x)-1);
            cla(handles.difference)
            axes(handles.difference)
            plot(abs(x-y)); axis tight;
            waitbar(1,w,'DONE');
            close(w);
            answer = questdlg('Would you like to listen the matched sound?','Play matched sound','No','Yes','Yes');
            switch answer
                case 'Yes'
                    y = resample(y,sampleRate*5,sampleRate);
                    sound(y,sampleRate*5)
            end
        else
            string = ['There are no Musaics computed with these parameters. '...
           'Please change the parameters or make sure there are Musaics with the selected parameters.'];
            msgbox(string,'Warning','warn')
        end
    case 'Not Ready'
        msgbox('Please select first a chunk to match with the musaics.','Error','error');
end

% -- SAVE DATA -- %
guidata(hObject,handles);

% --------------------------------------------------------------------
function Instructions_Callback(hObject, eventdata, handles)
% hObject    handle to Instructions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MATCHINFO
