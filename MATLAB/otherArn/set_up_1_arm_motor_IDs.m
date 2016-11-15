function varargout = set_up_1_arm_motor_IDs(varargin)
% SET_UP_1_ARM_MOTOR_IDS MATLAB code for set_up_1_arm_motor_IDs.fig
%      SET_UP_1_ARM_MOTOR_IDS, by itself, creates a new SET_UP_1_ARM_MOTOR_IDS or raises the existing
%      singleton*.
%
%      H = SET_UP_1_ARM_MOTOR_IDS returns the handle to a new SET_UP_1_ARM_MOTOR_IDS or the handle to
%      the existing singleton*.
%
%      SET_UP_1_ARM_MOTOR_IDS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SET_UP_1_ARM_MOTOR_IDS.M with the given input arguments.
%
%      SET_UP_1_ARM_MOTOR_IDS('Property','Value',...) creates a new SET_UP_1_ARM_MOTOR_IDS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before set_up_1_arm_motor_IDs_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to set_up_1_arm_motor_IDs_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help set_up_1_arm_motor_IDs

% Last Modified by GUIDE v2.5 30-Jun-2014 13:30:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @set_up_1_arm_motor_IDs_OpeningFcn, ...
                   'gui_OutputFcn',  @set_up_1_arm_motor_IDs_OutputFcn, ...
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


% --- Executes just before set_up_1_arm_motor_IDs is made visible.
function set_up_1_arm_motor_IDs_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to set_up_1_arm_motor_IDs (see VARARGIN)

% Choose default command line output for set_up_1_arm_motor_IDs
handles.output = hObject;

clc

%
handles.user.jointAngles = [0 0 0 0 0 50]; % Initial position.
handles.user.motorIDs = [11 12 13 14 15 16]; % Initial motor IDs.
%
handles.user.comportinput=0;
handles.user.serialstatus=0;

% Prepare the arm axes
view(handles.simulation, [-50 0 0]);
axis(handles.simulation, [-10 10 -6 6 0 20]);
%set(handles.axes_arm, 'Visible', 'off');
grid off;

% Create vertices for all the patches
makeLink0(handles.simulation, [.5 .5 .5]);  % Doesn't move so save no references.
% Save handles to the patch objects and create a vertices matrix for each.
handles.user.link1Patch = makeLink1(handles.simulation, [.9 .9 .9]);
handles.user.link1Vertices = get(handles.user.link1Patch, 'Vertices')';
handles.user.link1Vertices(4,:) = ones(1, size(handles.user.link1Vertices,2));
handles.user.link2Patch = makeLink2(handles.simulation, [.9 .9 .9]);
handles.user.link2Vertices = get(handles.user.link2Patch, 'Vertices')';
handles.user.link2Vertices(4,:) = ones(1, size(handles.user.link2Vertices,2));
handles.user.link3Patch = makeLink3(handles.simulation, [.9 .9 .9]);
handles.user.link3Vertices = get(handles.user.link3Patch, 'Vertices')';
handles.user.link3Vertices(4,:) = ones(1, size(handles.user.link3Vertices,2));
handles.user.link4Patch = makeLink4(handles.simulation, [.9 .9 .9]);
handles.user.link4Vertices = get(handles.user.link4Patch, 'Vertices')';
handles.user.link4Vertices(4,:) = ones(1, size(handles.user.link4Vertices,2));
handles.user.link5Patch = makeLink5(handles.simulation, [.95 .95 0]);
handles.user.link5Vertices = get(handles.user.link5Patch, 'Vertices')';
handles.user.link5Vertices(4,:) = ones(1, size(handles.user.link5Vertices,2));


dontOpen = false;
mainGuiInput = find(strcmp(varargin,'unlimited_position_test'));
if( isempty(mainGuiInput) )|| (length(varargin) <= mainGuiInput) || (~ishandle(varargin{mainGuiInput+1}))
    dontOpen = true;
else
    handles.unlimitedPositionMain = varargin{mainGuiInput+1};
    mainHandles = guidata(handles.unlimitedPositionMain);
    set(handles.Motor_IDs_number,'String',get(mainHandles.Motor_IDs,'String'));
    handles.user.motorIDs = str2num(get(handles.Motor_IDs_number,'String'));
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
function varargout = set_up_1_arm_motor_IDs_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = [];
delete(hObject);



function motor1_Callback(hObject, eventdata, handles)
% hObject    handle to motor1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of motor1 as text
%        str2double(get(hObject,'String')) returns contents of motor1 as a double
handles.user.motorIDs(1) = str2num(get(handles.motor1,'String'));
set(handles.num1,'String',sprintf('%d',handles.user.motorIDs(1)));
updateArm(hObject, handles);
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function motor1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to motor1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function motor2_Callback(hObject, eventdata, handles)
% hObject    handle to motor2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of motor2 as text
%        str2double(get(hObject,'String')) returns contents of motor2 as a double
handles.user.motorIDs(2) = str2num(get(handles.motor2,'String'));
set(handles.num2,'String',sprintf('%d',handles.user.motorIDs(2)));
updateArm(hObject, handles);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function motor2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to motor2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function motor3_Callback(hObject, eventdata, handles)
% hObject    handle to motor3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of motor3 as text
%        str2double(get(hObject,'String')) returns contents of motor3 as a double
handles.user.motorIDs(3) = str2num(get(handles.motor3,'String'));
set(handles.num3,'String',sprintf('%d',handles.user.motorIDs(3)));
updateArm(hObject, handles);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function motor3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to motor3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function motor4_Callback(hObject, eventdata, handles)
% hObject    handle to motor4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of motor4 as text
%        str2double(get(hObject,'String')) returns contents of motor4 as a double
handles.user.motorIDs(4) = str2num(get(handles.motor4,'String'));
set(handles.num4,'String',sprintf('%d',handles.user.motorIDs(4)));
updateArm(hObject, handles);
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function motor4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to motor4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function motor5_Callback(hObject, eventdata, handles)
% hObject    handle to motor5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of motor5 as text
%        str2double(get(hObject,'String')) returns contents of motor5 as a double
handles.user.motorIDs(5) = str2num(get(handles.motor5,'String'));
set(handles.num5,'String',sprintf('%d',handles.user.motorIDs(5)));
updateArm(hObject, handles);
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function motor5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to motor5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function motor6_Callback(hObject, eventdata, handles)
% hObject    handle to motor6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of motor6 as text
%        str2double(get(hObject,'String')) returns contents of motor6 as a double
handles.user.motorIDs(6) = str2num(get(handles.motor6,'String'));
set(handles.num6,'String',sprintf('%d',handles.user.motorIDs(6)));
updateArm(hObject, handles);
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function motor6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to motor6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function updateArm(hObject, handles)
% DONE: Create the five homogeneous transformation matrices.
[A1,A2,A3,A4,A5] = makeHomogeneousTransformations(...
    handles.user.jointAngles(1),...
    handles.user.jointAngles(2),...
    handles.user.jointAngles(3),...
    handles.user.jointAngles(4),...
    handles.user.jointAngles(5));

% DONE: Use the A matricies to form the T0_n matricies.
T0_1 = A1;
T0_2 = A1 * A2;
T0_3 = A1 * A2 * A3;
T0_4 = A1 * A2 * A3 * A4;
T0_5 = A1 * A2 * A3 * A4 * A5;

% DONE: Use the T matricies to transform the patch vertices
link1verticesWRTground = T0_1 * handles.user.link1Vertices;
link2verticesWRTground = T0_2 * handles.user.link2Vertices;
link3verticesWRTground = T0_3 * handles.user.link3Vertices;
link4verticesWRTground = T0_4 * handles.user.link4Vertices;
link5verticesWRTground = T0_5 * handles.user.link5Vertices;


% DONE: Update the patches with the new vertices.
set(handles.user.link1Patch,'Vertices', link1verticesWRTground(1:3,:)');
set(handles.user.link2Patch,'Vertices', link2verticesWRTground(1:3,:)');
set(handles.user.link3Patch,'Vertices', link3verticesWRTground(1:3,:)');
set(handles.user.link4Patch,'Vertices', link4verticesWRTground(1:3,:)');
set(handles.user.link5Patch,'Vertices', link5verticesWRTground(1:3,:)');

set(handles.num1,'String',sprintf('%d',handles.user.motorIDs(1)));
set(handles.num2,'String',sprintf('%d',handles.user.motorIDs(2)));
set(handles.num3,'String',sprintf('%d',handles.user.motorIDs(3)));
set(handles.num4,'String',sprintf('%d',handles.user.motorIDs(4)));
set(handles.num5,'String',sprintf('%d',handles.user.motorIDs(5)));
set(handles.num6,'String',sprintf('%d',handles.user.motorIDs(6)));

motorIDStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.motorIDs);
set(handles.Motor_IDs_number,'String',motorIDStr);

guidata(hObject, handles);


% --- Executes on button press in send_ID_numbers.
function send_ID_numbers_Callback(hObject, eventdata, handles)
% hObject    handle to send_ID_numbers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
text = sprintf('%d  %d  %d  %d  %d  %d', handles.user.motorIDs);
main = handles.unlimitedPositionMain;
if( ishandle(main) )
    mainHandles = guidata(main);
    motor_ID_text = mainHandles.Motor_IDs;
    set(motor_ID_text, 'String', text);
end
uiresume(handles.figure);


% --- Executes on button press in cancel_button.
function cancel_button_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(handles.figure);

function figure_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(hObject);
