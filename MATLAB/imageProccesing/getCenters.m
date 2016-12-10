function [centers, lines ] = getCenters( box )
%GETCENTERS Summary of this function goes here
%   Detailed explanation goes here
    ii = 1;
    index = 1;
    lines = [];
    jj = 1;
    kk = 2;
    centers = [];
    lines = [];
    

    while ii < length(box(:,1))

        p1 = correctPoint( 0.5*(box(ii,1)+box(ii,3)),0.5*(box(ii,2)+box(ii,4))  );
        p2 = correctPoint( 0.5*(box(ii+1,1)+box(ii+1,3)),0.5*(box(ii+1,2)+box(ii+1,4)));
        
         centers(jj,:) = p1;
        centers(kk,:) = p2;
        lines(index,:)=getLine(p1,p2);
       
        jj = kk+1;
        kk = kk+2;
        ii = ii + 2;
        index = index+1;
        
    end


end

