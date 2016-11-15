function p = armLink01(parentAxes, faceColor)
if (nargin == 0)
    parentAxes = gca;
    faceColor = [.1 .5 .5];
elseif (nargin == 1)
    faceColor = [.1 .5 .5];
end
set(parentAxes, 'DataAspectRatio', [1 1 1]);
% link0Verts =...
%     [ 7  -1.8   6.95-6.7;%1
%       7   1.8   6.95-6.7;%2
%       7   1.8   6.7-6.7;%3
%       7  -1.8   6.7-6.7;%4
%       0	 -1.8	6.95-6.7;%5
%       0	 -1.8 	6.7-6.7;%6
%       0	  1.8	6.7-6.7;%7
%       0	  1.8	6.95-6.7;];%8
  
  
  
  link0Verts =...
    [ -5.69      -1.8   .22;%1
      -5.69       1.8   .22;%2
      -5.69       1.8   0;%3
      -5.69      -1.8   0;%4
      -5.69+7	 -1.8	.22;%5
      -5.69+7	 -1.8 	0;%6
      -5.69+7	  1.8	0;%7
      -5.69+7	  1.8	.22;];%8

 
AA = zeros(8,3);
AA(:,1)= 0;

link0Verts = link0Verts;%+ AA
link0Faces =...
    [1  2  3 4;
     1  5  6 4;
     4  3  7 6;
     2  3  7 8;
     8  7  6 5];

p = patch('Parent', parentAxes, 'Faces',link0Faces,'Vertices',link0Verts,'FaceColor',faceColor);

end