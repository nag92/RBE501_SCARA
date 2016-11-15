%% Calculates position Jacobian for O2
function J2 = getJ2(q,a1,a2)

theta1=q(1);
theta2=q(2);

% O2 Jacobian

J2 = [-a1*sin(theta1)-a2*sin(theta1+theta2)  -a2*sin(theta1+theta2);
    a1*cos(theta1)+a2*cos(theta1+theta2)    a2*cos(theta1+theta2)];