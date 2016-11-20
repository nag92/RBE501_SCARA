function [ o,on ] = getO( T )
%getO
%Nathaniel Goldfarb 
%This function takes in a matrix of DH transformations and returns the
%The o matrix is a 1x3 matrix made up of the first 3 elements of the 4th
%column.
%for the Jacobian calculation.
%Inputs:
%T: 4x4xn 
%Outputs:
%O: 3Xn matrix 

%allocate memory and intalize array
n = length(T(1,1,:));
o=zeros(3,n);
o(:,1)=[0;0;0];

%Get all the Zs
for ii=1:n

    o(:,ii+1) = T(1:3,4,ii);
    
end

on = T(1:3,4,end);

end