i thought %Nathaniel Goldfarb
%Dynamics of the SCARA manipulator

%define the arm
link1=  [0 0 3.68 0];
link2 = [5.24 0 0 0];
link3 = [5.24 -180 2 0];
link4 = [2 0 0 0];
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
T = getT(A)


 %Get the Jacobain
[o,On] = getO(T);

o
z = getZ(T)
j1 = getPrisJ(z(:,1));
j2 = getRevJ(z(:,2),On,o(:,2));
j3 = getRevJ(z(:,3),On,o(:,3));
j4 = getPrisJ(z(:,4));

J = [j1 j2 j3 j4] 
jV = J(1:3,:);
jW = J(4:6,:);


