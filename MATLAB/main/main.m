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
index = 1
for ii =1:3
    
    % Get the location of the objects
    centers = getCenters(remove_box);
    % this function find the path that will cross over the 
    cost = getCost(lines,centers)
    % get the shorest path
    [min, I] = min(cost);
    
    % the object location in the image
    if I == 1
        index = 1
    elseif I == 2
        index = 3
    else
        index = 5
    end
    
    % get the start goal position
    start = correctPoint((box(index,1)+0.5*box(index,3)),(box(index,2)-0.5*box(index,4)))
    goal = correctPoint((box(index+1,1)+.5*box(index+1,3)),(box(index+1,2)-.5*box(index+1,4)))
    box(index:index+1,:) =[];
    
    % get the start, goal angles
    start_ang = inverseKinamatics(start(1), start(2),0);
    goal_ang = inverseKinamatics(goal(1), goal(2),0);
    
    
end


