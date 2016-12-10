function [cost] = getCost( lines, centers )
%{
    GETCOST find the cost to travel between the objects
    the cost is defined by the sum of the distance from the object centers 
    to the travel line
%}
    for ii= 1:length(lines(:,1))
        line = lines(ii,:);
        cost(ii) = sum(getIntersection(line ,centers));
    end
    
end

