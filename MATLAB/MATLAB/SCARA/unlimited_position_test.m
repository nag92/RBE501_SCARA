function varargout = unlimited_position_test(varargin)
% UNLIMITED_POSITION_TEST MATLAB code for unlimited_position_test.fig
%      UNLIMITED_POSITION_TEST, by itself, creates a new UNLIMITED_POSITION_TEST or raises the existing
%      singleton*.
%
%      H = UNLIMITED_POSITION_TEST returns the handle to a new UNLIMITED_POSITION_TEST or the handle to
%      the existing singleton*.
%
%      UNLIMITED_POSITION_TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNLIMITED_POSITION_TEST.M with the given input arguments.
%
%      UNLIMITED_POSITION_TEST('Property','Value',...) creates a new UNLIMITED_POSITION_TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before unlimited_position_test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to unlimited_position_test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help unlimited_position_test

% Last Modified by GUIDE v2.5 22-Aug-2014 15:52:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @unlimited_position_test_OpeningFcn, ...
                   'gui_OutputFcn',  @unlimited_position_test_OutputFcn, ...
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


% --- Executes just before unlimited_position_test is made visible.
function unlimited_position_test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to unlimited_position_test (see VARARGIN)

% Choose default command line output for unlimited_position_test
handles.output = hObject;

clc

%
handles.user.sendData = [0 0 0 0 0 50 11 12 13 14 15 16];
handles.user.jointAngles = [handles.user.sendData(1),handles.user.sendData(2),handles.user.sendData(3),handles.user.sendData(4),handles.user.sendData(5),handles.user.sendData(6)]; % Initial position.
handles.user.motorIDs = [handles.user.sendData(7),handles.user.sendData(8),handles.user.sendData(9),handles.user.sendData(10),handles.user.sendData(11),handles.user.sendData(12)];

%
handles.user.comportinput=0;
handles.user.serialstatus=0;

% Prepare the arm axes
view(handles.simulation, [-50 -50 50]);
axis(handles.simulation, [-10 10 -6 6 0 12]);
%set(handles.axes_arm, 'Visible', 'off');
grid on;

% Create vertices for all the patches
baseLink(handles.simulation, [.5 .5 .5]);  % Doesn't move so save no references.

% Save handles to the patch objects and create a vertices matrix for each.
servoLink01(handles.simulation, [.9 .9 .9]);

%{
handles.user.link2Patch = makeLink2(handles.simulation, [.9 .9 .9]);
handles.user.link2Vertices = get(handles.user.link2Patch, 'Vertices')';
handles.user.link2Vertices(4,:) = ones(1, size(handles.user .link2Vertices,2));
handles.user.link3Patch = makeLink3(handles.simulation, [.9 .9 .9]);
handles.user.link3Vertices = get(handles.user.link3Patch, 'Vertices')';
handles.user.link3Vertices(4,:) = ones(1, size(handles.user.link3Vertices,2));
handles.user.link4Patch = makeLink4(handles.simulation, [.9 .9 .9]);
handles.user.link4Vertices = get(handles.user.link4Patch, 'Vertices')';
handles.user.link4Vertices(4,:) = ones(1, size(handles.user.link4Vertices,2));
handles.user.link5Patch = makeLink5(handles.simulation, [.95 .95 0]);
handles.user.link5Vertices = get(handles.user.link5Patch, 'Vertices')';
handles.user.link5Vertices(4,:) = ones(1, size(handles.user.link5Vertices,2));
%}


% Move the arm into the HOME position.
updateArm(hObject, handles);


% Update handles structure
guidata(hObject, handles);

setappdata(handles.figure,'waiting',1);

%UIWAIT makes unlimited_position_test wait for user response (see UIRESUME)
uiwait(handles.figure);


% --- Outputs from this function are returned to the command line.
function varargout = unlimited_position_test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

varargout{1} = handles.output; 


% --- Executes on button press in arm1_home_position.
function arm1_home_position_Callback(hObject, eventdata, handles)
% hObject    handle to arm1_home_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
goToPosition(hObject, handles, [0 0 0 0 0 50]);


% --- Executes on button press in arm1_work_position.
function arm1_work_position_Callback(hObject, eventdata, handles)
% hObject    handle to arm1_work_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
goToPosition(hObject, handles, [0 22 86 67 0 50]);


% --- Executes on button press in arm1_Xm.
function arm1_Xm_Callback(hObject, eventdata, handles)
% hObject    handle to arm1_Xm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.jointAngles.cal=updatetheta(handles.user.jointAngles,-0.4,0,0);
if (workspacecheck(handles.user.jointAngles.cal)==1)
    handles.user.jointAngles=handles.user.jointAngles.cal;
goToPosition(hObject, handles, handles.user.jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm1_Zp.
function arm1_Zp_Callback(hObject, eventdata, handles)
% hObject    handle to arm1_Zp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.jointAngles.cal=updatetheta(handles.user.jointAngles,0,0,0.4);
if (workspacecheck(handles.user.jointAngles.cal)==1)
    handles.user.jointAngles=handles.user.jointAngles.cal;
goToPosition(hObject, handles, handles.user.jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm1_Yp.
function arm1_Yp_Callback(hObject, eventdata, handles)
% hObject    handle to arm1_Yp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.jointAngles.cal=updatetheta(handles.user.jointAngles,0,0.4,0);
if (workspacecheck(handles.user.jointAngles.cal)==1)
    handles.user.jointAngles=handles.user.jointAngles.cal;
goToPosition(hObject, handles, handles.user.jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm1_Zm.
function arm1_Zm_Callback(hObject, eventdata, handles)
% hObject    handle to arm1_Zm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.jointAngles.cal=updatetheta(handles.user.jointAngles,0,0,-0.4);
if (workspacecheck(handles.user.jointAngles.cal)==1)
    handles.user.jointAngles=handles.user.jointAngles.cal;
goToPosition(hObject, handles, handles.user.jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm1_Ym.
function arm1_Ym_Callback(hObject, eventdata, handles)
% hObject    handle to arm1_Ym (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.jointAngles.cal=updatetheta(handles.user.jointAngles,0,-0.4,0);
if (workspacecheck(handles.user.jointAngles.cal)==1)
    handles.user.jointAngles=handles.user.jointAngles.cal;
goToPosition(hObject, handles, handles.user.jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on button press in arm1_Xp.
function arm1_Xp_Callback(hObject, eventdata, handles)
% hObject    handle to arm1_Xp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.jointAngles.cal=updatetheta(handles.user.jointAngles,0.4,0,0);
if (workspacecheck(handles.user.jointAngles.cal)==1)
    handles.user.jointAngles=handles.user.jointAngles.cal;
goToPosition(hObject, handles, handles.user.jointAngles);
else
    fprintf('Out of Workspace\n');
end


% --- Executes on slider movement.
function arm1_joint1_Callback(hObject, eventdata, handles)
% hObject    handle to arm1_joint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
jointSliderChange(hObject, handles);


% --- Executes during object creation, after setting all properties.
function arm1_joint1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to arm1_joint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function arm1_joint2_Callback(hObject, eventdata, handles)
% hObject    handle to arm1_joint2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
jointSliderChange(hObject, handles);


% --- Executes during object creation, after setting all properties.
function arm1_joint2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to arm1_joint2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function arm1_joint3_Callback(hObject, eventdata, handles)
% hObject    handle to arm1_joint3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
jointSliderChange(hObject, handles);


% --- Executes during object creation, after setting all properties.
function arm1_joint3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to arm1_joint3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function arm1_joint4_Callback(hObject, eventdata, handles)
% hObject    handle to arm1_joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
jointSliderChange(hObject, handles);


% --- Executes during object creation, after setting all properties.
function arm1_joint4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to arm1_joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function arm1_joint5_Callback(hObject, eventdata, handles)
% hObject    handle to arm1_joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
jointSliderChange(hObject, handles);


% --- Executes during object creation, after setting all properties.
function arm1_joint5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to arm1_joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function arm1_gripper_angle_Callback(hObject, eventdata, handles)
% hObject    handle to arm1_gripper_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
jointSliderChange(hObject, handles);


% --- Executes during object creation, after setting all properties.
function arm1_gripper_angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to arm1_gripper_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function jointSliderChange(hObject, handles)

handles.user.jointAngles(1) = round(get(handles.arm1_joint1, 'Value'));
handles.user.jointAngles(2) = round(get(handles.arm1_joint2, 'Value'));
handles.user.jointAngles(3) = round(get(handles.arm1_joint3, 'Value'));
handles.user.jointAngles(4) = round(get(handles.arm1_joint4, 'Value'));
handles.user.jointAngles(5) = round(get(handles.arm1_joint5, 'Value'));
handles.user.jointAngles(6) = round(get(handles.arm1_gripper_angle, 'Value'));

jointAnglesStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.jointAngles);
set(handles.arm1_current_joint_angles, 'String', jointAnglesStr);

updateArm(hObject, handles);
guidata(hObject, handles);

% --- Executes on button press in arm1_gripper_open.
function arm1_gripper_open_Callback(hObject, eventdata, handles)
% hObject    handle to arm1_gripper_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.jointAngles(6)=50;
goToPosition(hObject, handles, handles.user.jointAngles);


% --- Executes on button press in arm1_gripper_close.
function arm1_gripper_close_Callback(hObject, eventdata, handles)
% hObject    handle to arm1_gripper_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.jointAngles(6)=0;
goToPosition(hObject, handles, handles.user.jointAngles);


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


% --- Executes on button press in PortOpen.
function PortOpen_Callback(hObject, eventdata, handles)
% hObject    handle to PortOpen (see GCBO)
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



function COMport_Callback(hObject, eventdata, handles)
% hObject    handle to COMport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of COMport as text
%        str2double(get(hObject,'String')) returns contents of COMport as a double
handles.user.comport=get(hObject,'String');
fprintf('ComPort:');
fprintf(handles.user.comport);
fprintf('\n');
handles.user.serial=serial(handles.user.comport,'BaudRate',115200);
handles.user.comportinput=1;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function COMport_CreateFcn(hObject, eventdata, handles)
% hObject    handle to COMport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PortClose.
function PortClose_Callback(hObject, eventdata, handles)
% hObject    handle to PortClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fprintf('DONE: Closed serial connect.\n');

open_ports = instrfind('Type','serial','Status','open');
if ~isempty(open_ports)
    fclose(open_ports);
end
handles.user.serialstatus=0;
guidata(hObject, handles);


% --- Executes on button press in save_position.
function save_position_Callback(hObject, eventdata, handles)
% hObject    handle to save_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
jointAnglesStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.jointAngles);
contents = cellstr(get(handles.position_list,'String'));
contents(size(contents,1)+1,1) = {jointAnglesStr};
set(handles.position_list, 'String', contents);
guidata(hObject, handles);


% --- Executes on button press in go_to_position_button.
function go_to_position_button_Callback(hObject, eventdata, handles)
% hObject    handle to go_to_position_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.user.new_Position = str2num(handles.user.position_selected);

goToPosition(hObject, handles, handles.user.new_Position);
handles.user.jointAngles = handles.user.new_Position;
guidata(hObject, handles);


% --- Executes on button press in DeletePosition.
function DeletePosition_Callback(hObject, eventdata, handles)
% hObject    handle to DeletePosition (see GCBO)
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
    


% --- Executes on button press in Go_through_all_positions.
function Go_through_all_positions_Callback(hObject, eventdata, handles)
% hObject    handle to Go_through_all_positions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

items = get(handles.position_list,'String');
if size(items,1) > 1
    for i = 2:size(items,1)
        handles.user.next_Position = str2num(items{i,1});
        goToPosition(hObject, handles, handles.user.next_Position);
        set(handles.position_list,'Value',i);
        guidata(hObject, handles);
        pause(3);
    end
end
guidata(hObject, handles);




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
%link2verticesWRTground = T0_2 * handles.user.link2Vertices;
%link3verticesWRTground = T0_3 * handles.user.link3Vertices;
%link4verticesWRTground = T0_4 * handles.user.link4Vertices;
%link5verticesWRTground = T0_5 * handles.user.link5Vertices;


% DONE: Update the patches with the new vertices.
set(handles.user.link1Patch,'Vertices', link1verticesWRTground(1:3,:)');
set(handles.user.link2Patch,'Vertices', link2verticesWRTground(1:3,:)');
set(handles.user.link3Patch,'Vertices', link3verticesWRTground(1:3,:)');
set(handles.user.link4Patch,'Vertices', link4verticesWRTground(1:3,:)');
set(handles.user.link5Patch,'Vertices', link5verticesWRTground(1:3,:)');

% Update x, y, and z using the gripper (end effector) origin.
dhOrigin = [0 0 0 1]';
eeWRTground = T0_5 * dhOrigin;
set(handles.arm1_X, 'String', sprintf('%.3f"', eeWRTground(1)));
set(handles.arm1_Y, 'String', sprintf('%.3f"', eeWRTground(2)));
set(handles.arm1_Z, 'String', sprintf('%.3f"', eeWRTground(3)));

% Making sure the joint angles are integers before sending to robot (should already be ints).
handles.user.jointAngles(1) = round(handles.user.jointAngles(1));
handles.user.jointAngles(2) = round(handles.user.jointAngles(2));
handles.user.jointAngles(3) = round(handles.user.jointAngles(3));
handles.user.jointAngles(4) = round(handles.user.jointAngles(4));
handles.user.jointAngles(5) = round(handles.user.jointAngles(5));
handles.user.jointAngles(6) = round(handles.user.jointAngles(6));

jointAnglesStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.jointAngles);
set(handles.arm1_current_joint_angles, 'String', jointAnglesStr);

for i = 1:6
    handles.user.sendData(i) = handles.user.jointAngles(i);
end

for i = 7:12
    handles.user.sendData(i) = handles.user.motorIDs(i-6);
end

% TODO: Send a position command to the serial robot if comopen.
%fprintf('TODO: Send a position command to the serial robot if comopen.\n');

if (handles.user.serialstatus==1)
fwrite(handles.user.serial,handles.user.sendData,'int8');
end

guidata(hObject, handles);

function goToPosition(hObject, handles, newPosition)

handles.user.jointAngles = newPosition;

handles.user.jointAngles(1) = round(handles.user.jointAngles(1));
handles.user.jointAngles(2) = round(handles.user.jointAngles(2));
handles.user.jointAngles(3) = round(handles.user.jointAngles(3));
handles.user.jointAngles(4) = round(handles.user.jointAngles(4));
handles.user.jointAngles(5) = round(handles.user.jointAngles(5));
handles.user.jointAngles(6) = round(handles.user.jointAngles(6));

jointAnglesStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.jointAngles);
set(handles.arm1_current_joint_angles, 'String', jointAnglesStr);

set(handles.arm1_joint1, 'Value', handles.user.jointAngles(1));
set(handles.arm1_joint2, 'Value', handles.user.jointAngles(2));
set(handles.arm1_joint3, 'Value', handles.user.jointAngles(3));
set(handles.arm1_joint4, 'Value', handles.user.jointAngles(4));
set(handles.arm1_joint5, 'Value', handles.user.jointAngles(5));
set(handles.arm1_gripper_angle, 'Value', handles.user.jointAngles(6));

updateArm(hObject, handles);

guidata(hObject, handles);


% --- Executes on button press in Motor_ID_Set_Up.
function Motor_ID_Set_Up_Callback(hObject, eventdata, handles)
% hObject    handle to Motor_ID_Set_Up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set_up_1_arm_motor_IDs('unlimited_position_test',handles.figure);
handles.user.motorIDs = str2num(get(handles.Motor_IDs,'String'));
guidata(hObject, handles);
updateArm(hObject, handles);


% --- Executes when user attempts to close figure.
function figure_CloseRequestFcn(hObject,eventdata,handles)
% hObject    handle to figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Check appdata flag to see if the main GUI is in a wait state
if getappdata(handles.figure,'waiting')
    % The GUI is still in UIWAIT, so call UIRESUME and return
    uiresume(hObject);
    setappdata(handles.figure,'waiting',0)
else
    % The GUI is no longer waiting, so destroy it now.
    delete(hObject);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in import.
function import_Callback(hObject, eventdata, handles)
    global myfile
    PositionData = importdata(myfile);
    [l c]=size(PositionData);
    for i = 1:size(PositionData,1)
        handles.user.jointAngles = PositionData(i,:);
        jointAnglesStr = sprintf('%d  %d  %d  %d  %d  %d', handles.user.jointAngles);
        contents = cellstr(get(handles.position_list,'String'));
        contents(size(contents,1)+1,1) = {jointAnglesStr};
        set(handles.position_list, 'String', contents);
     end
guidata(hObject, handles);



function text_Callback(hObject, eventdata, handles)
global myfile
name_file=get(hObject,'String');
myfile = strcat(name_file,'.txt');
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in export.
function export_Callback(hObject, eventdata, handles)
global myfile
fprintf(myfile);
items = get(handles.position_list,'String');
if size(items,1) > 1
    fid = fopen(myfile,'wt');
    %filename = 'SavedPositions.xlsx';
    for i = 2:size(items,1);
        handles.user.next_Position = str2num(items{i,1});
        fprintf(fid,'%s\n',items{i,1});
        %xlswrite(filename, items{i,1});
    end
    fclose(fid);    
end

guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
