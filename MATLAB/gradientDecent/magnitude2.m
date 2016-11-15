%% Calculates magnitude of vector (q1 - q2)
function M = magnitude2(q1,q2)

v = q1-q2;
M = sqrt(v(1)^2 + v(2)^2);