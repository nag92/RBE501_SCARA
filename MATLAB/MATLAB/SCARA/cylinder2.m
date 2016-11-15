function p = cylinder(parentAxes, faceColor)
if (nargin == 0)
    parentAxes = gca;
    faceColor = [.13 .54 .8];
elseif (nargin == 1)
    faceColor = [.15 .32 .9];
end
set(parentAxes, 'DataAspectRatio', [1 1 1]);

Radius = 0.866142/2;
height = 1.55;
SideCount = 1000;

% Vertices
n_side = SideCount;

for i_ver=1:n_side
    link0Verts(i_ver,:) = [Radius*cos(2*pi/n_side*i_ver),Radius*sin(2*pi/n_side*i_ver),0];
    link0Verts(n_side+i_ver,:) = [Radius*cos(2*pi/n_side*i_ver),Radius*sin(2*pi/n_side*i_ver),height];
end

% Side Patches
for i_pat=1:n_side-1
link0Faces(i_pat,:) = [i_pat,i_pat+1,i_pat+1+n_side,i_pat+n_side];
end
link0Faces(n_side,:) = [n_side,1,1+n_side,2*n_side];

% for i_pat=1:n_side
%     
%     % Side patches data
%     PatchData1_X(:,i_pat) = VertexData(Index_Patch1(i_pat,:),1);
%     PatchData1_Y(:,i_pat) = VertexData(Index_Patch1(i_pat,:),2);
%     PatchData1_Z(:,i_pat) = VertexData(Index_Patch1(i_pat,:),3);
% end

p = patch('Parent', parentAxes, 'Faces',link0Faces,'Vertices',link0Verts,'FaceColor',faceColor);