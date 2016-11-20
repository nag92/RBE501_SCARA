function [ z ] = getZ( T )
%GETZ 
%Nathaniel Goldfarb 
%This function takes in a matrix of DH transformations and returns the
%The Z matrix is a 1x3 matrix made up of the first 3 elements of the 3rd
%column.
%for the Jacobian calculation.
%Inputs:
%T: 4x4xn 
%Outputs:
%Z: 3Xn matrix 

%allocate memory and intalize array
n = length(T(1,1,:));
z=zeros(3,n);

%Get all the Zs
for ii=1:n

    z(:,ii) = T(1:3,3,ii);

end

end

