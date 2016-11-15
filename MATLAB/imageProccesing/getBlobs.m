function [red_filled,green_filled, blue_filled ] = getBlobs( oringal )
%GETBLOBS Summary of this function goes here
%   Detailed explanation goes here
img = oringal;
img(:,1:150,:) = 0;
img(:,500:end,:) = 0;
img(1:5,:,:) = 0;
figure(2)
imshow(img);


%%
%make it gay
%gray = rgb2gray(img);
red = img(:,:,1);
green = img(:,:,2);
blue = img(:,:,3);


for ii=1:length(img(:,1))
    for jj=1:length(img(:,:,1))
          
        if( blue(ii,jj) < green(ii,jj) + 50 || blue(ii,jj) < red(ii,jj)+50  )
            blue(ii,jj) = 0;
        end
        
        if( green(ii,jj) < blue(ii,jj) + 50 || green(ii,jj) < red(ii,jj)+50  )
            green(ii,jj) = 0;
        end
        
        if( red(ii,jj) < green(ii,jj) + 50 || red(ii,jj) < green(ii,jj)+50  )
            red(ii,jj) = 0;
        end

    end
end



%%
%take out left
blur_red = imgaussfilt(red);
blur_green = imgaussfilt(green);
blur_blue = imgaussfilt(blue);  
figure(3)
imshow(blur_green)
%figure(2)
%imshow(blur_blue);
%%
%turn binary and close small holes
gray = blur_blue(find(blur_blue>50))

thresh_red = graythresh(blur_red(find(blur_red)));
thresh_green = graythresh(blur_green(find(blur_green)));
thresh_blue = graythresh(gray);

bw_red = im2bw(blur_red, thresh_red);
bw_red = bwareaopen(bw_red,300);

bw_green = im2bw(blur_green, thresh_green);
%bw_green = bwareaopen(bw_green,300);

bw_blue = im2bw(blur_blue, thresh_blue);
bw_blue = bwareaopen(bw_blue,300);

figure(5);
imshow(bw_green);
%%
%fill in white holes
red_filled = imclearborder(imfill(bw_red, 'holes'));
green_filled = imclearborder(imfill(bw_green, 'holes'));
blue_filled = imclearborder(imfill(bw_blue, 'holes'));

end

