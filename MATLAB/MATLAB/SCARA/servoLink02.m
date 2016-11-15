function p = servoLink02(parentAxes, faceColor)
if (nargin == 0)
    parentAxes = gca;
    faceColor = [.1 .3 .2];
elseif (nargin == 1)
    faceColor = [.1 .3 .2];
end
set(parentAxes, 'DataAspectRatio', [1 1 1]);
% link0Verts =...
%     [ 7  -1.53  6.95;%1
%       7   1.54  6.95;%2
%       7   .69   8.25;%3
%       7   -.74  8.25;%4
%      5.09 -1.53	6.95;%5
%      5.09 -.74 	8.25;%6
%      5.09  .69	8.25;%7
%      5.09  1.54	6.95;];%8
 
 
 link0Verts =...
    [ 1      -1.53   .25;%1
      1      1.54   .25%2
      1        .69   2.25;%3
      1       -.74   2.25;%4
     -.96    -1.53   .25;%5
     -.96     -.74   2.25;%6
     -.96      .69	 2.25;%7
     -.96     1.54   2.25;];%8
 
AA = zeros(8,3);
AA(:,1) = 0;

link0Verts = link0Verts; + AA;
link0Faces =...
    [1  2  3  4;
     1  5  6 4;
    4  3  7 6;
    2  3  7 8;
    8 7  6 5];

p = patch('Parent', parentAxes, 'Faces',link0Faces,'Vertices',link0Verts,'FaceColor',faceColor);

end