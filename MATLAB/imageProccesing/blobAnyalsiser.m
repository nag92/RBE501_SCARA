function [ centroids , box,shape,color ] = blobAnyalsiser( stats )
    %{
        BLOBANYALSISER 
        5/23/14

        This fuction anyalize and gathers information about an image based on the
        blobs decteced in it

        ARGUMENTS:
            bw = binary image to be anyanlized
        RETURN:
            centroids = centroid of the blob
            box = bounding box for a blob
    %}

    %lable the image;
   
    % Calculate region properties for connected components
    
    box = cat(1,stats.BoundingBox);
    centroids = cat(1, stats.Centroid);
    eccentricities = cat(1,stats.Eccentricity);
    filledArea = [stats.FilledArea];
    perimeters = [stats.Perimeter];
  
    %Determine the "circularity" of a object
    %Measure of how closely the shape of an object approaches that of a circle.
    
    circularities = ((perimeters.^2)./ (4*pi*filledArea) ) 
    
    shape = 0;
    color = 0;
    
    for ii = 1: length(circularities );
        
        %shape is a circle = blue
        if circularities(ii) <= 1.1
                tempShape = 1;
                c = 'r'
                
        %shape is square/rectangle = red
        elseif circularities(ii) <=  2
                tempShape = 2;
                c = 'b'
                
        %shape is a triangle = green
        elseif circularities(ii) >  2 && circularities(ii) <  2.5
                tempShape = 3;
                c = 'm'
                
        %shape is undefind = magenta
        else  
                tempShape = 4;
                c = 'g'
        end
                
        shape = [shape ; tempShape];
        color(ii) = c;      
    end
    
    shape(1,:)=[];
    %display some information
    %display(eccentricities);
    %display(centroids);
    %display(length(circularities ));
    display(shape); 
    %display(circularities);
    
end

