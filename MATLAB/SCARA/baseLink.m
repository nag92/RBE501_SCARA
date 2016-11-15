function p = baseLink(parentAxes, faceColor)
if (nargin == 0)
    parentAxes = gca;
    faceColor = [.7 .7 .7];
elseif (nargin == 1)
    faceColor = [.7 .7 .7];
end
set(parentAxes, 'DataAspectRatio', [1 1 1]);
link0Verts =...
    [ 1 -2.14 0;%1
      1   4.86 0;%2
      1   4.86 2.13;%3
      1  -2.14 2.13;%4
     -2	 -2.14	0;%5
     -2	 -2.14 	2.13;%6
     -2	  4.86	2.13;%7
     -2	  4.86	0;];%8
 
AA = zeros(8,3);
%AA(:,1) = 0;

link0Verts = link0Verts;% + AA;
link0Faces =...
    [1  2  3  4;
     1  5  6 4;
    4  3  7 6;
    2  3  7 8;
    8 7  6 5];

p = patch('Parent', parentAxes, 'Faces',link0Faces,'Vertices',link0Verts,'FaceColor',faceColor);

end