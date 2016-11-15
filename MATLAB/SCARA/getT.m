function [ T ] = getT( A )
%getT 
%Nathaniel Goldfarb 2/4/14;
%Inputs:
%A: a 4x4xn matrix of 'A' matrixes formed by DH parameters. The n is the 'A' matrix for the nth link. 
%Outputs:
% T: a 4x4xn matrix of transfomation matirxs for each nth link

%Get the length of the list
n = length(A(1,1,:));
%allocate memory and set the first trasformation matrix IE link 1
T = ones(4,4,n);
T(:,:,1) = A(:,:,1);
temp=T(:,:,1);
%Get the rest of the transformation matrixes
for ii = 2:n
    T(:,:,ii) = temp*A(:,:,ii);
    %save the last transformation to use in the next interation.
    temp = T(:,:,ii);
end



end

