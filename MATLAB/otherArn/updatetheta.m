%similar with ME598 Midterm project inverse kenematic part
function theta = updatetheta(theta,x,y,z)
%DH
a=[0,0,0,0,0,0,0];
af=[pi/2,-pi/2,pi/2,-pi/2,pi/2,-pi/2,0];
d=[2.9375,0,3.625,0,3.0625,0,5.5];
ctt=theta/180*pi;
ct=[ctt(1) ctt(2) 0 ctt(3) 0 ctt(4) ctt(5)];
gripper=theta(6);
%A1-A7
for m=1:7;
    A(:,:,m)=[cos(ct(m)) -sin(ct(m))*cos(af(m))  sin(ct(m))*sin(af(m)) a(m)*cos(ct(m));
              sin(ct(m))  cos(ct(m))*cos(af(m)) -cos(ct(m))*sin(af(m)) a(m)*sin(ct(m));
                       0             sin(af(m))             cos(af(m))            d(m);
                       0                      0                      0               1];
end
%H07
H=A(:,:,1)*A(:,:,2)*A(:,:,3)*A(:,:,4)*A(:,:,5)*A(:,:,6)*A(:,:,7);
%%
%movement
O=[x,y,z];%input
OO=[0 0 0 O(1);
    0 0 0 O(2);
    0 0 0 O(3);
    0 0 0 0];
H=H+OO;
%%
%cal new ct1-ct7
%ct1,ct2,ct4
%O
ox=H(1,4);
oy=H(2,4);
oz=H(3,4);
%Oc
d6=d(7);
xc=(ox-d6*H(1,3));
yc=(oy-d6*H(2,3));
zc=(oz-d6*H(3,3));
%D
d1=d(1);
a2=d(3);
a3=d(5);
D=(xc^2+yc^2+(zc-d1)^2-a2^2-a3^2)/(2*a2*a3);
%ct124
ct1=atan2(-yc,-xc);
ct4=atan2((1-D^2)^0.5,D);%when ct4>0
ct2=pi/2-(atan2(zc-d1,(xc^2+yc^2)^0.5)+atan2(a3*sin(ct4),a2+a3*cos(ct4)));%whenct2>0
%%
%ct6,ct7
ct=[ct1 ct2 0 ct4 0];
for m=1:5;
    A(:,:,m)=[cos(ct(m)) -sin(ct(m))*cos(af(m))  sin(ct(m))*sin(af(m)) a(m)*cos(ct(m));
              sin(ct(m))  cos(ct(m))*cos(af(m)) -cos(ct(m))*sin(af(m)) a(m)*sin(ct(m));
                       0             sin(af(m))             cos(af(m))            d(m);
                       0                      0                      0               1];
end
H07=H;
R07=H07(1:3,1:3);
H05=A(:,:,1)*A(:,:,2)*A(:,:,3)*A(:,:,4)*A(:,:,5);
R05=H05(1:3,1:3);
R57=(R05)^(-1)*R07;
ct6=atan2(-R57(1,3),R57(2,3));
ct7=atan2(-R57(3,1),-R57(3,2));
%%
ct=[ct1,ct2,ct4,ct6,ct7,0];
theta=ct/pi*180;
theta(6)=gripper;
end
