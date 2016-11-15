function varargout = multi_robot_arms(varargin)
% MULTI_ROBOT_ARMS MATLAB code for multi_robot_arms.fig
%      MULTI_ROBOT_ARMS, by itself, creates a new MULTI_ROBOT_ARMS or raises the existing
%      singleton*.
%
%      H = MULTI_ROBOT_ARMS returns the handle to a new MULTI_ROBOT_ARMS or the handle to
%      the existing singleton*.
%
%      MULTI_ROBOT_ARMS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MULTI_ROBOT_ARMS.M with the given input arguments.
%
%      MULTI_ROBOT_ARMS('Property','Value',...) creates a new MULTI_ROBOT_ARMS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before multi_robot_arms_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to multi_robot_arms_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help multi_robot_arms

% Last Modified by GUIDE v2.5 03-Jul-2014 16:08:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @multi_robot_arms_OpeningFcn, ...
                   'gui_OutputFcn',  @multi_robot_arms_OutputFcn, ...
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


% --- Executes just before multi_robot_arms is made visible.
function multi_robot_arms_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to multi_robot_arms (see VARARGIN)

% Choose default command line output for multi_robot_arms
handles.output = hObject;

clc

%Set Initial Position
handles.user.jointAngles = [0 0 0 0 0 50 0 0 0 0 0 50 0 0 0 0 0 50 0 0 0 0 0 50];
handles.user.arm1jointAngles = [handles.user.jointAngles(1), handles.user.jointAngles(2), handles.user.jointAngles(3), handles.user.jointAngles(4), handles.user.jointAngles(5), handles.user.jointAngles(6)];
handles.user.arm2jointAngles = [handles.user.jointAngles(7), handles.user.jointAngles(8), handles.user.jointAngles(9), handles.user.jointAngles(10), handles.user.jointAngles(11), handles.user.jointAngles(12)];
handles.user.arm3jointAngles = [handles.user.jointAngles(13), handles.user.jointAngles(14), handles.user.jointAngles(15), handles.user.jointAngles(16), handles.user.jointAngles(17), handles.user.jointAngles(18)];
handles.user.arm4jointAngles = [handles.user.jointAngles(19), handles.user.jointAngles(20), handles.user.jointAngles(21), handles.user.jointAngles(22), handles.user.jointAngles(23), handles.user.jointAngles(24)];

%Set defualt motor ID numbers
handles.user.motorIDs = [11 12 13 14 15 16 21 22 23 24 25 26 31 32 33 34 35 36 41 42 43 44 45 46];
handles.user.arm1motorIDs = [handles.user.motorIDs(1), handles.user.motorIDs(2), handles.user.motorIDs(3), handles.user.motorIDs(4), handles.user.motorIDs(5), handles.user.motorIDs(6)];
handles.user.arm2motorIDs = [handles.user.motorIDs(7), handles.user.motorIDs(8), handles.user.motorIDs(9), handles.user.motorIDs(10), handles.user.motorIDs(11), handles.user.motorIDs(12)];
handles.user.arm3motorIDs = [handles.user.motorIDs(13), handles.user.motorIDs(14), handles.user.motorIDs(15), handles.user.motorIDs(16), handles.user.motorIDs(17), handles.user.motorIDs(18)];
handles.user.arm4motorIDs = [handles.user.motorIDs(19), handles.user.motorIDs(20), handles.user.motorIDs(21), handles.user.motorIDs(22), handles.user.motorIDs(23), handles.user.motorIDs(24)];

handles.user.sendData = zeros(1,24);
handles.user.sendData = [handles.user.jointAngles, handles.user.jointAngles];
%
handles.user.comportinput=0;
handles.user.serialstatus=0;

% Prepare the arm axes
view(handles.simulation, [-50 -50 50]);
axis(handles.simulation, [-11 11 -8 8 0 18]);
grid on;
%set(handles.simulation, 'Visible', 'off');

% Create vertices for all the patches
% Save handles to the patch objects and create a vertices matrix for each arm.
% Link number increases from bottom part to the top


%-----------------ARM1---------------------------------------------------%
makeLink10(handles.simulation, [.4 0 .6]);
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
makeLink20(handles.simulation, [0 .9 0]);
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
makeLink30(handles.simulation, [.9 0 .3]);
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
makeLink40(handles.simulation, [0 .8 .8]);
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

% Move the arm into the HOME position.
updateArm(hObject, handles);

% Update handles structure
guidata(hObject, handles);

setappdata(handles.figure,'waiting',1);

% UIWAIT makes multi_robot_arms wait for user response (see UIRESUME)
uiwait(handles.figure);


% --- Outputs from this function are returned to the command line.
function varargout = multi_robot_arms_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in COM_open.
function COM_open_Callback(hObject, eventdata, handles)
% hObject    handle to COM_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.user.comportinput==1)
% COMClose any comopen connections first
open_ports = instrfind('Type','serial','Status','open');
if ~isempty(open_ports)
    fclose(open_ports);
end
fopen(handles.user.serial);
handles.user.serialstatus=1;
fprintf('TODO: Open a serial connection to the robot arm.\n');
else
        fprintf('Please input COMPort and click <<ENTER>> on your keyboard.\n');
end
guidata(hObject, handles);



% --- Executes on button press in COM_close.
function COM_close_Callback(hObject, eventdata, handles)
% hObject    handle to COM_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fprintf('DONE: Closed serial connect.\n');

open_ports = instrfind('Type','serial','Status','open');
if ~isempty(open_ports)
    fclose(open_ports);
end
handles.user.serialstatus=0;
guidata(hObject, handles);



function COM_Callback(hObject, eventdata, handles)
% hObject    handle to COM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of COM as text
%        str2double(get(hObject,'String')) returns contents of COM as a double
handles.user.comport=get(hObject,'String');
fprintf('ComPort:');
fprintf(handles.user.comport);
fprintf('\n');
handles.user.serial=serial(handles.user.comport,'BaudRate',115200);
handles.user.comportinput=1;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function COM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to COM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%-------------------------------ARM1-----------------------------------

function arm1_jointSliderChange(hObject,handles)

handles.user.arm1jointAngles(1) = round(get(handles.slider_arm1_joint1, 'Value'));
handles.user.arm1jointAngles(2) = round(get(handles.slider_arm1_joint2, 'Value'));
handles.user.arm1jointAngles(3) = round(get(handles.slider_arm1_joint3, 'Value'));
handles.user.arm1jointAngles(4) = round(get(handles.slider_arm1_joint4, 'Value'));
handles.user.arm1jointAngles(5) = round(get(handles.slider_arm1_joint5, 'Value'));
handles.user.arm1jointAngles(6) = round(get(handles.slider_arm1_gripper, 'Value'));

jointAnglesStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.arm1jointAngles);
set(handles.ARM1_current_joint_angles, 'String', jointAnglesStr);

updateArm(hObject, handles);
guidata(hObject, handles);


% --- Executes on button press in pushbutton_arm1_home_position.
function pushbutton_arm1_home_position_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_arm1_home_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
arm1goToPosition(hObject, handles, [0 0 0 0 0 50]);


% --- Executes on button press in pushbutton_arm1_work_position.
function pushbutton_arm1_work_position_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_arm1_work_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
arm1goToPosition(hObject, handles, [0 22 86 67 0 50]);


% --- Executes on button press in arm1_Xm.
function arm1_Xm_Callback(hObject, eventdata, handles)
% hObject    handle to arm1_Xm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm1jointAngles.cal=updatetheta(handles.user.arm1jointAngles,-0.4,0,0);
if (workspacecheck(handles.user.arm1jointAngles.cal)==1)
    handles.user.arm1jointAngles=handles.user.arm1jointAngles.cal;
arm1goToPosition(hObject, handles, handles.user.arm1jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm1_Ym.
function arm1_Ym_Callback(hObject, eventdata, handles)
% hObject    handle to arm1_Ym (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm1jointAngles.cal=updatetheta(handles.user.arm1jointAngles,0,-0.4,0);
if (workspacecheck(handles.user.arm1jointAngles.cal)==1)
    handles.user.arm1jointAngles=handles.user.arm1jointAngles.cal;
arm1goToPosition(hObject, handles, handles.user.arm1jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm1_Zm.
function arm1_Zm_Callback(hObject, eventdata, handles)
% hObject    handle to arm1_Zm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm1jointAngles.cal=updatetheta(handles.user.arm1jointAngles,0,0,-0.4);
if (workspacecheck(handles.user.arm1jointAngles.cal)==1)
    handles.user.arm1jointAngles=handles.user.arm1jointAngles.cal;
arm1goToPosition(hObject, handles, handles.user.arm1jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm1_Xp.
function arm1_Xp_Callback(hObject, eventdata, handles)
% hObject    handle to arm1_Xp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm1jointAngles.cal=updatetheta(handles.user.arm1jointAngles,0.4,0,0);
if (workspacecheck(handles.user.arm1jointAngles.cal)==1)
    handles.user.arm1jointAngles=handles.user.arm1jointAngles.cal;
arm1goToPosition(hObject, handles, handles.user.arm1jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm1_Zp.
function arm1_Zp_Callback(hObject, eventdata, handles)
% hObject    handle to arm1_Zp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm1jointAngles.cal=updatetheta(handles.user.arm1jointAngles,0,0,0.4);
if (workspacecheck(handles.user.arm1jointAngles.cal)==1)
    handles.user.arm1jointAngles=handles.user.arm1jointAngles.cal;
arm1goToPosition(hObject, handles, handles.user.arm1jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm1_Yp.
function arm1_Yp_Callback(hObject, eventdata, handles)
% hObject    handle to arm1_Yp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm1jointAngles.cal=updatetheta(handles.user.arm1jointAngles,0,0.4,0);
if (workspacecheck(handles.user.arm1jointAngles.cal)==1)
    handles.user.arm1jointAngles=handles.user.arm1jointAngles.cal;
arm1goToPosition(hObject, handles, handles.user.arm1jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on slider movement.
function slider_arm1_joint1_Callback(hObject, eventdata, handles)
% hObject    handle to slider_arm1_joint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
arm1_jointSliderChange(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_arm1_joint1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_arm1_joint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_arm1_joint2_Callback(hObject, eventdata, handles)
% hObject    handle to slider_arm1_joint2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
arm1_jointSliderChange(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_arm1_joint2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_arm1_joint2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_arm1_joint3_Callback(hObject, eventdata, handles)
% hObject    handle to slider_arm1_joint3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
arm1_jointSliderChange(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_arm1_joint3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_arm1_joint3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_arm1_joint4_Callback(hObject, eventdata, handles)
% hObject    handle to slider_arm1_joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
arm1_jointSliderChange(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_arm1_joint4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_arm1_joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_arm1_joint5_Callback(hObject, eventdata, handles)
% hObject    handle to slider_arm1_joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
arm1_jointSliderChange(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_arm1_joint5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_arm1_joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_arm1_gripper_Callback(hObject, eventdata, handles)
% hObject    handle to slider_arm1_gripper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
arm1_jointSliderChange(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_arm1_gripper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_arm1_gripper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton_arm1_open.
function pushbutton_arm1_open_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_arm1_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm1jointAngles(6)=50;
arm1goToPosition(hObject, handles, handles.user.arm1jointAngles);


% --- Executes on button press in pushbutton_arm1_close.
function pushbutton_arm1_close_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_arm1_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm1jointAngles(6)=0;
arm1goToPosition(hObject, handles, handles.user.arm1jointAngles);

function arm1goToPosition(hObject, handles, newPosition)

handles.user.arm1jointAngles = newPosition;

handles.user.arm1jointAngles(1) = round(handles.user.arm1jointAngles(1));
handles.user.arm1jointAngles(2) = round(handles.user.arm1jointAngles(2));
handles.user.arm1jointAngles(3) = round(handles.user.arm1jointAngles(3));
handles.user.arm1jointAngles(4) = round(handles.user.arm1jointAngles(4));
handles.user.arm1jointAngles(5) = round(handles.user.arm1jointAngles(5));
handles.user.arm1jointAngles(6) = round(handles.user.arm1jointAngles(6));

jointAnglesStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.arm1jointAngles);
set(handles.ARM1_current_joint_angles, 'String', jointAnglesStr);

set(handles.slider_arm1_joint1, 'Value', handles.user.arm1jointAngles(1));
set(handles.slider_arm1_joint2, 'Value', handles.user.arm1jointAngles(2));
set(handles.slider_arm1_joint3, 'Value', handles.user.arm1jointAngles(3));
set(handles.slider_arm1_joint4, 'Value', handles.user.arm1jointAngles(4));
set(handles.slider_arm1_joint5, 'Value', handles.user.arm1jointAngles(5));
set(handles.slider_arm1_gripper, 'Value', handles.user.arm1jointAngles(6));

updateArm(hObject, handles);

guidata(hObject, handles);

%-------------------------------ARM1-----------------------------------



%-------------------------------ARM2-----------------------------------


% --- Executes on button press in arm2_home_position.
function arm2_home_position_Callback(hObject, eventdata, handles)
% hObject    handle to arm2_home_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
arm2goToPosition(hObject, handles, [0 0 0 0 0 50]);


% --- Executes on button press in arm2_work_position.
function arm2_work_position_Callback(hObject, eventdata, handles)
% hObject    handle to arm2_work_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
arm2goToPosition(hObject, handles, [0 22 86 67 0 50]);



% --- Executes on button press in arm2_Xm.
function arm2_Xm_Callback(hObject, eventdata, handles)
% hObject    handle to arm2_Xm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm2jointAngles.cal=updatetheta(handles.user.arm2jointAngles,-0.4,0,0);
if (workspacecheck(handles.user.arm2jointAngles.cal)==1)
    handles.user.arm2jointAngles=handles.user.arm2jointAngles.cal;
arm2goToPosition(hObject, handles, handles.user.arm2jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm2_Zp.
function arm2_Zp_Callback(hObject, eventdata, handles)
% hObject    handle to arm2_Zp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm2jointAngles.cal=updatetheta(handles.user.arm2jointAngles,0,0,0.4);
if (workspacecheck(handles.user.arm2jointAngles.cal)==1)
    handles.user.arm2jointAngles=handles.user.arm2jointAngles.cal;
arm2goToPosition(hObject, handles, handles.user.arm2jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm2_Yp.
function arm2_Yp_Callback(hObject, eventdata, handles)
% hObject    handle to arm2_Yp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm2jointAngles.cal=updatetheta(handles.user.arm2jointAngles,0,0.4,0);
if (workspacecheck(handles.user.arm2jointAngles.cal)==1)
    handles.user.arm2jointAngles=handles.user.arm2jointAngles.cal;
arm2goToPosition(hObject, handles, handles.user.arm2jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm2_Xp.
function arm2_Xp_Callback(hObject, eventdata, handles)
% hObject    handle to arm2_Xp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm2jointAngles.cal=updatetheta(handles.user.arm2jointAngles,0.4,0,0);
if (workspacecheck(handles.user.arm2jointAngles.cal)==1)
    handles.user.arm2jointAngles=handles.user.arm2jointAngles.cal;
arm2goToPosition(hObject, handles, handles.user.arm2jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm2_Zm.
function arm2_Zm_Callback(hObject, eventdata, handles)
% hObject    handle to arm2_Zm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm2jointAngles.cal=updatetheta(handles.user.arm2jointAngles,0,0,-0.4);
if (workspacecheck(handles.user.arm2jointAngles.cal)==1)
    handles.user.arm2jointAngles=handles.user.arm2jointAngles.cal;
goToPosition(hObject, handles, handles.user.arm2jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm2_Ym.
function arm2_Ym_Callback(hObject, eventdata, handles)
% hObject    handle to arm2_Ym (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm2jointAngles.cal=updatetheta(handles.user.arm2jointAngles,0,-0.4,0);
if (workspacecheck(handles.user.arm2jointAngles.cal)==1)
    handles.user.arm2jointAngles=handles.user.arm2jointAngles.cal;
arm2goToPosition(hObject, handles, handles.user.arm2jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on slider movement.
function slider_arm2_joint1_Callback(hObject, eventdata, handles)
% hObject    handle to slider_arm2_joint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
arm2_jointSliderChange(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_arm2_joint1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_arm2_joint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_arm2_joint2_Callback(hObject, eventdata, handles)
% hObject    handle to slider_arm2_joint2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
arm2_jointSliderChange(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_arm2_joint2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_arm2_joint2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_arm2_joint3_Callback(hObject, eventdata, handles)
% hObject    handle to slider_arm2_joint3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
arm2_jointSliderChange(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_arm2_joint3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_arm2_joint3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_arm2_joint4_Callback(hObject, eventdata, handles)
% hObject    handle to slider_arm2_joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
arm2_jointSliderChange(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_arm2_joint4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_arm2_joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_arm2_joint5_Callback(hObject, eventdata, handles)
% hObject    handle to slider_arm2_joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
arm2_jointSliderChange(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_arm2_joint5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_arm2_joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_arm2_gripper_Callback(hObject, eventdata, handles)
% hObject    handle to slider_arm2_gripper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
arm2_jointSliderChange(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_arm2_gripper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_arm2_gripper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton_arm2_gripper_open.
function pushbutton_arm2_gripper_open_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_arm2_gripper_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm2jointAngles(6)=50;
arm2goToPosition(hObject, handles, handles.user.arm2jointAngles);


% --- Executes on button press in pushbutton_arm2_gripper_close.
function pushbutton_arm2_gripper_close_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_arm2_gripper_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm2jointAngles(6)=0;
arm2goToPosition(hObject, handles, handles.user.arm2jointAngles);

function arm2_jointSliderChange(hObject,handles)

handles.user.arm2jointAngles(1) = round(get(handles.slider_arm2_joint1, 'Value'));
handles.user.arm2jointAngles(2) = round(get(handles.slider_arm2_joint2, 'Value'));
handles.user.arm2jointAngles(3) = round(get(handles.slider_arm2_joint3, 'Value'));
handles.user.arm2jointAngles(4) = round(get(handles.slider_arm2_joint4, 'Value'));
handles.user.arm2jointAngles(5) = round(get(handles.slider_arm2_joint5, 'Value'));
handles.user.arm2jointAngles(6) = round(get(handles.slider_arm2_gripper, 'Value'));

jointAnglesStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.arm2jointAngles);
set(handles.ARM2_current_joint_angles, 'String', jointAnglesStr);

updateArm(hObject, handles);
guidata(hObject, handles);

function arm2goToPosition(hObject, handles, newPosition)

handles.user.arm2jointAngles = newPosition;

handles.user.arm2jointAngles(1) = round(handles.user.arm2jointAngles(1));
handles.user.arm2jointAngles(2) = round(handles.user.arm2jointAngles(2));
handles.user.arm2jointAngles(3) = round(handles.user.arm2jointAngles(3));
handles.user.arm2jointAngles(4) = round(handles.user.arm2jointAngles(4));
handles.user.arm2jointAngles(5) = round(handles.user.arm2jointAngles(5));
handles.user.arm2jointAngles(6) = round(handles.user.arm2jointAngles(6));

jointAnglesStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.arm2jointAngles);
set(handles.ARM2_current_joint_angles, 'String', jointAnglesStr);

set(handles.slider_arm2_joint1, 'Value', handles.user.arm2jointAngles(1));
set(handles.slider_arm2_joint2, 'Value', handles.user.arm2jointAngles(2));
set(handles.slider_arm2_joint3, 'Value', handles.user.arm2jointAngles(3));
set(handles.slider_arm2_joint4, 'Value', handles.user.arm2jointAngles(4));
set(handles.slider_arm2_joint5, 'Value', handles.user.arm2jointAngles(5));
set(handles.slider_arm2_gripper, 'Value', handles.user.arm2jointAngles(6));

updateArm(hObject, handles);

guidata(hObject, handles);

%-------------------------------ARM2-----------------------------------


%-------------------------------ARM3-----------------------------------

% --- Executes on button press in arm3_home_position.
function arm3_home_position_Callback(hObject, eventdata, handles)
% hObject    handle to arm3_home_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
arm3goToPosition(hObject, handles, [0 0 0 0 0 50]);


% --- Executes on button press in arm3_work_position.
function arm3_work_position_Callback(hObject, eventdata, handles)
% hObject    handle to arm3_work_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
arm3goToPosition(hObject, handles, [0 22 86 67 0 50]);

% --- Executes on button press in arm3_Xm.
function arm3_Xm_Callback(hObject, eventdata, handles)
% hObject    handle to arm3_Xm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm3jointAngles.cal=updatetheta(handles.user.arm3jointAngles,-0.4,0,0);
if (workspacecheck(handles.user.arm3jointAngles.cal)==1)
    handles.user.arm3jointAngles=handles.user.arm3jointAngles.cal;
arm3goToPosition(hObject, handles, handles.user.arm3jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm3_Zp.
function arm3_Zp_Callback(hObject, eventdata, handles)
% hObject    handle to arm3_Zp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm3jointAngles.cal=updatetheta(handles.user.arm3jointAngles,0,0,0.4);
if (workspacecheck(handles.user.arm3jointAngles.cal)==1)
    handles.user.arm3jointAngles=handles.user.arm3jointAngles.cal;
arm3goToPosition(hObject, handles, handles.user.arm3jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm3_Yp.
function arm3_Yp_Callback(hObject, eventdata, handles)
% hObject    handle to arm3_Yp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm3jointAngles.cal=updatetheta(handles.user.arm3jointAngles,0,0.4,0);
if (workspacecheck(handles.user.arm3jointAngles.cal)==1)
    handles.user.arm3jointAngles=handles.user.arm3jointAngles.cal;
arm3goToPosition(hObject, handles, handles.user.arm3jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm3_Xp.
function arm3_Xp_Callback(hObject, eventdata, handles)
% hObject    handle to arm3_Xp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm3jointAngles.cal=updatetheta(handles.user.arm3jointAngles,0.4,0,0);
if (workspacecheck(handles.user.arm3jointAngles.cal)==1)
    handles.user.arm3jointAngles=handles.user.arm3jointAngles.cal;
arm3goToPosition(hObject, handles, handles.user.arm3jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm3_Zm.
function arm3_Zm_Callback(hObject, eventdata, handles)
% hObject    handle to arm3_Zm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm3jointAngles.cal=updatetheta(handles.user.arm3jointAngles,0,0,-0.4);
if (workspacecheck(handles.user.arm3jointAngles.cal)==1)
    handles.user.arm3jointAngles=handles.user.arm3jointAngles.cal;
arm3goToPosition(hObject, handles, handles.user.arm3jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm3_Ym.
function arm3_Ym_Callback(hObject, eventdata, handles)
% hObject    handle to arm3_Ym (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm3jointAngles.cal=updatetheta(handles.user.arm3jointAngles,0,-0.4,0);
if (workspacecheck(handles.user.arm3jointAngles.cal)==1)
    handles.user.arm3jointAngles=handles.user.arm3jointAngles.cal;
arm3goToPosition(hObject, handles, handles.user.arm3jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on slider movement.
function slider_arm3_joint1_Callback(hObject, eventdata, handles)
% hObject    handle to slider_arm3_joint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
arm3_jointSliderChange(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_arm3_joint1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_arm3_joint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_arm3_joint2_Callback(hObject, eventdata, handles)
% hObject    handle to slider_arm3_joint2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
arm3_jointSliderChange(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_arm3_joint2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_arm3_joint2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_arm3_joint3_Callback(hObject, eventdata, handles)
% hObject    handle to slider_arm3_joint3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
arm3_jointSliderChange(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_arm3_joint3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_arm3_joint3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_arm3_joint4_Callback(hObject, eventdata, handles)
% hObject    handle to slider_arm3_joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
arm3_jointSliderChange(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_arm3_joint4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_arm3_joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_arm3_joint5_Callback(hObject, eventdata, handles)
% hObject    handle to slider_arm3_joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
arm3_jointSliderChange(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_arm3_joint5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_arm3_joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_arm3_gripper_Callback(hObject, eventdata, handles)
% hObject    handle to slider_arm3_gripper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
arm3_jointSliderChange(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_arm3_gripper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_arm3_gripper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton_arm3_gripper_open.
function pushbutton_arm3_gripper_open_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_arm3_gripper_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm3jointAngles(6)=50;
arm3goToPosition(hObject, handles, handles.user.arm3jointAngles);



% --- Executes on button press in pushbutton_arm3_gripper_close.
function pushbutton_arm3_gripper_close_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_arm3_gripper_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm3jointAngles(6)=0;
arm3goToPosition(hObject, handles, handles.user.arm3jointAngles);

function arm3_jointSliderChange(hObject,handles)

handles.user.arm3jointAngles(1) = round(get(handles.slider_arm3_joint1, 'Value'));
handles.user.arm3jointAngles(2) = round(get(handles.slider_arm3_joint2, 'Value'));
handles.user.arm3jointAngles(3) = round(get(handles.slider_arm3_joint3, 'Value'));
handles.user.arm3jointAngles(4) = round(get(handles.slider_arm3_joint4, 'Value'));
handles.user.arm3jointAngles(5) = round(get(handles.slider_arm3_joint5, 'Value'));
handles.user.arm3jointAngles(6) = round(get(handles.slider_arm3_gripper, 'Value'));

jointAnglesStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.arm3jointAngles);
set(handles.ARM3_current_joint_angles, 'String', jointAnglesStr);

updateArm(hObject, handles);
guidata(hObject, handles);

function arm3goToPosition(hObject, handles, newPosition)

handles.user.arm3jointAngles = newPosition;

handles.user.arm3jointAngles(1) = round(handles.user.arm3jointAngles(1));
handles.user.arm3jointAngles(2) = round(handles.user.arm3jointAngles(2));
handles.user.arm3jointAngles(3) = round(handles.user.arm3jointAngles(3));
handles.user.arm3jointAngles(4) = round(handles.user.arm3jointAngles(4));
handles.user.arm3jointAngles(5) = round(handles.user.arm3jointAngles(5));
handles.user.arm3jointAngles(6) = round(handles.user.arm3jointAngles(6));

jointAnglesStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.arm3jointAngles);
set(handles.ARM3_current_joint_angles, 'String', jointAnglesStr);

set(handles.slider_arm3_joint1, 'Value', handles.user.arm3jointAngles(1));
set(handles.slider_arm3_joint2, 'Value', handles.user.arm3jointAngles(2));
set(handles.slider_arm3_joint3, 'Value', handles.user.arm3jointAngles(3));
set(handles.slider_arm3_joint4, 'Value', handles.user.arm3jointAngles(4));
set(handles.slider_arm3_joint5, 'Value', handles.user.arm3jointAngles(5));
set(handles.slider_arm3_gripper, 'Value', handles.user.arm3jointAngles(6));

updateArm(hObject, handles);

guidata(hObject, handles);
%-------------------------------ARM3-----------------------------------%


%-------------------------------ARM4-----------------------------------%

% --- Executes on button press in arm4_home_position.
function arm4_home_position_Callback(hObject, eventdata, handles)
% hObject    handle to arm4_home_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
arm4goToPosition(hObject, handles, [0 0 0 0 0 50]);


% --- Executes on button press in arm4_work_position.
function arm4_work_position_Callback(hObject, eventdata, handles)
% hObject    handle to arm4_work_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
arm4goToPosition(hObject, handles, [0 22 86 67 0 50]);

% --- Executes on button press in arm4_Xm.
function arm4_Xm_Callback(hObject, eventdata, handles)
% hObject    handle to arm4_Xm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm4jointAngles.cal=updatetheta(handles.user.arm4jointAngles,-0.4,0,0);
if (workspacecheck(handles.user.arm4jointAngles.cal)==1)
    handles.user.arm4jointAngles=handles.user.arm4jointAngles.cal;
arm4goToPosition(hObject, handles, handles.user.arm4jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm4_Zp.
function arm4_Zp_Callback(hObject, eventdata, handles)
% hObject    handle to arm4_Zp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm4jointAngles.cal=updatetheta(handles.user.arm4jointAngles,0,0,0.4);
if (workspacecheck(handles.user.arm4jointAngles.cal)==1)
    handles.user.arm4jointAngles=handles.user.arm4jointAngles.cal;
arm4goToPosition(hObject, handles, handles.user.arm4jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm4_Yp.
function arm4_Yp_Callback(hObject, eventdata, handles)
% hObject    handle to arm4_Yp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm4jointAngles.cal=updatetheta(handles.user.arm4jointAngles,0,0.4,0);
if (workspacecheck(handles.user.arm4jointAngles.cal)==1)
    handles.user.arm4jointAngles=handles.user.arm4jointAngles.cal;
arm4goToPosition(hObject, handles, handles.user.arm4jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm4_Xp.
function arm4_Xp_Callback(hObject, eventdata, handles)
% hObject    handle to arm4_Xp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm4jointAngles.cal=updatetheta(handles.user.arm4jointAngles,0.4,0,0);
if (workspacecheck(handles.user.arm4jointAngles.cal)==1)
    handles.user.arm4jointAngles=handles.user.arm4jointAngles.cal;
arm4goToPosition(hObject, handles, handles.user.arm4jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm4_Zm.
function arm4_Zm_Callback(hObject, eventdata, handles)
% hObject    handle to arm4_Zm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm4jointAngles.cal=updatetheta(handles.user.arm4jointAngles,0,0,-0.4);
if (workspacecheck(handles.user.arm4jointAngles.cal)==1)
    handles.user.arm4jointAngles=handles.user.arm4jointAngles.cal;
arm4goToPosition(hObject, handles, handles.user.arm4jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm4_Ym.
function arm4_Ym_Callback(hObject, eventdata, handles)
% hObject    handle to arm4_Ym (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm4jointAngles.cal=updatetheta(handles.user.arm4jointAngles,0,-0.4,0);
if (workspacecheck(handles.user.arm4jointAngles.cal)==1)
    handles.user.arm4jointAngles=handles.user.arm4jointAngles.cal;
arm4goToPosition(hObject, handles, handles.user.arm4jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on slider movement.
function slider_arm4_joint1_Callback(hObject, eventdata, handles)
% hObject    handle to slider_arm4_joint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
arm4_jointSliderChange(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_arm4_joint1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_arm4_joint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_arm4_joint2_Callback(hObject, eventdata, handles)
% hObject    handle to slider_arm4_joint2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
arm4_jointSliderChange(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_arm4_joint2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_arm4_joint2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_arm4_joint3_Callback(hObject, eventdata, handles)
% hObject    handle to slider_arm4_joint3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
arm4_jointSliderChange(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_arm4_joint3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_arm4_joint3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_arm4_joint4_Callback(hObject, eventdata, handles)
% hObject    handle to slider_arm4_joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
arm4_jointSliderChange(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_arm4_joint4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_arm4_joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_arm4_joint5_Callback(hObject, eventdata, handles)
% hObject    handle to slider_arm4_joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
arm4_jointSliderChange(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_arm4_joint5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_arm4_joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_arm4_gripper_Callback(hObject, eventdata, handles)
% hObject    handle to slider_arm4_gripper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
arm4_jointSliderChange(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_arm4_gripper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_arm4_gripper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton_arm4_gripper_open.
function pushbutton_arm4_gripper_open_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_arm4_gripper_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm4jointAngles(6)=50;
arm4goToPosition(hObject, handles, handles.user.arm4jointAngles);


% --- Executes on button press in pushbutton_arm4_gripper_close.
function pushbutton_arm4_gripper_close_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_arm4_gripper_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.arm4jointAngles(6)=0;
arm4goToPosition(hObject, handles, handles.user.arm4jointAngles);

function arm4_jointSliderChange(hObject,handles)

handles.user.arm4jointAngles(1) = round(get(handles.slider_arm4_joint1, 'Value'));
handles.user.arm4jointAngles(2) = round(get(handles.slider_arm4_joint2, 'Value'));
handles.user.arm4jointAngles(3) = round(get(handles.slider_arm4_joint3, 'Value'));
handles.user.arm4jointAngles(4) = round(get(handles.slider_arm4_joint4, 'Value'));
handles.user.arm4jointAngles(5) = round(get(handles.slider_arm4_joint5, 'Value'));
handles.user.arm4jointAngles(6) = round(get(handles.slider_arm4_gripper, 'Value'));

jointAnglesStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.arm4jointAngles);
set(handles.ARM4_current_joint_angles, 'String', jointAnglesStr);

updateArm(hObject, handles);
guidata(hObject, handles);

function arm4goToPosition(hObject, handles, newPosition)

handles.user.arm4jointAngles = newPosition;

handles.user.arm4jointAngles(1) = round(handles.user.arm4jointAngles(1));
handles.user.arm4jointAngles(2) = round(handles.user.arm4jointAngles(2));
handles.user.arm4jointAngles(3) = round(handles.user.arm4jointAngles(3));
handles.user.arm4jointAngles(4) = round(handles.user.arm4jointAngles(4));
handles.user.arm4jointAngles(5) = round(handles.user.arm4jointAngles(5));
handles.user.arm4jointAngles(6) = round(handles.user.arm4jointAngles(6));

jointAnglesStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.arm4jointAngles);
set(handles.ARM4_current_joint_angles, 'String', jointAnglesStr);

set(handles.slider_arm4_joint1, 'Value', handles.user.arm4jointAngles(1));
set(handles.slider_arm4_joint2, 'Value', handles.user.arm4jointAngles(2));
set(handles.slider_arm4_joint3, 'Value', handles.user.arm4jointAngles(3));
set(handles.slider_arm4_joint4, 'Value', handles.user.arm4jointAngles(4));
set(handles.slider_arm4_joint5, 'Value', handles.user.arm4jointAngles(5));
set(handles.slider_arm4_gripper, 'Value', handles.user.arm4jointAngles(6));

updateArm(hObject, handles);

guidata(hObject, handles);
%-------------------------------ARM4-----------------------------------%



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
AA1(1,4) = 10;
AA1(2,4) = 5.75;

T1_1 = A11 + AA1;
T1_2 = A11 * A12 + AA1;
T1_3 = A11 * A12 * A13 + AA1;
T1_4 = A11 * A12 * A13 * A14 + AA1;
T1_5 = A11 * A12 * A13 * A14 * A15 + AA1;

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

% Update x, y, and z using the gripper (end effector) origin.
arm1dhOrigin = [0 0 0 1]';
arm1eeWRTground = T1_5 * arm1dhOrigin;
set(handles.arm1_X, 'String', sprintf('%.3f"', arm1eeWRTground(1)));
set(handles.arm1_Y, 'String', sprintf('%.3f"', arm1eeWRTground(2)));
set(handles.arm1_Z, 'String', sprintf('%.3f"', arm1eeWRTground(3)));

% Making sure the joint angles are integers before sending to robot (should already be ints).
handles.user.arm1jointAngles(1) = round(handles.user.arm1jointAngles(1));
handles.user.arm1jointAngles(2) = round(handles.user.arm1jointAngles(2));
handles.user.arm1jointAngles(3) = round(handles.user.arm1jointAngles(3));
handles.user.arm1jointAngles(4) = round(handles.user.arm1jointAngles(4));
handles.user.arm1jointAngles(5) = round(handles.user.arm1jointAngles(5));
handles.user.arm1jointAngles(6) = round(handles.user.arm1jointAngles(6));

jointAnglesStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.arm1jointAngles);
set(handles.ARM1_current_joint_angles, 'String', jointAnglesStr);

for i = 1:6;
    handles.user.sendData(i) = handles.user.arm1jointAngles(i);
end

for i = 25:30;
    handles.user.sendData(i) = handles.user.arm1motorIDs(i-24);
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
AA2(1,4) = 10;
AA2(2,4) = -5.75;

T2_1 = A21 + AA2;
T2_2 = A21 * A22 + AA2;
T2_3 = A21 * A22 * A23 + AA2;
T2_4 = A21 * A22 * A23 * A24 + AA2;
T2_5 = A21 * A22 * A23 * A24 * A25 + AA2;

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

% Update x, y, and z using the gripper (end effector) origin.
arm2dhOrigin = [0 0 0 1]';
arm2eeWRTground = T2_5 * arm2dhOrigin;
set(handles.arm2_X, 'String', sprintf('%.3f"', arm2eeWRTground(1)));
set(handles.arm2_Y, 'String', sprintf('%.3f"', arm2eeWRTground(2)));
set(handles.arm2_Z, 'String', sprintf('%.3f"', arm2eeWRTground(3)));

% Making sure the joint angles are integers before sending to robot (should already be ints).
handles.user.arm2jointAngles(1) = round(handles.user.arm2jointAngles(1));
handles.user.arm2jointAngles(2) = round(handles.user.arm2jointAngles(2));
handles.user.arm2jointAngles(3) = round(handles.user.arm2jointAngles(3));
handles.user.arm2jointAngles(4) = round(handles.user.arm2jointAngles(4));
handles.user.arm2jointAngles(5) = round(handles.user.arm2jointAngles(5));
handles.user.arm2jointAngles(6) = round(handles.user.arm2jointAngles(6));

jointAnglesStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.arm2jointAngles);
set(handles.ARM2_current_joint_angles, 'String', jointAnglesStr);

for i = 7:12;
    handles.user.sendData(i) = handles.user.arm2jointAngles(i-6);
end

for i = 31:36;
    handles.user.sendData(i) = handles.user.arm2motorIDs(i-30);
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
AA3(1,4) = -10;
AA3(2,4) = -5.75;

TRANS = zeros(4,4);
TRANS(1,1) = -1;
TRANS(2,2) = -1;
TRANS(3,3) = 1;
TRANS(4,4) = 1;

T3_1 = TRANS * A31+AA3;
T3_2 = TRANS * A31 * A32  + AA3;
T3_3 = TRANS * A31 * A32 * A33  +AA3;
T3_4 = TRANS * A31 * A32 * A33 * A34  + AA3;
T3_5 = TRANS * A31 * A32 * A33 * A34 * A35+AA3;

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

% Update x, y, and z using the gripper (end effector) origin.
arm3dhOrigin = [0 0 0 1]';
arm3eeWRTground = T3_5 * arm3dhOrigin;
set(handles.arm3_X, 'String', sprintf('%.3f"', arm3eeWRTground(1)));
set(handles.arm3_Y, 'String', sprintf('%.3f"', arm3eeWRTground(2)));
set(handles.arm3_Z, 'String', sprintf('%.3f"', arm3eeWRTground(3)));

% Making sure the joint angles are integers before sending to robot (should already be ints).
handles.user.arm3jointAngles(1) = round(handles.user.arm3jointAngles(1));
handles.user.arm3jointAngles(2) = round(handles.user.arm3jointAngles(2));
handles.user.arm3jointAngles(3) = round(handles.user.arm3jointAngles(3));
handles.user.arm3jointAngles(4) = round(handles.user.arm3jointAngles(4));
handles.user.arm3jointAngles(5) = round(handles.user.arm3jointAngles(5));
handles.user.arm3jointAngles(6) = round(handles.user.arm3jointAngles(6));

jointAnglesStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.arm3jointAngles);
set(handles.ARM3_current_joint_angles, 'String', jointAnglesStr);

for i = 13:18;
    handles.user.sendData(i) = handles.user.arm3jointAngles(i-12);
end

for i = 37:42;
    handles.user.sendData(i) = handles.user.arm3motorIDs(i-36);
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
AA4(1,4) = -10;
AA4(2,4) = 5.75;

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

% Update x, y, and z using the gripper (end effector) origin.
arm4dhOrigin = [0 0 0 1]';
arm4eeWRTground = T4_5 * arm4dhOrigin;
set(handles.arm4_X, 'String', sprintf('%.3f"', arm4eeWRTground(1)));
set(handles.arm4_Y, 'String', sprintf('%.3f"', arm4eeWRTground(2)));
set(handles.arm4_Z, 'String', sprintf('%.3f"', arm4eeWRTground(3)));

% Making sure the joint angles are integers before sending to robot (should already be ints).
handles.user.arm4jointAngles(1) = round(handles.user.arm4jointAngles(1));
handles.user.arm4jointAngles(2) = round(handles.user.arm4jointAngles(2));
handles.user.arm4jointAngles(3) = round(handles.user.arm4jointAngles(3));
handles.user.arm4jointAngles(4) = round(handles.user.arm4jointAngles(4));
handles.user.arm4jointAngles(5) = round(handles.user.arm4jointAngles(5));
handles.user.arm4jointAngles(6) = round(handles.user.arm4jointAngles(6));

jointAnglesStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.arm4jointAngles);
set(handles.ARM4_current_joint_angles, 'String', jointAnglesStr);

for i = 19:24
    handles.user.sendData(i) = handles.user.arm4jointAngles(i-18);
end

for i = 43:48
    handles.user.sendData(i) = handles.user.arm4motorIDs(i-42);
end

guidata(hObject, handles);

%------------------------------------------------------------------------------%



% TODO: Send a position command to the serial robot if comopen.
%fprintf('TODO: Send a position command to the serial robot if comopen.\n');

if (handles.user.serialstatus==1)
    fwrite(handles.user.serial,handles.user.sendData,'int8');
end
guidata(hObject, handles);


% --- Executes on selection change in position_list.
function position_list_Callback(hObject, eventdata, handles)
% hObject    handle to position_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns position_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from position_list
handles.user.items = get(hObject,'String');
handles.user.index_selected = get(hObject,'Value');
handles.user.position_selected = handles.user.items{handles.user.index_selected};
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function position_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to position_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Save_position.
function Save_position_Callback(hObject, eventdata, handles)
% hObject    handle to Save_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%arm1jointAnglesStr = get(handles.ARM1_current_joint_angles,'String');
%arm2jointAnglesStr = get(handles.ARM2_current_joint_angles,'String');
%arm3jointAnglesStr = get(handles.ARM3_current_joint_angles,'String');
%arm4jointAnglesStr = get(handles.ARM4_current_joint_angles,'String');

%jointAnglesStr = strcat(arm1jointAnglesStr,[' '],arm2jointAnglesStr,[' '],arm3jointAnglesStr,[' '],arm4jointAnglesStr);
jointAnglesStr = sprintf('%d  %d  %d  %d  %d  %d %d  %d  %d  %d  %d  %d %d  %d  %d  %d  %d  %d %d  %d  %d  %d  %d  %d', handles.user.arm1jointAngles,handles.user.arm2jointAngles,handles.user.arm3jointAngles,handles.user.arm4jointAngles);
contents = cellstr(get(handles.position_list,'String'));
contents(size(contents,1)+1,1) = {jointAnglesStr};
set(handles.position_list, 'String', contents);
guidata(hObject, handles);


% --- Executes on button press in Go_to_position_button.
function Go_to_position_button_Callback(hObject, eventdata, handles)
% hObject    handle to Go_to_position_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.user.new_Position = str2num(handles.user.position_selected);

goToPosition(hObject,handles,handles.user.new_Position);

handles.user.jointAngles = handles.user.new_Position;
guidata(hObject, handles);


% --- Executes on button press in Delete_position.
function Delete_position_Callback(hObject, eventdata, handles)
% hObject    handle to Delete_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
len = length(handles.user.items);
if len > 0
    if handles.user.index_selected(1) == 1
        indices = [( handles.user.index_selected(end) + 1) : length(handles.user.items )];
    else
        indices = [1 : (handles.user.index_selected(1)-1) (handles.user.index_selected(end)+1) : length(handles.user.items)];
    end
    handles.user.items = handles.user.items(indices);
    set(handles.position_list,'String',handles.user.items,'Value',min(handles.user.index_selected,length(handles.user.items)));
end
guidata(hObject, handles);


% --- Executes on button press in go_through_all_positions.
function go_through_all_positions_Callback(hObject, eventdata, handles)
% hObject    handle to go_through_all_positions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
items = get(handles.position_list,'String');
if size(items,1) > 1
    for i = 2:size(items,1)
        handles.user.next_Position = str2num(items{i,1});
        goToPosition(hObject,handles,handles.user.next_Position);
        set(handles.position_list, 'Value', i);
        guidata(hObject, handles);
        pause(5);
    end
end
guidata(hObject, handles);


function goToPosition(hObject,handles,newPosition)

handles.user.jointAngles = newPosition;

handles.user.arm1jointAngles(1) = round(handles.user.jointAngles(1));
handles.user.arm1jointAngles(2) = round(handles.user.jointAngles(2));
handles.user.arm1jointAngles(3) = round(handles.user.jointAngles(3));
handles.user.arm1jointAngles(4) = round(handles.user.jointAngles(4));
handles.user.arm1jointAngles(5) = round(handles.user.jointAngles(5));
handles.user.arm1jointAngles(6) = round(handles.user.jointAngles(6));

handles.user.arm2jointAngles(1) = round(handles.user.jointAngles(7));
handles.user.arm2jointAngles(2) = round(handles.user.jointAngles(8));
handles.user.arm2jointAngles(3) = round(handles.user.jointAngles(9));
handles.user.arm2jointAngles(4) = round(handles.user.jointAngles(10));
handles.user.arm2jointAngles(5) = round(handles.user.jointAngles(11));
handles.user.arm2jointAngles(6) = round(handles.user.jointAngles(12));

handles.user.arm3jointAngles(1) = round(handles.user.jointAngles(13));
handles.user.arm3jointAngles(2) = round(handles.user.jointAngles(14));
handles.user.arm3jointAngles(3) = round(handles.user.jointAngles(15));
handles.user.arm3jointAngles(4) = round(handles.user.jointAngles(16));
handles.user.arm3jointAngles(5) = round(handles.user.jointAngles(17));
handles.user.arm3jointAngles(6) = round(handles.user.jointAngles(18));

handles.user.arm4jointAngles(1) = round(handles.user.jointAngles(19));
handles.user.arm4jointAngles(2) = round(handles.user.jointAngles(20));
handles.user.arm4jointAngles(3) = round(handles.user.jointAngles(21));
handles.user.arm4jointAngles(4) = round(handles.user.jointAngles(22));
handles.user.arm4jointAngles(5) = round(handles.user.jointAngles(23));
handles.user.arm4jointAngles(6) = round(handles.user.jointAngles(24));

arm1jointAnglesStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.arm1jointAngles);
set(handles.ARM1_current_joint_angles, 'String', arm1jointAnglesStr);
arm2jointAnglesStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.arm2jointAngles);
set(handles.ARM2_current_joint_angles, 'String', arm2jointAnglesStr);
arm3jointAnglesStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.arm3jointAngles);
set(handles.ARM3_current_joint_angles, 'String', arm3jointAnglesStr);
arm4jointAnglesStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.arm4jointAngles);
set(handles.ARM4_current_joint_angles, 'String', arm4jointAnglesStr);

set(handles.slider_arm1_joint1, 'Value', handles.user.arm1jointAngles(1));
set(handles.slider_arm1_joint2, 'Value', handles.user.arm1jointAngles(2));
set(handles.slider_arm1_joint3, 'Value', handles.user.arm1jointAngles(3));
set(handles.slider_arm1_joint4, 'Value', handles.user.arm1jointAngles(4));
set(handles.slider_arm1_joint5, 'Value', handles.user.arm1jointAngles(5));
set(handles.slider_arm1_gripper, 'Value', handles.user.arm1jointAngles(6));

set(handles.slider_arm2_joint1, 'Value', handles.user.arm2jointAngles(1));
set(handles.slider_arm2_joint2, 'Value', handles.user.arm2jointAngles(2));
set(handles.slider_arm2_joint3, 'Value', handles.user.arm2jointAngles(3));
set(handles.slider_arm2_joint4, 'Value', handles.user.arm2jointAngles(4));
set(handles.slider_arm2_joint5, 'Value', handles.user.arm2jointAngles(5));
set(handles.slider_arm2_gripper, 'Value', handles.user.arm2jointAngles(6));

set(handles.slider_arm3_joint1, 'Value', handles.user.arm3jointAngles(1));
set(handles.slider_arm3_joint2, 'Value', handles.user.arm3jointAngles(2));
set(handles.slider_arm3_joint3, 'Value', handles.user.arm3jointAngles(3));
set(handles.slider_arm3_joint4, 'Value', handles.user.arm3jointAngles(4));
set(handles.slider_arm3_joint5, 'Value', handles.user.arm3jointAngles(5));
set(handles.slider_arm3_gripper, 'Value', handles.user.arm3jointAngles(6));

set(handles.slider_arm4_joint1, 'Value', handles.user.arm4jointAngles(1));
set(handles.slider_arm4_joint2, 'Value', handles.user.arm4jointAngles(2));
set(handles.slider_arm4_joint3, 'Value', handles.user.arm4jointAngles(3));
set(handles.slider_arm4_joint4, 'Value', handles.user.arm4jointAngles(4));
set(handles.slider_arm4_joint5, 'Value', handles.user.arm4jointAngles(5));
set(handles.slider_arm4_gripper, 'Value', handles.user.arm4jointAngles(6));

updateArm(hObject, handles);

guidata(hObject, handles);


% --- Executes on button press in Set_Up_Motor_IDs.
function Set_Up_Motor_IDs_Callback(hObject, eventdata, handles)
% hObject    handle to Set_Up_Motor_IDs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set_up_4_arm_motor_IDs('multi_robot_arms',handles.figure);
handles.user.arm1motorIDs = str2num(get(handles.Arm1_motor_IDs,'String'));
handles.user.arm2motorIDs = str2num(get(handles.Arm2_motor_IDs,'String'));
handles.user.arm3motorIDs = str2num(get(handles.Arm3_motor_IDs,'String'));
handles.user.arm4motorIDs = str2num(get(handles.Arm4_motor_IDs,'String'));
guidata(hObject, handles);
updateArm(hObject, handles);
