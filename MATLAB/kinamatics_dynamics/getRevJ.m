function [ j] = getRevJ( z,on,o )
%Nathaniel Goldfarb 
%getRevJ returns the Jacobian of a revolute joint
%inputs:
%z: 1X3 matrix
%on: last joint 'o' 1x3 matrix
%o: current 'o' joint 1x3 matrix

a= cross(z,(on-o));
j= [a;z];


end

