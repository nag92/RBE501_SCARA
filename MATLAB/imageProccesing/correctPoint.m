function [ p ] = correctPoint( x,y )
%{
   CORRECTPOINT, finds the real location of the object from pixels
   ARGUMENTS:
            x: x pixel
            y: y pixel
    RETURN:
            p: real location
%}
yDist = 31.965;
xDist = 39.75667;

newX =   x/xDist - 640/(2*xDist);
newY = (480 - y)/yDist - 5;
p = [newX,newY];
end

