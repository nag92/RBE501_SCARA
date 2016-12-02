close all 
clear all
clc
%% 
% set up the joint paths
pathRaw = load('totalPath.mat')
path = pathRaw.totalPath
blockq1= path{1,1};
blockq1(1)
blockq2= path{1,2};
blockq2(1)
time = 5;
start = [planTraj( 0,blockq1(1),time);...
          planTraj(0,blockq2(1),time)]
start_path = [ polyval(start(1,:),0:time );polyval(start(2,:),0:time )]

joint1 = []% [start_path(1,:)];
joint2 = []% [start_path(2,:)];

for ii = 1:length(path)
    joint1 = [ joint1, path{ii}(:)'];
    joint2 = [ joint2, path{ii,2}(:)'];
end

%%
% set up the arm and background picture

red = load('red2')
blue = load('blue2')
green = load('green2')
scale = 54;
red = red.red.box;
green = green.green.box;
blue = blue.blue.box;
box = [red;green;blue]

a1 = 5.24;
a2 = a1+2;
yDist = 31.965;
xDist = 39.75667;  

p = correctPoint(0.5*(box(:,1)+box(:,3)),0.5*(box(:,3)+box(:,4))) ;
xList(:,1) =  (0.5*(box(:,1)+box(:,3)))/xDist  - 640/(2*xDist);
yList(:,1) =  (480 - ( 0.5*(box(:,2)+box(:,4))))/yDist ;


scrsz = get(0,'ScreenSize');
figure('Position',[100 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2])

axis( [-6 6 0 20  ] )
axis('equal')  
for ii = 1 : size(box)
    p =  correctPoint(box(ii,1),box(ii,2)); 
    p1 = p(1);
    p2 = p(2);
    p3 = box(ii,3)/xDist;
    p4 = box(ii,4)/yDist;
    h = rectangle('Position',[ p1  p2 p3 p4] ,'LineWidth',2);
    set(h,'EdgeColor',char('r'));
end

hold on 

O1s = getO1(a1,a2, [.0092;.0310]);
O2s = getO2(a1,a2, [.0092;.0310]);
Xlinks = [0; O1s(1); O2s(1)];
Ylinks = [0; O1s(2); O2s(2)];
h = plot(Xlinks, Ylinks,'kd-')
%%
set(h,'XData',Xlinks,'YData',Ylinks);
for ii = 1:length(joint1)
    j = [joint1(ii);joint2(ii)]
    O1s = getO1(a1,a2, j);
    O2s = getO2(a1,a2, j);
    Xlinks = [0; O1s(1); O2s(1)]; 
    Ylinks = [0; O1s(2); O2s(2)];
    h.XData = Xlinks;
    h.YData = Ylinks;
    pause(.5)
end



