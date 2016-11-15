clear all
close all
clc
red = load('red2')
blue = load('blue2')
green = load('green2')
scale = 54;
red = red.red.box;
green = green.green.box;
blue = blue.blue.box;
box = [red;green;blue]
% box = [red.box(1,1), red.box(1,1) + red.box(1,3); red.box(1,2), red.box(1,3) + red.box(1,4)]/scale
% box = struct('red',red.box,'green',green.box,'blue',blue.box);
ii = 1;
index = 1;
lines = []
jj = 1;
kk = 2;
while ii < length(box)
    p1 = correctPoint( 0.5*(box(ii,1)+box(ii,3)),0.5*(box(ii,2)+box(ii,4))  );
    p2 = correctPoint( 0.5*(box(ii+1,1)+box(ii+1,3)),0.5*(box(ii+1,2)+box(ii+1,4)));
    lines(index,:)=getLine(p1,p2);
    centers(jj,:) = p1;
    centers(kk,:) = p2;
    jj = kk+1;
    kk = kk+2;
    ii = ii + 2;
    index = index+1;
end

cost = getCost(lines,centers)

[min, I] = min(cost);

start = correctPoint( 0.5*(box(I,1)+box(I,3)),0.5*(box(I,2)+box(I,4))  )
goal = correctPoint( 0.5*(box(I+1,1)+box(I+1,3)),0.5*(box(I+1,2)+box(I+1,4)));
a1 = 5.24; 
a2 = 5.24;
start_ang = inverseKinamatics(start(1), start(2),0)
goal_ang = inverseKinamatics(start(1), goal(2),0)

start_ang(1:2)
%getO2(a1,a2,start_ang(1:2)*(pi/180))

gradientDecent( start_ang(1:2)*(pi/180), goal_ang(1:2)*(pi/180), box) 




