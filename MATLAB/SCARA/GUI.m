function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new G UI or raises the
%      existing singleton*.  Starting from the left,property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 05-Apr-2015 14:22:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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

% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;
% My code
% prepare the varibles
handles.user.sendData = [0 0 0 0 0 50 11 12 13 14 15 16];
handles.user.jointAngles = [handles.user.sendData(1),handles.user.sendData(2),handles.user.sendData(3)]; % Initial position.
handles.user.motorIDs = [handles.user.sendData(7),handles.user.sendData(8),handles.user.sendData(9),handles.user.sendData(10),handles.user.sendData(11),handles.user.sendData(12)];
handles.user.comportinput=0;
handles.user.serialstatus=0;

% prepare the graph
view(handles.simulation, [5 5 5]);
axis(handles.simulation, [-2 20 -2 20 0 20]);
zlabel('z');
ylabel('y');
xlabel('x');
%set(gca,'YDir','Reverse');
%set(gca,'XDir','Reverse');
%set(handles.axes_arm, 'Visible', 'off');
grid on;
%Graphic link code here

% Create vertices for all the patches
% Doesn't move so save no references.
baseLink(handles.simulation, [.7 .59 .39]);  
cylinder1(handles.simulation, [.25 .8 .3]);

% Save handles to the patch objects and create a vertices matrix for each.
%armLink01
handles.user.link1Patch = armLink01(handles.simulation, [.1 .7 .3]);
handles.user.link1Vertices = get(handles.user.link1Patch, 'Vertices')';
handles.user.link1Vertices(4,:) = ones(1, size(handles.user.link1Vertices,2));
%servoLink02
handles.user.link2Patch = cylinder2(handles.simulation, [.5 .3 .1]);
handles.user.link2Vertices = get(handles.user.link2Patch, 'Vertices')';
handles.user.link2Vertices(4,:) = ones(1, size(handles.user.link2Vertices,2));
%armLink02
handles.user.link3Patch = armLink02(handles.simulation, [.4 .1 .7]);
handles.user.link3Vertices = get(handles.user.link3Patch, 'Vertices')';
handles.user.link3Vertices(4,:) = ones(1, size(handles.user.link3Vertices,2));
%linearLink
handles.user.link4Patch = linearLink(handles.simulation, [.95 .95 0]);
handles.user.link4Vertices = get(handles.user.link4Patch, 'Vertices')';
handles.user.link4Vertices(4,:) = ones(1, size(handles.user.link4Vertices,2));
%Servo3
handles.user.link5Patch = servoLink3(handles.simulation, [.95 .5 .74]);
handles.user.link5Vertices = get(handles.user.link5Patch, 'Vertices')';
handles.user.link5Vertices(4,:) = ones(1, size(handles.user.link5Vertices,2));


%update code here
updateArm(hObject, handles);
% Update handles structure
guidata(hObject, handles);

%My code
setappdata(handles.simulation,'waiting',1);

% UIWAIT makes GUI wait for user response (see UIRESUME)
handles.user.comportinput=0;
handles.user.serialstatus=0;


 uiwait(handles.figure1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%BUTTONS%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Magnet.
function Magnet_Callback(hObject, eventdata, handles)
% hObject    handle to Magnet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Magnet

arduino =  strcat( num2str(3) , ',' )
%send string to arduino through open serial
if (handles.user.serialstatus==1)
   fprintf(handles.user.serial,arduino);
end

if get(hObject,'Value')
    set(hObject, 'BackgroundColor','green')
else
    set(hObject, 'BackgroundColor','red')
end

% --- Executes on button press in inverseGo.
% hObject    handle to inverseGo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnhome.
function btnhome_Callback(hObject, eventdata, handles)
% hObject    handle to btnhome (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%build string to send to ardiuno
%512 is the offset nessasery to bring the servo to the center. it was
%detrimed using the dyminaxle sofware. 
x = 180;
y = 180;
z = 0;
arduino = strcat( num2str(1) , ',' ,  num2str(150) , ',' ,  num2str (150), ',' ,num2str (0) , ','  )
%send string to arduino through open serial
if (handles.user.serialstatus==1)
   fprintf(handles.user.serial,arduino);
end
%send string to arduino through open serial

handles.user.jointAngles(1) = -150;
handles.user.jointAngles(2) = -150;
handles.user.jointAngles(3) = z;

set( handles.joint1_slider, 'Value', handles.user.jointAngles(1));
set( handles.joint2_slider, 'Value', handles.user.jointAngles(2));
set( handles.joint3_slider, 'Value', handles.user.jointAngles(3));

%Display the joints
angles = [x,y,z];
disp('angles ');
disp(angles);

jointAnglesStr = sprintf('%d  %d  %d', angles);
set(handles.jointPos, 'String', jointAnglesStr);
%update the simulation

updateArm(hObject, handles);



% --- Executes on button press in btnwork.
function btnwork_Callback(hObject, eventdata, handles)
% hObject    handle to btnwork (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = 150;
y = 150;
z = -3;
arduino = strcat(  num2str(1) , ',' ,  num2str(x) , ',' ,  num2str (y), ',' ,num2str (z) , ','  )
%send string to arduino through open serial
if (handles.user.serialstatus==1)
   fprintf(handles.user.serial,arduino);
end

handles.user.jointAngles(1) = 0;
handles.user.jointAngles(2) = 0;
handles.user.jointAngles(3) = 0;

set( handles.joint1_slider, 'Value', handles.user.jointAngles(1));
set( handles.joint2_slider, 'Value', handles.user.jointAngles(2));
set( handles.joint3_slider, 'Value', handles.user.jointAngles(3));

%Display the joints
angles = [0,0,-3];
disp('angles ');
disp(angles);

jointAnglesStr = sprintf('%d  %d  %d', angles);
set(handles.jointPos, 'String', jointAnglesStr);
%update the simulation

updateArm(hObject, handles);



% --- Executes on button press in btnMotor.
function btnMotor_Callback(hObject, eventdata, handles)
% hObject    handle to btnMotor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
m1 = get(handles.txtmotor1,'String');
m2 = get(handles.txtmotor2,'String');
m3 = get(handles.txtmotor3,'String');

arduino = strcat(  num2str(2) , ',' , m1 , ',' , m2, ',' , m3 , ','  );

%send string to arduino through open serial
if (handles.user.serialstatus==1)
   fprintf(handles.user.serial,arduino);
end


%close the Serial port
% --- Executes on button press in btnClose.
function btnClose_Callback(hObject, eventdata, handles)
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

%open the serial port using data from txtPort_Callback
% --- Executes on button press in btnOpen.
function btnOpen_Callback(hObject, eventdata, handles)
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


function inverseGo_Callback(hObject, eventdata, handles)
%Get the data form the the textboxs
x = get(handles.xtxt,'String');
y = get(handles.ytxt,'String');
z = get(handles.ztxt,'String');

%Cheak if a number was captured. if not set it to a deflault
disp(x);
disp(y);
disp(z);
%if the joint textbox is empty make it zero
if( isempty(x))
    x = 0;
end

if( isempty(y))
    y = 0;
end

if( isempty(z)) 
    z = 0;
end
invearse(hObject, handles, x,y,z)


% --- Executes on button press in cameraGo.
function cameraGo_Callback(hObject, eventdata, handles)
% hObject    handle to cameraGo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
id = get(handles.txtcamera,'String'); 
z= get(handles.txtzCameraPos, 'String');

if (isempty(z))
    z = -3;
end

if( isempty(id))
    id = 3;
end

arduino = strcat( num2str(1) , ',' , num2str(180-150) , ',' ,  num2str (180-150), ',' ,num2str (z) , ','  );

%send string to arduino through open serial
if (handles.user.serialstatus==1)
   fprintf(handles.user.serial,arduino);
end
pause(3);

pos = camera(3);

x = 14 - pos(1);
y = pos(2);


invearse(hObject, handles, num2str(x),num2str(y),num2str(z))



% --- Executes on button press in btnmotorID.
function btnmotorID_Callback(hObject, eventdata, handles)

% hObject    handle to btnMotor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
m1 = get(handles.txtmotor1,'String');
m2 = get(handles.txtmotor2,'String');
m3 = get(handles.txtmotor3,'String');

arduino = strcat(  num2str(2) , ',' , m1 , ',' , m2, ',' , m3 , ','  )

%send string to arduino through open serial
if (handles.user.serialstatus==1)
   fprintf(handles.user.serial,arduino);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%SLIDERS%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on slider movement.
function joint1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to joint1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

jointSliderChange(hObject, handles);
% --- Executes during object creation, after setting all properties.



% --- Executes on slider movement.
function joint3_slider_Callback(hObject, eventdata, handles)
% hObject    handle to joint3_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
jointSliderChange(hObject, handles);

% --- Executes during object creation, after setting all properties.



% --- Executes on slider movement.
function joint2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to joint2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
jointSliderChange(hObject, handles);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%LABLES%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%TEXTBOX%%%%%%%%%%%%%%%%%%%%%%


function txtsave_Callback(hObject, eventdata, handles)
% hObject    handle to txtsave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtsave as text
%        str2double(get(hObject,'String')) returns contents of txtsave as a double


function txtPort_Callback(hObject, eventdata, handles)
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

function txtmotor1_Callback(hObject, eventdata, handles)
% hObject    handle to txtmotor1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtmotor1 as text
%        str2double(get(hObject,'String')) returns contents of txtmotor1 as a double


function txtmotor2_Callback(hObject, eventdata, handles)
% hObject    handle to txtmotor2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtmotor2 as text
%        str2double(get(hObject,'String')) returns contents of txtmotor2 as a double

function txtmotor3_Callback(hObject, eventdata, handles)
% hObject    handle to txtmotor3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtmotor3 as text
%        str2double(get(hObject,'String')) returns contents of txtmotor3 as a double


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%LISTBOXES%%%%%%%%%%%%%%%%%%%%%

% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1

% --- Executes during object creation, after setting all properties.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%MY CODE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%update if a slider moves
function jointSliderChange(hObject, handles)

%get values form sliders
handles.user.jointAngles(1) = round(get(handles.joint1_slider, 'Value'));
handles.user.jointAngles(2) = round(get(handles.joint2_slider, 'Value'));
handles.user.jointAngles(3) = round(get(handles.joint3_slider, 'Value'));
%print the slider values
jointAnglesStr = sprintf('%d  %d  %d', handles.user.jointAngles);
set(handles.jointPos, 'String', jointAnglesStr);
%update the simulation
updateArm(hObject, handles);
guidata(hObject, handles);

function updateArm(hObject, handles)
%update the arm
%DH code, calculate the positions
link1 = [ 0 0 3.68 0];
link2 = [ 5.24 0 0 handles.user.jointAngles(1)];
link3 = [ 5.24 -180 2 handles.user.jointAngles(2)];
link4 = [ 2 0 handles.user.jointAngles(3)*-1 0];%!!!!!!!!!!Normilize link4(angle -> length)!!!!!!!!!

%Display joint angles
% disp(handles.user.jointAngles(1));
% disp(handles.user.jointAngles(2));
% disp(handles.user.jointAngles(3));
%DH Math stuff
links = [link1;link2;link3;link4];
A = ones(4,4,length(links(:,1)));
T = ones(4,4,length(links(:,1)));
A = getA(links);
T = getT(A);

x = T(1,4,4);
y = T(2,4,4);
z = T(3,4,4);

pos = round([x,y,z]);
posStr = sprintf('%d  %d  %d', pos);



set(handles.position, 'String', posStr);

%Transform the graphic with the transformation matrix from DH
link1verticesWRTground = T(:,:,2) * handles.user.link1Vertices;
link2verticesWRTground = T(:,:,2) * handles.user.link2Vertices;
link3verticesWRTground = T(:,:,3) * handles.user.link3Vertices;
link5verticesWRTground = T(:,:,3) * handles.user.link5Vertices;
link4verticesWRTground = T(:,:,4) * handles.user.link4Vertices;

%build string to send to ardiuno
%512 is the offset nessasery to bring the servo to the center. it was
%detrimed using the dyminaxle sofware. 
arduino = strcat(  num2str(1) , ',' , num2str(handles.user.jointAngles(1)+150) , ',' ,  num2str (handles.user.jointAngles(2)+150), ',' ,num2str (handles.user.jointAngles(3)) , ','  )
%send string to arduino through open serial
if (handles.user.serialstatus==1)
   fprintf(handles.user.serial,arduino);
end
 

%update the simulation
set(handles.user.link1Patch,'Vertices', link1verticesWRTground(1:3,:)');
set(handles.user.link2Patch,'Vertices', link2verticesWRTground(1:3,:)');
set(handles.user.link3Patch,'Vertices', link3verticesWRTground(1:3,:)');
set(handles.user.link4Patch,'Vertices', link4verticesWRTground(1:3,:)');
set(handles.user.link5Patch,'Vertices', link5verticesWRTground(1:3,:)');



function invearse(hObject, handles,x,y,z)
%Get the inverse kinamatics
%Apparetly strdouble is FASTER then str2num
angles = inverseKinamatics(str2double(x), str2double(y),str2double(z) );
%update the joints for the plot
arduino = strcat(  num2str(1) , ',' , num2str(angles(1)+150) , ',' ,  num2str ( angles(2)+150), ',' ,num2str ( angles(3)) , ','  );

%send string to arduino through open serial
if (handles.user.serialstatus==1)
   fprintf(handles.user.serial,arduino);
end

handles.user.jointAngles(1) = angles(1);
handles.user.jointAngles(2) = angles(2);
handles.user.jointAngles(3) = angles(3);

set( handles.joint1_slider, 'Value', handles.user.jointAngles(1));
set( handles.joint2_slider, 'Value', handles.user.jointAngles(2));
set( handles.joint3_slider, 'Value', handles.user.jointAngles(3));
%Display the joints
disp('angles ');
disp(angles);

jointAnglesStr = sprintf('%d  %d  %d', angles);

set(handles.jointPos, 'String', jointAnglesStr);
%update the simulation
updateArm(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%Other%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function txtzCameraPos_Callback(hObject, eventdata, handles)
% hObject    handle to txtzCameraPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtzCameraPos as text
%        str2double(get(hObject,'String')) returns contents of txtzCameraPos as a double


% --- Executes during object creation, after setting all properties.
function txtzCameraPos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtzCameraPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function txtPort_CreateFcn(hObject, eventdata, handles)
% hObject    handle to COMport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function xtxt_Callback(hObject, eventdata, handles)
% hObject    handle to xtxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xtxt as text
%        str2double(get(hObject,'String')) returns contents of xtxt as a double


% --- Executes during object creation, after setting all properties.
function xtxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xtxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ytxt_Callback(hObject, eventdata, handles)
% hObject    handle to ytxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ytxt as text
%        str2double(get(hObject,'String')) returns contents of ytxt as a double


% --- Executes during object creation, after setting all properties.
function ytxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ytxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ztxt_Callback(hObject, eventdata, handles)
% hObject    handle to ztxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ztxt as text
%        str2double(get(hObject,'String')) returns contents of ztxt as a double

% --- Executes during object creation, after setting all properties.
function ztxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ztxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txtcamera_Callback(hObject, eventdata, handles)
% hObject    handle to txtcamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtcamera as text
%        str2double(get(hObject,'String')) returns contents of txtcamera as a double


% --- Executes during object creation, after setting all properties.
function txtcamera_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtcamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function txtsave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtsave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function joint2_upper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to joint2_upper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function joint2_lower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to joint2_lower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function joint1_upper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to joint1_upper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function joint3_upper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to joint3_upper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function joint3_lower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to joint3_lower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function joint2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to joint2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function joint3_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to joint3_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function joint1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to joint1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function jointPos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jointPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function txtmotor1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtmotor1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function txtmotor2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtmotor2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function txtmotor3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtmotor3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
