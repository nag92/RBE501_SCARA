function p = armLink02(parentAxes, faceColor)
if (nargin == 0)
    parentAxes = gca;
    faceColor = [.1 .5 .5];
elseif (nargin == 1)
    faceColor = [.1 .5 .5];
end
set(parentAxes, 'DataAspectRatio', [1 1 1]);
% link0Verts =...
%     [ 6.55   -1.8     8.5;%1
%       6.55    1.8    8.5;%2
%       6.55    1.8    8.25;%3
%       6.55   -1.8    8.25;%4
%       13.55	 -1.8	8.5;%5
%       13.55	 -1.8 	8.25;%6
%       13.55	  1.8	8.25;%7
%       13.55	  1.8	8.5;];%8
  
  
  link0Verts =...
    [ -5.69  -1.8  .43-.25;%1
      -5.69    1.8  .43-.25;%2
      -5.69    1.8   .43;%3
      -5.69   -1.8   .43;%4
       -5.69+7      -1.8	 .43-.25;%5
       -5.69+7      -1.8 	 .43;%6
       -5.69+7       1.8	 .43;%7
       -5.69+7      1.8  .43-.25;];%8
 
AA = zeros(8,3);
AA(:,1) = 0;

link0Verts = link0Verts;% + AA;
link0Faces =...
    [1  2  3  4;
     1  5  6 4;
    4  3  7 6;
    2  3  7 8;
    8 7  6 5];

p = patch('Parent', parentAxes, 'Faces',link0Faces,'Vertices',link0Verts,'FaceColor',faceColor);

end