function [ r ] = getIntersection( line, p )
%GETINTERSECTION Summary of this function goes here
%   Detailed explanation goes here
  r =  abs( line(1)*p(1) +  line(2)*p(2)+ line(3))/ sqrt( line(1)^2 + line(3)^2);  
end

