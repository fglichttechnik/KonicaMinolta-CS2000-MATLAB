function varargout = CS2000_chosePath(varargin)
%author Sandy Buschmann, Jan Winter TU Berlin
%email j.winter@tu-berlin.de
% CS2000_CHOSEPATH M-file for CS2000_chosePath.fig
%      CS2000_CHOSEPATH, by itself, creates a new CS2000_CHOSEPATH or raises the existing
%      singleton*.
%
%      H = CS2000_CHOSEPATH returns the handle to a new CS2000_CHOSEPATH or the handle to
%      the existing singleton*.
%
%      CS2000_CHOSEPATH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CS2000_CHOSEPATH.M with the given input arguments.
%
%      CS2000_CHOSEPATH('Property','Value',...) creates a new CS2000_CHOSEPATH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CS2000_chosePath_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CS2000_chosePath_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CS2000_chosePath

% Last Modified by GUIDE v2.5 13-Sep-2010 11:19:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CS2000_chosePath_OpeningFcn, ...
                   'gui_OutputFcn',  @CS2000_chosePath_OutputFcn, ...
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


% --- Executes just before CS2000_chosePath is made visible.
function CS2000_chosePath_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CS2000_chosePath (see VARARGIN)

% Choose default command line output for CS2000_chosePath
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

dir_name = pwd;
assignin('base', 'dir_name', dir_name);
set(handles.pathText, 'String', dir_name);

% UIWAIT makes CS2000_chosePath wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CS2000_chosePath_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pathButton.
function pathButton_Callback(hObject, eventdata, handles)
% hObject    handle to pathButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dir_name = uigetdir('start_pfad', 'dialog_titel');
assignin('base', 'dir_name', dir_name);
set(handles.pathText, 'String', dir_name);


function nameOfFile_Callback(hObject, eventdata, handles)
% hObject    handle to nameOfFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function nameOfFile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nameOfFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in saveButton.
function saveButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%create file...
file_name = get(handles.nameOfFile, 'String');
dir_name = evalin('base', 'dir_name');
file_name = [dir_name, '\', file_name];
assignin('base', 'file_name', file_name);
close(CS2000_chosePath);
