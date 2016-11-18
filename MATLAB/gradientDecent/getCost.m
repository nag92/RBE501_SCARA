function [cost] = getCost( lines, centers )
%GETCOST Summary of this function goes here
%   Detailed explanation goes here
     lines;
    length(lines(1));
    for ii= 1:length(lines(:,1))
        ii
        line = lines(ii,:);
        cost(ii) = sum(getIntersection(line ,centers));
    end
    
end

