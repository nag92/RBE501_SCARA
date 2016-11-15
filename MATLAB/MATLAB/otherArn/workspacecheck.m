%This part is just check if beyound joints limitation, 
%further workspace calculation needed
function approve=workspacecheck(theta)
if (theta(1)<-90 || theta(1)>90 || theta(2)<0 || theta(2)>120 || theta(3)<0 || theta(3)>120 || theta(4)<0 || theta(4)>115 || theta(5)<-90 || theta(5)>90 || theta(6)<0 || theta(6)>50)
    approve=0;
else
    approve=1;
end

