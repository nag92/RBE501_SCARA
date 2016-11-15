   clc; clear all; close all;

% Read standard MATLAB demo image.
cam = webcam(3);
image= snapshot(cam);
rgbImage = image;
size(image)
% Display the original image.
subplot(1, 3, 1);
imshow(rgbImage);
title('Original RGB Image');
% Maximize figure.
set(gcf, 'Position', get(0, 'ScreenSize'));

% Split into color bands.
redBand = rgbImage(:,:, 1);
greenBand = rgbImage(:,:, 2);
blueBand = rgbImage(:,:, 3);

% Display them.
subplot(1, 3, 2);
imshow(blueBand);
title('Blue Band');

% here objects which are parly blue make totaly blue
for i=1:480
    for j=1:640
        if blueBand(i,j)>200
            redBand(i,j)=0.1;
            greenBand(i,j)=0.1;
            blueBand(i,j)=200;
        end
    end
end

% here objects which are not blue to dark
for i=1:480
    for j=1:640
        if blueBand(i,j)<200
            redBand(i,j)=redBand(i,j)*0.2;
            greenBand(i,j)=greenBand(i,j)*0.2;
            blueBand(i,j)=blueBand(i,j)*0.2;
        end
    end
end

% Display them.
subplot(1, 3, 3);
im = cat(3,redBand,greenBand,blueBand);
imshow(im);
title('Blue Objects');
