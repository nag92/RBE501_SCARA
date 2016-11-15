function [ p ] = correctPoint( x,y )
%CORRECTPOINT Summary of this function goes here
%   Detailed explanation goes here
yDist = 31.965;
xDist = 39.75667;

newX =   x/xDist - 640/(2*xDist);
newY = (480 - y)/yDist;
p = [newX,newY];
end

