function [pos] = cameraOLD( port )
%%
%get an image

cam = webcam(3);
preview(cam)
%pause(1);
img = snapshot(cam);
%figure(1)
%imshow(img);
%h = imdistline;

%%
%make it gay
gray = rgb2gray(img);
figure(2);
imshow(gray);

%take out left
altGray = gray;
[y,x] =  size(altGray)
for ii = 1 : y 
    %%find new slope
    altGray(ii,round(.2128*ii)+490:x) = 0;
    
end
figure(3)
imshow(altGray);

for ii = 1 : y 
    %%find new slope
    altGray(ii,1:round(-.2128*ii)+175) = 0;
    
end
%figure(4)
%imshow(altGray);


%cut out edges
%altGray = gray;
[y,x] =  size(altGray)
altGray(1:100.,1:end)=0;
altGray(420:480.,1:end)=0;

%altGray(y-120:end,1:end)=0;
figure(4);
imshow(altGray);
%%
%turn binary and close small holes
threshold = graythresh(gray);
bw = im2bw(altGray, threshold);
bw = bwareaopen(bw,500);
figure(5);
imshow(bw);
%%
%fill in white holes
filled = imfill(bw, 'holes');
figure(6);
imshow(filled);
title('filled');
%%
%get centriods)
stats = regionprops(bw,'all');
centroids = cat(1, stats.Centroid)

x = centroids(1)/43
 31.965
y =(480- centroids(2))/ 58
 
x2 =  x - 640/(39.4633*2)
y2 =   y - 480/( 31.965*2)  
 
pos = [ y, x2];
end

