%Nathaniel Goldfarb
%2/16/2015
%This function checks if the points are vaild for the arm
%if it is it returns it reurns true
function [ valid ] = check( x,y,z )
%
if( x>12.48 ||  x < -12.48)
    valid = 0;
    return;
end

if( y>12.48 ||  y < -12.48)
    valid = 0;
    return;
end


end

