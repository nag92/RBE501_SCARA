
clear all;
close all;
clc;

cam = webcam(3);
%preview(cam)
pause(1);
img = snapshot(cam);
%img  = img(75:end,150:end-150,:);
img(:,1:150,:) = 0;
img(:,500:end,:) = 0;
img(1:50,:,:) = 0;
figure(1)
imshow(img);
yDist = 31.965;
xDist = 39.75667;

%%
%make it gay
gray = rgb2gray(img);
%figure(2);
%imshow(gray);

%%
%cut out edges
%make it gay
gray = rgb2gray(img);
figure(2);
imshow(gray);

%take out left
altGray = gray;
% [y,x] =  size(altGray)
% for ii = 1 : y 
%     %%find new slope
%     altGray(ii,round(.2128*ii)+450:x) = 0;
%     
% end
% figure(3)
% imshow(altGray);
% 
% for ii = 1 : y 
%     %%find new slope
%     altGray(ii,1:round(-.2128*ii)+175) = 0;
%     
% end
%figure(4)
%imshow(altGray);


%cut out edges
%altGray = gray;
[y,x] =  size(altGray)
%altGray(1:100.,1:end)=0;
%altGray(y-120:end,1:end)=0;
figure(4);
imshow(altGray);
%%
%turn binary and close small holes
threshold = graythresh(gray(find(gray)));
bw = im2bw(altGray, threshold);
bw = bwareaopen(bw,500);
%figure(5);
imshow(bw);
%%
%fill in white holes
filled = imclearborder(imfill(bw, 'holes'));
figure(6);
imshow(filled);
title('filled');
%%
%get centriods)
stats = regionprops(bw,'all');
centroids = cat(1, stats.Centroid);

x = centroids(1)/xDist;
 
y = (480- centroids(2))/ yDist;
 
x2 =  x - 640/(xDist*2);
%y2 =   y - 480/(38.66*2);
 
pos = [ y, x2];
