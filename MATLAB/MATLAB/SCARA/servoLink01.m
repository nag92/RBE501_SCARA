function p = servoLink01(parentAxes, faceColor)
if (nargin == 0)
    parentAxes = gca;
    faceColor = [.1 .3 .2];
elseif (nargin == 1)
    faceColor = [.1 .3 .2];
end
set(parentAxes, 'DataAspectRatio', [1 1 1]);
link0Verts =...
    [ 1       -1.53 5.13;%1
      1       1.54  5.13;%2
      1        .69  6.7;%3
      1       -.74  6.7;%4
     -.96	 -1.53	5.13;%5
     -.96	 -.74 	6.7;%6
     -.96	  .69	6.7;%7
     -.96	  1.54	5.13;];%8
 
AA = zeros(8,3);
%AA(:,1) = 0;

link0Verts = link0Verts; + AA;
link0Faces =...
    [1  2  3  4;
     1  5  6  4;
     4  3  7  6;
     2  3  7  8;
     8  7  6  5];

p = patch('Parent', parentAxes, 'Faces',link0Faces,'Vertices',link0Verts,'FaceColor',faceColor);

end