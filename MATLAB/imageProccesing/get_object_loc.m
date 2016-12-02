function [ red_obj, green_obj, blue_obj ] = get_object_loc( image )
%{  
   GET_OBJECT_LOC, find the location of the objects in an image
    This function takes in an image and out puts data structs for each
    object. 
%}    
    % stuff for testing
    %get an image
    %cam = webcam(port);
    %image= snapshot(cam);
    img = load('objects2.mat');
    image = img.image;
    imshow(image)
    
    %Find objects and get the stats
    [red_blobs, green_blobs,blue_blobs]  = getBlobs(image);
    blobs = red_blobs | green_blobs | blue_blobs;
    se = strel('disk',5);
    blobs = imerode(blobs,se);
    %imshow(blobs)
    % mark the images
    red_stats = regionprops(red_blobs,'all');
    green_stats = regionprops(green_blobs,'all');
    blue_stats = regionprops(blue_blobs,'all');
    stats = regionprops(blobs,'all');
    %get the color,shape,location of the objects
    [red_centroids , red_box, red_shape, red_c] = blobAnyalsiser(red_stats);
    [green_centroids , green_box, green_shape, green_c] = blobAnyalsiser(green_stats);
    [blue_centroids , blue_box, blue_shape, blue_c] = blobAnyalsiser(blue_stats);
    [centroids , box, shape, c] = blobAnyalsiser(stats);
   
    %info= [ shape, color]
    
    
    hold on;
    plot(centroids(:,1), centroids(:,2), 'b*');
    for ii = 1 : size(box)
        h = rectangle('Position',[ box(ii,1) box(ii,2) box(ii,3) box(ii,4)] ,'LineWidth',2);
        set(h,'EdgeColor',char(c(ii)));

    end
%     text(0,0,txt,...b
%         'HorizontalAlignment','left',...
%         'VerticalAlignment','top',...
%         'BackgroundColor','black',...
%         'fontsize',16);
    
    red_obj = [red_centroids, red_shape ];
    blue_obj = [blue_centroids, blue_shape ];
    green_obj = [green_centroids, green_shape ];
    
end

