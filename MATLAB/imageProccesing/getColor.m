function [ avg_color ] = getColor( image,stats)
%GETCOLOR Summary of this function goes here
%   Detailed explanation goes here
    
    r_channel = image(:,:,1);
    g_channel = image(:,:,2);
    b_channel = image(:,:,3);
    for ii = 1:length(stats)
        avg_color(:,ii) = [ mean(r_channel(stats(ii).FilledImage)),mean(g_channel(stats(ii).FilledImage)),mean(b_channel(stats(ii).FilledImage))]
    end

end

