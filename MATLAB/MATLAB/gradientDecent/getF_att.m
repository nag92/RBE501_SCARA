%% Calculates Attractive Force Field of Goal location to point O
function F_att = getF_att(O,Of,d,zeta)

vector = O - Of;
v = sqrt(vector(1)^2 + vector(2)^2);

if v <= d
    F_att = -zeta*(O-Of);
end

if v > d
    F_att = -d*zeta*(O-Of)/v;
end

    
    