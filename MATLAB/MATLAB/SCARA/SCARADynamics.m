%Nathaniel Goldfarb
%Dynamics of the SCARA manipulator

%define the arm
link1=  [0 0 3.68 0];
link2 = [5.24 0 0 0];
link3 = [5.24 -180 2 0];
link4 = [2 0 -3 0];
links = [link1;link2;link3;link4];
plotVel = ones(1,3);
plotAng = ones(1,4);  
plotTorque = ones(1,4);
%set up to perfokrm the calculations
hold on;
axis([-0 20 -20 20 0 20]);
set(gca,'YDir','Reverse')
set(gca,'XDir','Reverse')
grid on;
xlabel('X');
ylabel('Y');
zlabel('Z');
A = ones(4,4,length(links(:,1)));
T = ones(4,4,length(links(:,1)));
%angular velocity = 20RPM
vf = 20;

v = [0;vf;vf;vf];

% Force acting on the arm
f=[0;-.1;0];

%count
n=0;

hold on
rev = 0;
pris = -3;

count = 1;
while ( rev <= 45)
    
%Nathaniel Goldfarb
%Dynamics of the SCARA manipulator

%define the arm
link1=  [0 0 3.68 0];
link2 = [5.24 0 0 rev];
link3 = [5.24 -180 2 rev];
link4 = [2 0 pris 0];
links = [link1;link2;link3;link4];

%set up to perfokrm the calculations
hold on;
axis([-0 20 -20 20 0 20]);
set(gca,'YDir','Reverse')
set(gca,'XDir','Reverse')
grid on;
xlabel('X');
ylabel('Y');
zlabel('Z');
A = ones(4,4,length(links(:,1)));
T = ones(4,4,length(links(:,1)));
%angular velocity = 20RPM

%Make the new links    
A = getA(links);
T = getT(A);


 %Get the Jacobain
[o,On] = getO(T);

o;
z = getZ(T);
j1 = getPrisJ(z(:,1));
j2 = getRevJ(z(:,2),On,o(:,2));
j3 = getRevJ(z(:,3),On,o(:,3));
j4 = getPrisJ(z(:,4));

J = [j1 j2 j3 j4] 
jV = J(1:3,:);
jW = J(4:6,:);



%%
%Get the velocities of the end effector
velocity = J*v;

linearV = velocity(1:3);
angluarV = velocity(3:end);
    
    %%
    %Get the torques on the joints
t = jV.' * f;


%increament the joints
rev = rev+ 5;
pris = pris +  1;


%extract the X,Y,Z coordindats
x = squeeze(T(1,4,:));
y = squeeze(T(2,4,:));
z = squeeze(T(3,4,:));
x = x';
y = y';
z = z';
xPlot = [0 x];
yPlot = [0 y];
zPlot = [0 z];

%%
% Print endeffector data
disp('End Effector');
disp(' Step ');
disp(n);
% Location
disp(' Location ');
disp(' X ');
disp(xPlot(end));
disp(' Y ');
disp(yPlot(end));
disp(' Z ');
disp(zPlot(end));

% Velocity
disp(' Linear Velocity ');
disp(linearV);



disp(' angluar Velocity ');
disp(angluarV);


%Torque
disp(' Torque ');
disp(t);


%%
%plot the kinimatic chain and pause
plot3(xPlot,yPlot,zPlot,'black','LineWidth',4);
plot3(xPlot(end),yPlot(end),zPlot(end),'x','LineWidth',8);
%pause(.5);

plotAng(count,:) = angluarV;
plotVel(count,:) = linearV;
plotTorque(count,:) = t;
count= count + 1;
end

 %%
plotAng
plotTorque
plotVel
%%
%Angular Velocity
figure(2);
hold on 
title('x Angular Velocity');
ylabel('RMP');
xlabel('theta (degrees)');
plot(0:5:45,plotAng(:,1),'LineWidth',1);
hold off

figure(3);
hold on
title('y Angular Velocity');
ylabel('RMP');
xlabel('theta (degrees)');
plot(0:5:45,plotAng(:,2),'LineWidth',1);
hold off
 
figure(4);
hold on
title('z Angular Velocity');
ylabel('RMP');
xlabel('theta (degrees)');
plot(0:5:45,plotAng(:,3),'LineWidth',1);
hold off


%Linear Velocity
figure(5);
hold on 
title('x Linear Velocity');
ylabel('in/min');
xlabel('theta (degrees)');
plot(0:5:45,plotVel(:,1),'LineWidth',1);
hold off

figure(6);
hold on
title('y Linear Velocity');
ylabel('in/min');
xlabel('theta (degrees)');
plot(0:5:45,plotVel(:,2),'LineWidth',1);
hold off
 
figure(7);
hold on
title('z Linear Velocity');
ylabel('in/min');
xlabel('theta (degrees)');
plot(0:5:45,plotVel(:,3),'LineWidth',1);
hold off

%Torque
figure(8);
hold on 
title('x Torque');
ylabel('lb-in');
xlabel('theta (degrees)');
plot(0:5:45,plotTorque(:,2),'LineWidth',1);
hold off

figure(9);
hold on
title('y Torque');
ylabel('lb-in');
xlabel('theta (degrees)');
plot(0:5:45,plotTorque(:,3),'LineWidth',1);
hold off
 
figure(10);
hold on
title('z Torque');
ylabel('lb-in');
xlabel('theta (degrees)');
plot(0:5:45,plotTorque(:,4),'LineWidth',1);
hold off





