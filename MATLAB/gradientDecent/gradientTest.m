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
I
start = correctPoint( (box(1,1)+0.5*box(1,3)),(box(1,2)-0.5*box(1,4))  )
goal = correctPoint( (box(2,1)+.5*box(2,3)),(box(2,2)-.5*box(2,4)))
a1 = 5.24; 
a2 = a1+2;
start_ang = inverseKinamatics(start(1), start(2),0);
goal_ang = inverseKinamatics(goal(1), goal(2),0);
box(3:4,:) = [];
box
% %start_ang(1:2);
getO2(a1,a2,goal_ang(1:2)*(pi/180))
% 
q =  gradientDecent( start_ang(1:2)*(pi/180), goal_ang(1:2)*(pi/180), box)
q(1,:)

%q_filtered  = filter(coeff24hMA, 1, q(1,:));

figure(2)
hold on
plot(q(1,:))
%plot(q_filtered)
t = linspace(0,length(q(1,:)),length(q(1,:)))
p = polyfit(t,q(1,:),3)
q_filtered = polyval(p,t)
plot(t,q_filtered)



