function varargout = CS2000_menue(varargin)
%author Sandy Buschmann, Jan Winter TU Berlin
%email j.winter@tu-berlin.de
% CS2000_MENUE M-file for CS2000_menue.fig
%      CS2000_MENUE, by itself, creates a new CS2000_MENUE or raises the existing
%      singleton*.
%
%      H = CS2000_MENUE returns the handle to a new CS2000_MENUE or the handle to
%      the existing singleton*.
%
%      CS2000_MENUE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CS2000_MENUE.M with the given input arguments.
%
%      CS2000_MENUE('Property','Value',...) creates a new CS2000_MENUE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CS2000_menue_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CS2000_menue_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CS2000_menue

% Last Modified by GUIDE v2.5 01-Oct-2010 18:12:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CS2000_menue_OpeningFcn, ...
                   'gui_OutputFcn',  @CS2000_menue_OutputFcn, ...
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


% --- Executes just before CS2000_menue is made visible.
function CS2000_menue_OpeningFcn(hObject, eventdata, handles, varargin)

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CS2000_menue (see VARARGIN)

% Choose default command line output for CS2000_menue
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

message = evalin('base', 'message');
set(handles.openText, 'String', message);
filter_value = CS2000_readNDFilter +1;
set(handles.NDfilterMenu, 'Value', filter_value);



% --- Outputs from this function are returned to the command line.
function varargout = CS2000_menue_OutputFcn(hObject, eventdata, handles) 

% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% ---------------------'File'-Menue: ------------------------------
% --------------------------------------------------------------------
function file_menue_Callback(hObject, eventdata, handles)
% hObject    handle to file_menue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function save_menue_Callback(hObject, eventdata, handles)
% hObject    handle to save_menue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CS2000_chosePath;
uiwait(CS2000_chosePath);
file_name = evalin('base', 'file_name');
numMeas = evalin('base', 'numMeas');
measurements = evalin('base', 'measurements');
% save in one .mat file:
for i = 1 : numMeas
    measurements{i}.comments = get(handles.commentsEdit, 'String');
    measurements{i}.lightSource = get(handles.lightSourceEdit, 'String');
end
save(file_name, 'measurements');

% --------------------------------------------------------------------
function exit_menue_Callback(hObject, eventdata, handles)
% hObject    handle to exit_menue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg('Close this figure and terminate connection?',...
      'Close Request Function',...
      'Yes','No','Yes'); 
   switch selection, 
      case 'Yes',
        message = CS2000_terminateConnection();
        set(handles.openText, 'String', message); 
        pause(2);
        delete(hObject);
        evalin('base', 'clear');
        delete(gcf)        
      case 'No'
      return 
   end
% --------------------------------------------------------------------
% --------------------------------------------------------------------


% --- Executes on button press in startMeasure. Button "measure"
function startMeasure_Callback(hObject, eventdata, handles)
% hObject    handle to startMeasure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CS2000_rubber(handles); 
pause(0.1);
numMeas = str2double(get(handles.numberOfMeas, 'String'));
assignin('base', 'numMeas', numMeas);
measurements = cell(numMeas,1);
for i = 1 : numMeas    
    % measure
    set(handles.measureText, 'String', 'measuring...');
    pause(0.1);
    [message1, message2, measuredData, colorimetricNames] = CS2000_measure();
    aperture = CS2000_readApertureStop;
    measuredData.aperture = aperture;
    assignin('base', 'measuredData', measuredData);
    assignin('base', 'colorimetricNames', colorimetricNames);
    set(handles.measureText, 'String', message1); 
    set(handles.measureText2, 'String', message2); 

    set(handles.colorDataText, 'String', {measuredData.colorimetricData.Lv,...
        measuredData.colorimetricData.X, measuredData.colorimetricData.Z,...
        aperture, mat2str(measuredData.timeStamp)});
    set(handles.colorDataNames, 'String', {colorimetricNames{2},...
        colorimetricNames{3}, colorimetricNames{5}, 'Aperture', 'Time'});
    pause(0.1);
    % create objects
    measuredData.comments = get(handles.commentsEdit, 'String');
    measuredData.lightSource = get(handles.lightSourceEdit, 'String');
    measurements{i} = measuredData;     
end
assignin('base', 'measurements', measurements);


% --- Executes on button press in normalLightBox.
function normalLightBox_Callback(hObject, eventdata, handles)
% hObject    handle to normalLightBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (get(handles.normalLightBox,'Value') == get(hObject,'Max')) 
	setBacklight(0,0);
else
    setBacklight(1,1);
end



function commentsEdit_Callback(hObject, eventdata, handles)
% hObject    handle to commentsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of commentsEdit as text
%        str2double(get(hObject,'String')) returns contents of commentsEdit as a double


% --- Executes during object creation, after setting all properties.
function commentsEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to commentsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lightSourceEdit_Callback(hObject, eventdata, handles)
% hObject    handle to lightSourceEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function lightSourceEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lightSourceEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in NDfilterMenu.
function NDfilterMenu_Callback(hObject, eventdata, handles)
% hObject    handle to NDfilterMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(handles.NDfilterMenu, 'Value') -1;
CS2000_setNDFilter(val);
fil = CS2000_readNDFilter;
switch fil
    case 0
        filter = 'None';
    case 1
        filter = 'ND1';
    case 2
        filter = 'ND2';
    otherwise
        filter = 'Error: ND filter could not be read.';
end
set(handles.measureText, 'String', ['Current ND filter: ', filter]);


% --- Executes during object creation, after setting all properties.
function NDfilterMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NDfilterMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function numberOfMeas_Callback(hObject, eventdata, handles)
% hObject    handle to numberOfMeas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function numberOfMeas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numberOfMeas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg('Close this figure and terminate connection?',...
      'Close Request Function',...
      'Yes','No','Yes'); 
   switch selection, 
      case 'Yes',
        message = CS2000_terminateConnection();
        set(handles.openText, 'String', message); 
        pause(2);
        delete(hObject);
        evalin('base', 'clear');
        delete(gcf)        
      case 'No'
      return 
   end