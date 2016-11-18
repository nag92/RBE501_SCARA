clear all;
close all;
clc;
% get the objects in the image

%[ red_obj, green_obj, blue_obj ] = get_object_loc( port );

%%
% temperoray until the camera is added. 
red = load('red2')
blue = load('blue2')
green = load('green2')
red = red.red.box;
green = green.green.box;
blue = blue.blue.box;
%%

box = [red;green;blue];
remove_box = box;
% the object to grab
index = 1;
for ii =1:3
    remove_box
    % Get the location of the objects
    [centers, lines] = getCenters(remove_box);
    % this function find the path that will cross over the 
    cost = getCost(lines,centers);
    % get the shorest path
    
    [minVal, I] = min(cost)
    
    % the object location in the image
    if I == 1
        index = 1;
    elseif I == 2
        index = 3;
    else
        index = 5;
    end
    
    
    % get the start goal position
    start = correctPoint((remove_box(index,1)+0.5*remove_box(index,3)),(remove_box(index,2)-0.5*remove_box(index,4)));
    goal = correctPoint((remove_box(index+1,1)+.5*remove_box(index+1,3)),(remove_box(index+1,2)-.5*remove_box(index+1,4)));
    remove_box(index:index+1,:) =[];
    
    % get the start, goal angles
    start_ang = inverseKinamatics(start(1), start(2),0);
    goal_ang = inverseKinamatics(goal(1), goal(2),0);
    
    % get the joint angles
    q =  gradientDecent( start_ang(1:2)*(pi/180), goal_ang(1:2)*(pi/180), box);
    % smooth the joint angles
    t = linspace(0,length(q(1,:)),length(q(1,:)));
    p = polyfit(t,q(1,:),3);
    q_filtered = polyval(p,t)
    
    
end


