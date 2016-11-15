function varargout = set_up_4_arm_motor_IDs(varargin)
% SET_UP_4_ARM_MOTOR_IDS MATLAB code for set_up_4_arm_motor_IDs.fig
%      SET_UP_4_ARM_MOTOR_IDS, by itself, creates a new SET_UP_4_ARM_MOTOR_IDS or raises the existing
%      singleton*.
%
%      H = SET_UP_4_ARM_MOTOR_IDS returns the handle to a new SET_UP_4_ARM_MOTOR_IDS or the handle to
%      the existing singleton*.
%
%      SET_UP_4_ARM_MOTOR_IDS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SET_UP_4_ARM_MOTOR_IDS.M with the given input arguments.
%
%      SET_UP_4_ARM_MOTOR_IDS('Property','Value',...) creates a new SET_UP_4_ARM_MOTOR_IDS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before set_up_4_arm_motor_IDs_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to set_up_4_arm_motor_IDs_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help set_up_4_arm_motor_IDs

% Last Modified by GUIDE v2.5 01-Jul-2014 15:12:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @set_up_4_arm_motor_IDs_OpeningFcn, ...
                   'gui_OutputFcn',  @set_up_4_arm_motor_IDs_OutputFcn, ...
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


% --- Executes just before set_up_4_arm_motor_IDs is made visible.
function set_up_4_arm_motor_IDs_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to set_up_4_arm_motor_IDs (see VARARGIN)

% Choose default command line output for set_up_4_arm_motor_IDs
handles.output = hObject;

clc

%Set Initial Position
handles.user.jointAngles = [0 0 0 0 0 50 0 0 0 0 0 50 0 0 0 0 0 50 0 0 0 0 0 50];
handles.user.arm1jointAngles = [handles.user.jointAngles(1), handles.user.jointAngles(2), handles.user.jointAngles(3), handles.user.jointAngles(4), handles.user.jointAngles(5), handles.user.jointAngles(6)];
handles.user.arm2jointAngles = [handles.user.jointAngles(7), handles.user.jointAngles(8), handles.user.jointAngles(9), handles.user.jointAngles(10), handles.user.jointAngles(11), handles.user.jointAngles(12)];
handles.user.arm3jointAngles = [handles.user.jointAngles(13), handles.user.jointAngles(14), handles.user.jointAngles(15), handles.user.jointAngles(16), handles.user.jointAngles(17), handles.user.jointAngles(18)];
handles.user.arm4jointAngles = [handles.user.jointAngles(19), handles.user.jointAngles(20), handles.user.jointAngles(21), handles.user.jointAngles(22), handles.user.jointAngles(23), handles.user.jointAngles(24)];

%Set Initial Motor IDs
handles.user.motorIDs = [11 12 13 14 15 16 21 22 23 24 25 26 31 32 33 34 35 36 41 42 43 44 45 46];
handles.user.arm1motorIDs = [handles.user.motorIDs(1),handles.user.motorIDs(2),handles.user.motorIDs(3),handles.user.motorIDs(4),handles.user.motorIDs(5),handles.user.motorIDs(6)];
handles.user.arm2motorIDs = [handles.user.motorIDs(7),handles.user.motorIDs(8),handles.user.motorIDs(9),handles.user.motorIDs(10),handles.user.motorIDs(11),handles.user.motorIDs(12)];
handles.user.arm3motorIDs = [handles.user.motorIDs(13),handles.user.motorIDs(14),handles.user.motorIDs(15),handles.user.motorIDs(16),handles.user.motorIDs(17),handles.user.motorIDs(18)];
handles.user.arm4motorIDs = [handles.user.motorIDs(19),handles.user.motorIDs(20),handles.user.motorIDs(21),handles.user.motorIDs(22),handles.user.motorIDs(23),handles.user.motorIDs(24)];

%
handles.user.comportinput=0;
handles.user.serialstatus=0;

% Prepare the arm axes
view(handles.simulation, [0 -6 0]);
axis(handles.simulation, [-13 13 -8 8 0 18]);
grid off;
%set(handles.simulation, 'Visible', 'off');

% Create vertices for all the patches
% Save handles to the patch objects and create a vertices matrix for each arm.
% Link number increases from bottom part to the top


%-----------------ARM1---------------------------------------------------%
makeLink010(handles.simulation, [.4 0 .6]);
handles.user.link11Patch = makeLink1(handles.simulation, [.6 .6 .6]);
handles.user.link11Vertices = get(handles.user.link11Patch, 'Vertices')';
handles.user.link11Vertices(4,:) = ones(1, size(handles.user.link11Vertices,2));
handles.user.link12Patch = makeLink2(handles.simulation, [.6 .6 .6]);
handles.user.link12Vertices = get(handles.user.link12Patch, 'Vertices')';
handles.user.link12Vertices(4,:) = ones(1, size(handles.user.link12Vertices,2));
handles.user.link13Patch = makeLink3(handles.simulation, [.6 .6 .6]);
handles.user.link13Vertices = get(handles.user.link13Patch, 'Vertices')';
handles.user.link13Vertices(4,:) = ones(1, size(handles.user.link13Vertices,2));
handles.user.link14Patch = makeLink4(handles.simulation, [.6 .6 .6]);
handles.user.link14Vertices = get(handles.user.link14Patch, 'Vertices')';
handles.user.link14Vertices(4,:) = ones(1, size(handles.user.link14Vertices,2));
handles.user.link15Patch = makeLink5(handles.simulation, [.95 .95 0]);
handles.user.link15Vertices = get(handles.user.link15Patch, 'Vertices')';
handles.user.link15Vertices(4,:) = ones(1, size(handles.user.link15Vertices,2));
%------------------------------------------------------------------------%

%-----------------ARM2---------------------------------------------------%
makeLink020(handles.simulation, [0 .9 0]);
handles.user.link21Patch = makeLink1(handles.simulation, [.6 .6 .6]);
handles.user.link21Vertices = get(handles.user.link21Patch, 'Vertices')';
handles.user.link21Vertices(4,:) = ones(1, size(handles.user.link21Vertices,2));
handles.user.link22Patch = makeLink2(handles.simulation, [.6 .6 .6]);
handles.user.link22Vertices = get(handles.user.link22Patch, 'Vertices')';
handles.user.link22Vertices(4,:) = ones(1, size(handles.user.link22Vertices,2));
handles.user.link23Patch = makeLink3(handles.simulation, [.6 .6 .6]);
handles.user.link23Vertices = get(handles.user.link23Patch, 'Vertices')';
handles.user.link23Vertices(4,:) = ones(1, size(handles.user.link23Vertices,2));
handles.user.link24Patch = makeLink4(handles.simulation, [.6 .6 .6]);
handles.user.link24Vertices = get(handles.user.link24Patch, 'Vertices')';
handles.user.link24Vertices(4,:) = ones(1, size(handles.user.link24Vertices,2));
handles.user.link25Patch = makeLink5(handles.simulation, [.95 .95 0]);
handles.user.link25Vertices = get(handles.user.link25Patch, 'Vertices')';
handles.user.link25Vertices(4,:) = ones(1, size(handles.user.link25Vertices,2));
%------------------------------------------------------------------------%

%-----------------ARM3---------------------------------------------------%
makeLink030(handles.simulation, [.9 0 .3]);
handles.user.link31Patch = makeLink1(handles.simulation, [.6 .6 .6]);
handles.user.link31Vertices = get(handles.user.link31Patch, 'Vertices')';
handles.user.link31Vertices(4,:) = ones(1, size(handles.user.link31Vertices,2));
handles.user.link32Patch = makeLink2(handles.simulation, [.6 .6 .6]);
handles.user.link32Vertices = get(handles.user.link32Patch, 'Vertices')';
handles.user.link32Vertices(4,:) = ones(1, size(handles.user.link32Vertices,2));
handles.user.link33Patch = makeLink3(handles.simulation, [.6 .6 .6]);
handles.user.link33Vertices = get(handles.user.link33Patch, 'Vertices')';
handles.user.link33Vertices(4,:) = ones(1, size(handles.user.link33Vertices,2));
handles.user.link34Patch = makeLink4(handles.simulation, [.6 .6 .6]);
handles.user.link34Vertices = get(handles.user.link34Patch, 'Vertices')';
handles.user.link34Vertices(4,:) = ones(1, size(handles.user.link34Vertices,2));
handles.user.link35Patch = makeLink5(handles.simulation, [.95 .95 0]);
handles.user.link35Vertices = get(handles.user.link35Patch, 'Vertices')';
handles.user.link35Vertices(4,:) = ones(1, size(handles.user.link35Vertices,2));
%------------------------------------------------------------------------%

%-----------------ARM4---------------------------------------------------%
makeLink040(handles.simulation, [0 .8 .8]);
handles.user.link41Patch = makeLink1(handles.simulation, [.6 .6 .6]);
handles.user.link41Vertices = get(handles.user.link41Patch, 'Vertices')';
handles.user.link41Vertices(4,:) = ones(1, size(handles.user.link41Vertices,2));
handles.user.link42Patch = makeLink2(handles.simulation, [.6 .6 .6]);
handles.user.link42Vertices = get(handles.user.link42Patch, 'Vertices')';
handles.user.link42Vertices(4,:) = ones(1, size(handles.user.link42Vertices,2));
handles.user.link43Patch = makeLink3(handles.simulation, [.6 .6 .6]);
handles.user.link43Vertices = get(handles.user.link43Patch, 'Vertices')';
handles.user.link43Vertices(4,:) = ones(1, size(handles.user.link43Vertices,2));
handles.user.link44Patch = makeLink4(handles.simulation, [.6 .6 .6]);
handles.user.link44Vertices = get(handles.user.link44Patch, 'Vertices')';
handles.user.link44Vertices(4,:) = ones(1, size(handles.user.link44Vertices,2));
handles.user.link45Patch = makeLink5(handles.simulation, [.95 .95 0]);
handles.user.link45Vertices = get(handles.user.link45Patch, 'Vertices')';
handles.user.link45Vertices(4,:) = ones(1, size(handles.user.link45Vertices,2));
%------------------------------------------------------------------------%

dontOpen = false;
mainGuiInput = find(strcmp(varargin,'multi_robot_arms'));
if( isempty(mainGuiInput) )|| (length(varargin) <= mainGuiInput) || (~ishandle(varargin{mainGuiInput+1}))
    dontOpen = true;
else
    handles.multiarmMain = varargin{mainGuiInput+1};
    mainHandles = guidata(handles.multiarmMain);
    set(handles.arm1_motor_IDs,'String',get(mainHandles.Arm1_motor_IDs,'String'));
    set(handles.arm2_motor_IDs,'String',get(mainHandles.Arm2_motor_IDs,'String'));
    set(handles.arm3_motor_IDs,'String',get(mainHandles.Arm3_motor_IDs,'String'));
    set(handles.arm4_motor_IDs,'String',get(mainHandles.Arm4_motor_IDs,'String'));
    
    handles.user.arm1motorIDs = str2num(get(handles.arm1_motor_IDs,'String'));
    handles.user.arm2motorIDs = str2num(get(handles.arm2_motor_IDs,'String'));
    handles.user.arm3motorIDs = str2num(get(handles.arm3_motor_IDs,'String'));
    handles.user.arm4motorIDs = str2num(get(handles.arm4_motor_IDs,'String'));
    
    guidata(hObject, handles);
end

% Move the arm into the HOME position.
updateArm(hObject, handles);

% Update handles structure
guidata(hObject, handles);

if dontOpen
    disp('-----------------------------------------------------');
    disp('Improper input arguments. ') ;
    disp('-----------------------------------------------------');
else
    uiwait(hObject);
end




% --- Outputs from this function are returned to the command line.
function varargout = set_up_4_arm_motor_IDs_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = [];
delete(hObject);


%------------------------ARM1------------------------------------------------------------%

function edit_arm1_motor1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arm1_motor1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arm1_motor1 as text
%        str2double(get(hObject,'String')) returns contents of edit_arm1_motor1 as a double
handles.user.arm1motorIDs(1) = str2num(get(handles.edit_arm1_motor1,'String'));
set(handles.arm1_motor1,'String',sprintf('%d',handles.user.arm1motorIDs(1)));
updateArm(hObject,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_arm1_motor1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arm1_motor1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_arm1_motor2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arm1_motor2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arm1_motor2 as text
%        str2double(get(hObject,'String')) returns contents of edit_arm1_motor2 as a double
handles.user.arm1motorIDs(2) = str2num(get(handles.edit_arm1_motor2,'String'));
set(handles.arm1_motor2,'String',sprintf('%d',handles.user.arm1motorIDs(2)));
updateArm(hObject,handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_arm1_motor2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arm1_motor2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_arm1_motor3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arm1_motor3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arm1_motor3 as text
%        str2double(get(hObject,'String')) returns contents of edit_arm1_motor3 as a double
handles.user.arm1motorIDs(3) = str2num(get(handles.edit_arm1_motor3,'String'));
set(handles.arm1_motor3,'String',sprintf('%d',handles.user.arm1motorIDs(3)));
updateArm(hObject,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_arm1_motor3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arm1_motor3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_arm1_motor4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arm1_motor4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arm1_motor4 as text
%        str2double(get(hObject,'String')) returns contents of edit_arm1_motor4 as a double
handles.user.arm1motorIDs(4) = str2num(get(handles.edit_arm1_motor4,'String'));
set(handles.arm1_motor4,'String',sprintf('%d',handles.user.arm1motorIDs(4)));
updateArm(hObject,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_arm1_motor4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arm1_motor4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_arm1_motor5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arm1_motor5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arm1_motor5 as text
%        str2double(get(hObject,'String')) returns contents of edit_arm1_motor5 as a double
handles.user.arm1motorIDs(5) = str2num(get(handles.edit_arm1_motor5,'String'));
set(handles.arm1_motor5,'String',sprintf('%d',handles.user.arm1motorIDs(5)));
updateArm(hObject,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_arm1_motor5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arm1_motor5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_arm1_motor6_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arm1_motor6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arm1_motor6 as text
%        str2double(get(hObject,'String')) returns contents of edit_arm1_motor6 as a double
handles.user.arm1motorIDs(6) = str2num(get(handles.edit_arm1_motor6,'String'));
set(handles.arm1_motor6,'String',sprintf('%d',handles.user.arm1motorIDs(6)));
updateArm(hObject,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_arm1_motor6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arm1_motor6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%----------------------------------------------------------------------------------------%

%------------------------ARM2------------------------------------------------------------%

function edit_arm2_motor1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arm2_motor1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arm2_motor1 as text
%        str2double(get(hObject,'String')) returns contents of edit_arm2_motor1 as a double
handles.user.arm2motorIDs(1) = str2num(get(handles.edit_arm2_motor1,'String'));
set(handles.arm2_motor1,'String',sprintf('%d',handles.user.arm2motorIDs(1)));
updateArm(hObject,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_arm2_motor1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arm2_motor1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_arm2_motor2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arm2_motor2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arm2_motor2 as text
%        str2double(get(hObject,'String')) returns contents of edit_arm2_motor2 as a double
handles.user.arm2motorIDs(2) = str2num(get(handles.edit_arm2_motor2,'String'));
set(handles.arm2_motor2,'String',sprintf('%d',handles.user.arm2motorIDs(2)));
updateArm(hObject,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_arm2_motor2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arm2_motor2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_arm2_motor3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arm2_motor3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arm2_motor3 as text
%        str2double(get(hObject,'String')) returns contents of edit_arm2_motor3 as a double
handles.user.arm2motorIDs(3) = str2num(get(handles.edit_arm2_motor3,'String'));
set(handles.arm2_motor3,'String',sprintf('%d',handles.user.arm2motorIDs(3)));
updateArm(hObject,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_arm2_motor3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arm2_motor3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_arm2_motor4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arm2_motor4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arm2_motor4 as text
%        str2double(get(hObject,'String')) returns contents of edit_arm2_motor4 as a double
handles.user.arm2motorIDs(4) = str2num(get(handles.edit_arm2_motor4,'String'));
set(handles.arm2_motor4,'String',sprintf('%d',handles.user.arm2motorIDs(4)));
updateArm(hObject,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_arm2_motor4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arm2_motor4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_arm2_motor5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arm2_motor5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arm2_motor5 as text
%        str2double(get(hObject,'String')) returns contents of edit_arm2_motor5 as a double
handles.user.arm2motorIDs(5) = str2num(get(handles.edit_arm2_motor5,'String'));
set(handles.arm2_motor5,'String',sprintf('%d',handles.user.arm2motorIDs(5)));
updateArm(hObject,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_arm2_motor5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arm2_motor5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_arm2_motor6_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arm2_motor6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arm2_motor6 as text
%        str2double(get(hObject,'String')) returns contents of edit_arm2_motor6 as a double
handles.user.arm2motorIDs(6) = str2num(get(handles.edit_arm2_motor6,'String'));
set(handles.arm2_motor6,'String',sprintf('%d',handles.user.arm2motorIDs(6)));
updateArm(hObject,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_arm2_motor6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arm2_motor6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%----------------------------------------------------------------------------------------%

%------------------------ARM3------------------------------------------------------------%

function edit_arm3_motor1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arm3_motor1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arm3_motor1 as text
%        str2double(get(hObject,'String')) returns contents of edit_arm3_motor1 as a double
handles.user.arm3motorIDs(1) = str2num(get(handles.edit_arm3_motor1,'String'));
set(handles.arm3_motor1,'String',sprintf('%d',handles.user.arm3motorIDs(1)));
updateArm(hObject,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_arm3_motor1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arm3_motor1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_arm3_motor2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arm3_motor2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arm3_motor2 as text
%        str2double(get(hObject,'String')) returns contents of edit_arm3_motor2 as a double
handles.user.arm3motorIDs(2) = str2num(get(handles.edit_arm3_motor2,'String'));
set(handles.arm3_motor2,'String',sprintf('%d',handles.user.arm3motorIDs(2)));
updateArm(hObject,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_arm3_motor2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arm3_motor2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_arm3_motor3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arm3_motor3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arm3_motor3 as text
%        str2double(get(hObject,'String')) returns contents of edit_arm3_motor3 as a double
handles.user.arm3motorIDs(3) = str2num(get(handles.edit_arm3_motor3,'String'));
set(handles.arm3_motor3,'String',sprintf('%d',handles.user.arm3motorIDs(3)));
updateArm(hObject,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_arm3_motor3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arm3_motor3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_arm3_motor4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arm3_motor4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arm3_motor4 as text
%        str2double(get(hObject,'String')) returns contents of edit_arm3_motor4 as a double
handles.user.arm3motorIDs(4) = str2num(get(handles.edit_arm3_motor4,'String'));
set(handles.arm3_motor4,'String',sprintf('%d',handles.user.arm3motorIDs(4)));
updateArm(hObject,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_arm3_motor4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arm3_motor4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_arm3_motor5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arm3_motor5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arm3_motor5 as text
%        str2double(get(hObject,'String')) returns contents of edit_arm3_motor5 as a double
handles.user.arm3motorIDs(5) = str2num(get(handles.edit_arm3_motor5,'String'));
set(handles.arm3_motor5,'String',sprintf('%d',handles.user.arm3motorIDs(5)));
updateArm(hObject,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_arm3_motor5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arm3_motor5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_arm3_motor6_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arm3_motor6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arm3_motor6 as text
%        str2double(get(hObject,'String')) returns contents of edit_arm3_motor6 as a double
handles.user.arm3motorIDs(6) = str2num(get(handles.edit_arm3_motor6,'String'));
set(handles.arm3_motor6,'String',sprintf('%d',handles.user.arm3motorIDs(6)));
updateArm(hObject,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_arm3_motor6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arm3_motor6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%----------------------------------------------------------------------------------------%

%------------------------ARM4------------------------------------------------------------%

function edit_arm4_motor1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arm4_motor1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arm4_motor1 as text
%        str2double(get(hObject,'String')) returns contents of edit_arm4_motor1 as a double
handles.user.arm4motorIDs(1) = str2num(get(handles.edit_arm4_motor1,'String'));
set(handles.arm4_motor1,'String',sprintf('%d',handles.user.arm4motorIDs(1)));
updateArm(hObject,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_arm4_motor1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arm4_motor1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_arm4_motor2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arm4_motor2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arm4_motor2 as text
%        str2double(get(hObject,'String')) returns contents of edit_arm4_motor2 as a double
handles.user.arm4motorIDs(2) = str2num(get(handles.edit_arm4_motor2,'String'));
set(handles.arm4_motor2,'String',sprintf('%d',handles.user.arm4motorIDs(2)));
updateArm(hObject,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_arm4_motor2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arm4_motor2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_arm4_motor3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arm4_motor3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arm4_motor3 as text
%        str2double(get(hObject,'String')) returns contents of edit_arm4_motor3 as a double
handles.user.arm4motorIDs(3) = str2num(get(handles.edit_arm4_motor3,'String'));
set(handles.arm4_motor3,'String',sprintf('%d',handles.user.arm4motorIDs(3)));
updateArm(hObject,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_arm4_motor3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arm4_motor3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_arm4_motor4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arm4_motor4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arm4_motor4 as text
%        str2double(get(hObject,'String')) returns contents of edit_arm4_motor4 as a double
handles.user.arm4motorIDs(4) = str2num(get(handles.edit_arm4_motor4,'String'));
set(handles.arm4_motor4,'String',sprintf('%d',handles.user.arm4motorIDs(4)));
updateArm(hObject,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_arm4_motor4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arm4_motor4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_arm4_motor5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arm4_motor5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arm4_motor5 as text
%        str2double(get(hObject,'String')) returns contents of edit_arm4_motor5 as a double
handles.user.arm4motorIDs(5) = str2num(get(handles.edit_arm4_motor5,'String'));
set(handles.arm4_motor5,'String',sprintf('%d',handles.user.arm4motorIDs(5)));
updateArm(hObject,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_arm4_motor5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arm4_motor5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_arm4_motor6_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arm4_motor6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_arm4_motor6 as text
%        str2double(get(hObject,'String')) returns contents of edit_arm4_motor6 as a double
handles.user.arm4motorIDs(6) = str2num(get(handles.edit_arm4_motor6,'String'));
set(handles.arm4_motor6,'String',sprintf('%d',handles.user.arm4motorIDs(6)));
updateArm(hObject,handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_arm4_motor6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arm4_motor6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%----------------------------------------------------------------------------------------%

function updateArm(hObject, handles)

%------------------ARM1-----------------------------------------------%
[A11,A12,A13,A14,A15] = makeHomogeneousTransformations(...
    handles.user.arm1jointAngles(1),...
    handles.user.arm1jointAngles(2),...
    handles.user.arm1jointAngles(3),...
    handles.user.arm1jointAngles(4),...
    handles.user.arm1jointAngles(5));

% DONE: Use the A matricies to form the T1_n matricies.
AA1 = zeros(4,3);
AA1(1,4) = -10;

TRANS = zeros(4,4);
TRANS(1,2) = -1;
TRANS(2,1) = 1;
TRANS(3,3) = 1;
TRANS(4,4) = 1;

T1_1 = TRANS * A11 + AA1;
T1_2 = TRANS * A11 * A12 + AA1;
T1_3 = TRANS * A11 * A12 * A13 + AA1;
T1_4 = TRANS * A11 * A12 * A13 * A14 + AA1;
T1_5 = TRANS * A11 * A12 * A13 * A14 * A15 + AA1;

% DONE: Use the T matricies to transform the patch vertices
link11verticesWRTground = T1_1 * handles.user.link11Vertices;
link12verticesWRTground = T1_2 * handles.user.link12Vertices;
link13verticesWRTground = T1_3 * handles.user.link13Vertices;
link14verticesWRTground = T1_4 * handles.user.link14Vertices;
link15verticesWRTground = T1_5 * handles.user.link15Vertices;


% DONE: Update the patches with the new vertices.
set(handles.user.link11Patch,'Vertices', link11verticesWRTground(1:3,:)');
set(handles.user.link12Patch,'Vertices', link12verticesWRTground(1:3,:)');
set(handles.user.link13Patch,'Vertices', link13verticesWRTground(1:3,:)');
set(handles.user.link14Patch,'Vertices', link14verticesWRTground(1:3,:)');
set(handles.user.link15Patch,'Vertices', link15verticesWRTground(1:3,:)');

set(handles.arm1_motor1,'String',sprintf('%d',handles.user.arm1motorIDs(1)));
set(handles.arm1_motor2,'String',sprintf('%d',handles.user.arm1motorIDs(2)));
set(handles.arm1_motor3,'String',sprintf('%d',handles.user.arm1motorIDs(3)));
set(handles.arm1_motor4,'String',sprintf('%d',handles.user.arm1motorIDs(4)));
set(handles.arm1_motor5,'String',sprintf('%d',handles.user.arm1motorIDs(5)));
set(handles.arm1_motor6,'String',sprintf('%d',handles.user.arm1motorIDs(6)));

arm1motorIDStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.arm1motorIDs);
set(handles.arm1_motor_IDs,'String',arm1motorIDStr);

for i = 1:6;
    handles.user.motorIDs(i) = handles.user.arm1motorIDs(i);
end
guidata(hObject, handles);

%-------------------------------------------------------------------------------%

%-----------------------ARM2---------------------------------------------------%
% DONE: Create the five homogeneous transformation matrices.
[A21,A22,A23,A24,A25] = makeHomogeneousTransformations(...
    handles.user.arm2jointAngles(1),...
    handles.user.arm2jointAngles(2),...
    handles.user.arm2jointAngles(3),...
    handles.user.arm2jointAngles(4),...
    handles.user.arm2jointAngles(5));

% DONE: Use the A matricies to form the T0_n matricies.

AA2 = zeros(4,3);
AA2(1,4) = -3;

T2_1 = TRANS * A21 + AA2;
T2_2 = TRANS * A21 * A22 + AA2;
T2_3 = TRANS * A21 * A22 * A23 + AA2;
T2_4 = TRANS * A21 * A22 * A23 * A24 + AA2;
T2_5 = TRANS * A21 * A22 * A23 * A24 * A25 + AA2;

% DONE: Use the T matricies to transform the patch vertices
link21verticesWRTground = T2_1 * handles.user.link21Vertices;
link22verticesWRTground = T2_2 * handles.user.link22Vertices;
link23verticesWRTground = T2_3 * handles.user.link23Vertices;
link24verticesWRTground = T2_4 * handles.user.link24Vertices;
link25verticesWRTground = T2_5 * handles.user.link25Vertices;

% DONE: Update the patches with the new vertices.
set(handles.user.link21Patch,'Vertices', link21verticesWRTground(1:3,:)');
set(handles.user.link22Patch,'Vertices', link22verticesWRTground(1:3,:)');
set(handles.user.link23Patch,'Vertices', link23verticesWRTground(1:3,:)');
set(handles.user.link24Patch,'Vertices', link24verticesWRTground(1:3,:)');
set(handles.user.link25Patch,'Vertices', link25verticesWRTground(1:3,:)');

set(handles.arm2_motor1,'String',sprintf('%d',handles.user.arm2motorIDs(1)));
set(handles.arm2_motor2,'String',sprintf('%d',handles.user.arm2motorIDs(2)));
set(handles.arm2_motor3,'String',sprintf('%d',handles.user.arm2motorIDs(3)));
set(handles.arm2_motor4,'String',sprintf('%d',handles.user.arm2motorIDs(4)));
set(handles.arm2_motor5,'String',sprintf('%d',handles.user.arm2motorIDs(5)));
set(handles.arm2_motor6,'String',sprintf('%d',handles.user.arm2motorIDs(6)));

arm2motorIDStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.arm2motorIDs);
set(handles.arm2_motor_IDs,'String',arm2motorIDStr);

for i = 7:12;
    handles.user.motorIDs(i) = handles.user.arm2motorIDs(i-6);
end
guidata(hObject, handles);

%------------------------------------------------------------------------------%

%-----------------------ARM3---------------------------------------------------%
% DONE: Create the five homogeneous transformation matrices.
[A31,A32,A33,A34,A35] = makeHomogeneousTransformations(...
    handles.user.arm3jointAngles(1),...
    handles.user.arm3jointAngles(2),...
    handles.user.arm3jointAngles(3),...
    handles.user.arm3jointAngles(4),...
    handles.user.arm3jointAngles(5));

% DONE: Use the A matricies to form the T0_n matricies.
AA3 = zeros(4,3);
AA3(1,4) = 3;


T3_1 =  TRANS * A31 + AA3;
T3_2 =  TRANS * A31 * A32  + AA3;
T3_3 =  TRANS * A31 * A32 * A33  +AA3;
T3_4 =  TRANS * A31 * A32 * A33 * A34  + AA3;
T3_5 =  TRANS * A31 * A32 * A33 * A34 * A35 + AA3;

% DONE: Use the T matricies to transform the patch vertices
link31verticesWRTground = T3_1 * handles.user.link31Vertices;
link32verticesWRTground = T3_2 * handles.user.link32Vertices;
link33verticesWRTground = T3_3 * handles.user.link33Vertices;
link34verticesWRTground = T3_4 * handles.user.link34Vertices;
link35verticesWRTground = T3_5 * handles.user.link35Vertices;

% DONE: Update the patches with the new vertices.
set(handles.user.link31Patch,'Vertices', link31verticesWRTground(1:3,:)');
set(handles.user.link32Patch,'Vertices', link32verticesWRTground(1:3,:)');
set(handles.user.link33Patch,'Vertices', link33verticesWRTground(1:3,:)');
set(handles.user.link34Patch,'Vertices', link34verticesWRTground(1:3,:)');
set(handles.user.link35Patch,'Vertices', link35verticesWRTground(1:3,:)');

set(handles.arm3_motor1,'String',sprintf('%d',handles.user.arm3motorIDs(1)));
set(handles.arm3_motor2,'String',sprintf('%d',handles.user.arm3motorIDs(2)));
set(handles.arm3_motor3,'String',sprintf('%d',handles.user.arm3motorIDs(3)));
set(handles.arm3_motor4,'String',sprintf('%d',handles.user.arm3motorIDs(4)));
set(handles.arm3_motor5,'String',sprintf('%d',handles.user.arm3motorIDs(5)));
set(handles.arm3_motor6,'String',sprintf('%d',handles.user.arm3motorIDs(6)));

arm3motorIDStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.arm3motorIDs);
set(handles.arm3_motor_IDs,'String',arm3motorIDStr);

for i = 13:18;
    handles.user.motorIDs(i) = handles.user.arm3motorIDs(i-12);
end
guidata(hObject, handles);

%------------------------------------------------------------------------------%

%-----------------------ARM4---------------------------------------------------%
% DONE: Create the five homogeneous transformation matrices.
[A41,A42,A43,A44,A45] = makeHomogeneousTransformations(...
    handles.user.arm4jointAngles(1),...
    handles.user.arm4jointAngles(2),...
    handles.user.arm4jointAngles(3),...
    handles.user.arm4jointAngles(4),...
    handles.user.arm4jointAngles(5));

% DONE: Use the A matricies to form the T0_n matricies.

AA4 = zeros(4,3);
AA4(1,4) = 10;


T4_1 = TRANS * A41 + AA4;
T4_2 = TRANS * A41 * A42 + AA4;
T4_3 = TRANS * A41 * A42 * A43 + AA4;
T4_4 = TRANS * A41 * A42 * A43 * A44 + AA4;
T4_5 = TRANS * A41 * A42 * A43 * A44 * A45 + AA4;

% DONE: Use the T matricies to transform the patch vertices
link41verticesWRTground = T4_1 * handles.user.link41Vertices;
link42verticesWRTground = T4_2 * handles.user.link42Vertices;
link43verticesWRTground = T4_3 * handles.user.link43Vertices;
link44verticesWRTground = T4_4 * handles.user.link44Vertices;
link45verticesWRTground = T4_5 * handles.user.link45Vertices;

% DONE: Update the patches with the new vertices.
set(handles.user.link41Patch,'Vertices', link41verticesWRTground(1:3,:)');
set(handles.user.link42Patch,'Vertices', link42verticesWRTground(1:3,:)');
set(handles.user.link43Patch,'Vertices', link43verticesWRTground(1:3,:)');
set(handles.user.link44Patch,'Vertices', link44verticesWRTground(1:3,:)');
set(handles.user.link45Patch,'Vertices', link45verticesWRTground(1:3,:)');

set(handles.arm4_motor1,'String',sprintf('%d',handles.user.arm4motorIDs(1)));
set(handles.arm4_motor2,'String',sprintf('%d',handles.user.arm4motorIDs(2)));
set(handles.arm4_motor3,'String',sprintf('%d',handles.user.arm4motorIDs(3)));
set(handles.arm4_motor4,'String',sprintf('%d',handles.user.arm4motorIDs(4)));
set(handles.arm4_motor5,'String',sprintf('%d',handles.user.arm4motorIDs(5)));
set(handles.arm4_motor6,'String',sprintf('%d',handles.user.arm4motorIDs(6)));

arm4motorIDStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.arm4motorIDs);
set(handles.arm4_motor_IDs,'String',arm4motorIDStr);

for i = 19:24;
    handles.user.motorIDs(i) = handles.user.arm4motorIDs(i-18);
end
guidata(hObject, handles);


% --- Executes on button press in Send_ID_Numbers.
function Send_ID_Numbers_Callback(hObject, eventdata, handles)
% hObject    handle to Send_ID_Numbers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

arm1_text = sprintf('%d  %d  %d  %d  %d  %d', handles.user.arm1motorIDs);
arm2_text = sprintf('%d  %d  %d  %d  %d  %d', handles.user.arm2motorIDs);
arm3_text = sprintf('%d  %d  %d  %d  %d  %d', handles.user.arm3motorIDs);
arm4_text = sprintf('%d  %d  %d  %d  %d  %d', handles.user.arm4motorIDs);

main = handles.multiarmMain;
if( ishandle(main) )
    mainHandles = guidata(main);
    arm1_motor_ID_text = mainHandles.Arm1_motor_IDs;
    set(arm1_motor_ID_text, 'String', arm1_text);
    arm2_motor_ID_text = mainHandles.Arm2_motor_IDs;
    set(arm2_motor_ID_text, 'String', arm2_text);
    arm3_motor_ID_text = mainHandles.Arm3_motor_IDs;
    set(arm3_motor_ID_text, 'String', arm3_text);
    arm4_motor_ID_text = mainHandles.Arm4_motor_IDs;
    set(arm4_motor_ID_text, 'String', arm4_text);
end
uiresume(handles.figure);

    

% --- Executes on button press in Cancel_button.
function Cancel_button_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%uiresume(handles.figure);


function figure_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%uiresume(hObject);
