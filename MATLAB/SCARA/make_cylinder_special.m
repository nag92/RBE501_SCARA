% make_cylinder_special.m

clear; close all;

Radius = 0.1;
Height = 0.3;
SideCount = 20;

% Vertices
n_side = SideCount;

for i_ver=1:n_side
    VertexData(i_ver,:) = [Radius*cos(2*pi/n_side*i_ver),Radius*sin(2*pi/n_side*i_ver),0];
    VertexData(n_side+i_ver,:) = [Radius*cos(2*pi/n_side*i_ver),Radius*sin(2*pi/n_side*i_ver),Height];
end

% Side Patches
for i_pat=1:n_side-1
    Index_Patch1(i_pat,:) = [i_pat,i_pat+1,i_pat+1+n_side,i_pat+n_side];
end
Index_Patch1(n_side,:) = [n_side,1,1+n_side,2*n_side];

for i_pat=1:n_side
    
    % Side patches data
    PatchData1_X(:,i_pat) = VertexData(Index_Patch1(i_pat,:),1);
    PatchData1_Y(:,i_pat) = VertexData(Index_Patch1(i_pat,:),2);
    PatchData1_Z(:,i_pat) = VertexData(Index_Patch1(i_pat,:),3);
end

% Draw side patches
figure(1);
h1 = patch(PatchData1_X,PatchData1_Y,PatchData1_Z,'y');
set(h1,'FaceLighting','phong','EdgeLighting','phong');
set(h1,'EraseMode','normal');

% Bottom Patches
Index_Patch2(1,:) = [1:n_side];
Index_Patch2(2,:) = [n_side+1:2*n_side];

for i_pat=1:2
    
    % Bottom patches data
    PatchData2_X(:,i_pat) = VertexData(Index_Patch2(i_pat,:),1);
    PatchData2_Y(:,i_pat) = VertexData(Index_Patch2(i_pat,:),2);
    PatchData2_Z(:,i_pat) = VertexData(Index_Patch2(i_pat,:),3);
end

% Draw bottom patches
figure(1);
h2 = patch(PatchData2_X,PatchData2_Y,PatchData2_Z,'y');
set(h2,'FaceLighting','phong','EdgeLighting','phong');
set(h2,'EraseMode','normal');

% Axes settings
xlabel('x','FontSize',14);
ylabel('y','FontSize',14);
zlabel('z','FontSize',14);
set(gca,'FontSize',14);
axis vis3d equal;
view([-37.5,30]);
camlight;
grid on;
xlim([-0.2,0.2]);
ylim([-0.2,0.2]);
zlim([-0,0.4]);



