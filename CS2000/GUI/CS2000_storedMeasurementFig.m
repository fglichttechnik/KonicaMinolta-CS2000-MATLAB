function varargout = CS2000_storedMeasurementFig(varargin)
% CS2000_STOREDMEASUREMENTFIG M-file for CS2000_storedMeasurementFig.fig
%      CS2000_STOREDMEASUREMENTFIG, by itself, creates a new CS2000_STOREDMEASUREMENTFIG or raises the existing
%      singleton*.
%
%      H = CS2000_STOREDMEASUREMENTFIG returns the handle to a new CS2000_STOREDMEASUREMENTFIG or the handle to
%      the existing singleton*.
%
%      CS2000_STOREDMEASUREMENTFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CS2000_STOREDMEASUREMENTFIG.M with the given input arguments.
%
%      CS2000_STOREDMEASUREMENTFIG('Property','Value',...) creates a new CS2000_STOREDMEASUREMENTFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CS2000_storedMeasurementFig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CS2000_storedMeasurementFig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CS2000_storedMeasurementFig

% Last Modified by GUIDE v2.5 16-Dec-2010 15:24:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CS2000_storedMeasurementFig_OpeningFcn, ...
                   'gui_OutputFcn',  @CS2000_storedMeasurementFig_OutputFcn, ...
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


% --- Executes just before CS2000_storedMeasurementFig is made visible.
function CS2000_storedMeasurementFig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CS2000_storedMeasurementFig (see VARARGIN)

% Choose default command line output for CS2000_storedMeasurementFig
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% use last dir_name if exists:
exdir = evalin('base', 'exist(''dir_name'',''var'')');
if exdir == 0    
    dir_name = pwd;
    assignin('base', 'dir_name', dir_name);    
else
    dir_name = evalin('base', 'dir_name');
end
set(handles.pathText, 'String', dir_name);

% use las file_name if exists:
exfile = evalin('base', 'exist(''file_name'', ''var'')');
if exfile == 0
    file_name = 'measurement01';
    assignin('base', 'file_name', file_name);
else
    file_name = evalin('base', 'file_name');
end
set(handles.filenameText, 'String', file_name);

% UIWAIT makes CS2000_storedMeasurementFig wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CS2000_storedMeasurementFig_OutputFcn(hObject, eventdata, handles) 
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
set(handles.pathText, 'String', dir_name);
assignin('base', 'dir_name', dir_name);



function filenameText_Callback(hObject, eventdata, handles)
% hObject    handle to filenameText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file_name = get(handles.filenameText, 'String');
assignin('base', 'file_name', file_name);


% --- Executes during object creation, after setting all properties.
function filenameText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filenameText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in saveButton.
function saveButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dir_name = get(handles.pathText, 'String');
assignin('base', 'dir_name', dir_name);
delete_check = 0;
assignin('base', 'delete_check', delete_check);
close(CS2000_storedMeasurementFig);


% --- Executes on button press in exitButton.
function exitButton_Callback(hObject, eventdata, handles)
% hObject    handle to exitButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dir_name = '';
assignin('base', 'dir_name', dir_name);
delete_check = 0;
assignin('base', 'delete_check', delete_check);
close(CS2000_storedMeasurementFig);



% --- Executes on button press in deleteButton.
function deleteButton_Callback(hObject, eventdata, handles)
% hObject    handle to deleteButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choice = questdlg('Do you really want to delete all stored data from the camera?', ...
                    'Question', ...
                    'YES','NO, quit', 'NO, quit');
                    % Handle response
                    switch choice
                        case 'YES'
                            delete_check = 1;                    		
                        case 'NO, quit'
                            delete_check = 0;                    
                        otherwise
                            delete_check = 0;
                    end   
dir_name = '';
assignin('base', 'dir_name', dir_name);
assignin('base', 'delete_check', delete_check);
close(CS2000_storedMeasurementFig);
