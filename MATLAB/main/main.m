clear all;
close all;
clc;
% get the objects in the image

[ red_obj, green_obj, blue_obj ] = get_object_loc( 3 );

%%
% temperoray until the camera is added. 
red = load('red2')
blue = load('blue2')
green = load('green2')
red = red.red.box;
green = green.green.box;
blue = blue.blue.box;
fig = 4;
%%

box = [red;green;blue];
remove_box = box;
% the object to grab
index = 1;
for ii =1:3
    
    
    % Get the location of the objects
    [centers, lines] = getCenters(remove_box);
    % this function find the path that will cross over the 
    cost = getCost(lines,centers);
    % get the shorest path
    
    [minVal, I] = min(cost);
    
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
    pq1  = polyfit(t,q(1,:),3);
    pq2  = polyfit(t,q(2,:),3);
    temp1 = polyval(pq1,t)
    temp2 = polyval(pq2,t)
    q_filtered{ii,1} = temp1;
    q_filtered{ii,2} = temp2

    %%
     fig = fig +1;
    figure(fig);
    hold on
    plot(t,q(1,:))
    plot(t,q(2,:));
    plot(t,temp1);
    plot(t,temp2);
    title([ 'path ' num2str(fig -3)])
    ylabel('theta (rad)');
    xlabel('time (s)')
    legend('theta1 raw','theta2 raw','theta1 smoothed','theta2 smoothed' );
   
    %%
    
end

time = 5;


poly_s1 = [planTraj(0,q_filtered{1,1}(1),time);planTraj(0,q_filtered{1,2}(1),time)];

poly_12 = [planTraj( q_filtered{1,1}(end),q_filtered{2,1}(1),time);...
           planTraj(q_filtered{1,2}(end),q_filtered{2,2}(1),time)];

poly_23 = [planTraj(q_filtered{2,1}(end),q_filtered{3,1}(1),time);...
           planTraj(q_filtered{2,2}(end),q_filtered{3,1}(1),time)];

q_s1 = [ polyval(fliplr(poly_s1(1,:)),0:time );polyval(fliplr(poly_s1(2,:)),0:time )];
q_12 = [ polyval(fliplr(poly_12(1,:)),0:time );polyval(fliplr(poly_12(2,:)),0:time )];
q_23 = [ polyval(fliplr(poly_23(1,:)),0:time );polyval(fliplr(poly_23(2,:)),0:time )];


totalPath = {q_s1(1,:),q_s1(2,:);q_filtered{1,1},q_filtered{1,2};...
             q_12(1,:),q_12(2,:);q_filtered{2,1},q_filtered{2,2};...
             q_23(1,:),q_23(2,:);q_filtered{3,1},q_filtered{3,2} }

         
         
         
save('totalPath','totalPath')
