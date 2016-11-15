%% Calculates Repulsive Force Field of Obstacle to point O
function F_rep = getF_rep(O,Xobs,Yobs,eta,rho_o)

% Calculate rho's
h = length(Xobs);
for i = 1:1:h
    distance_vector = [Xobs(i); Yobs(i)] - O;
    rho(i) = sqrt(distance_vector(1)^2 + distance_vector(2)^2);    
end

% Locate coordinates for vertex with minimum rho
rho_min = min(rho);
for i=1:1:h
    if rho(i) == rho_min
     ObsX = Xobs(i);
     ObsY = Yobs(i);
    end
end

% Set rho to the minimum value found
rho = rho_min;

% if point is outside obstacle's influence, F_rep = 0
if rho > rho_o
    F_rep = [0; 0];
end

% if point is inside obstacle's influence, cacluate F_rep 
if rho <= rho_o
    vector = O - [ObsX; ObsY];
    vector_length = sqrt(vector(1)^2 + vector(2)^2);
    grad_rho = vector*(1/vector_length);
    F_rep = eta*( (1/rho) - (1/rho_o) )*(1/rho^2)*grad_rho;
end
