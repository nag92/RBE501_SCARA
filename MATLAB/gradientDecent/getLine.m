function [ line ] = getLine( p1,p2 )
%GETRADIUS Summary of this function goes here
%   Detailed explanation goes here

m = (p2(2) - p1(2))/(p2(1) - p1(1));
b = p1(2) - m*p1(1);

A = -m/b;
B = 1/b;
C = -1;
line = [A,B,C];
end

