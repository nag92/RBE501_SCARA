function [ output_args ] = gradientDecent(  red )
%GRADIENTDECENT Summary of this function goes here
%   Detailed explanation goes here
qs= [ 0;0];
qf = [pi/2;pi/2];
% Obstacle Coordinates
a = [2.25; 1.5]; 
b = [2; 0.5];    
c = [2.5, 1.0];  
box = [red.box(1,1), red.box(1,1) + red.box(1,3); red.box(1,2), red.box(1,3) + red.box(1,4)]/scale

Xobs = box(1,:);
Yobs = box(2,:);

% Plot Obstacles, and Manipulator Initial and Starting Configurations
% XobsPlot = [a(1); b(1); c(1); a(1)];
% YobsPlot = [a(2); b(2); c(2); a(2)];

XobsPlot = [a(1); b(1); c(1); a(1)];
YobsPlot = [a(2); b(2); c(2); a(2)];

 h = rectangle('Position',[ red.box(1,1) red.box(1,2) red.box(1,3) red.box(1,4)] ,'LineWidth',2);
 set(h,'EdgeColor',char(c(ii)));

scrsz = get(0,'ScreenSize');
%figure('Position',[100 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2])
figure('Position',[100 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2])
%plot(XobsPlot, YobsPlot, 'r')
axis([-1.25 3 -0.5 2.5])
hold on

% Link lengths
a1 = 1;
a2 = 1;


% Plot Manipulator Starting Configuration
O1s = getO1(a1,a2,q_s);
O2s = getO2(a1,a2,q_s);
Xlinks = [0 ;O1s(1); O2s(1)];
Ylinks = [0 ;O1s(2); O2s(2)];
plot(Xlinks, Ylinks,'kd-')

hold on;
plot(centroids(:,1), centroids(:,2), 'b*');
for ii = 1 : size(box)
    h = rectangle('Position',[ box(ii,1) box(ii,2) box(ii,3) box(ii,4)] ,'LineWidth',2);
    set(h,'EdgeColor',char(c(ii)));
end

% Plot Manipulator Final (Goal) Configuration
O1f = getO1(a1,a2,q_f);
O2f = getO2(a1,a2,q_f);
Xlinks = [0 ;O1f(1); O2f(1)];
Ylinks = [0 ;O1f(2); O2f(2)];
plot(Xlinks, Ylinks,'kd-')

% Attractive and Repulsive Field Parameters
eta1 = 1;               % controls the relative influence of the repulsive potential for O1
eta2 = 1;               % controls the relative influence of the repulsive potential for O2
zeta1 = 1;              % controls the relative influence of the attractive potential for O1
zeta2 = 1;              % controls the relative influence of the attractive potential for O2
d = 10;                 % distance that defines the transition from conic to parabolic attractive wells
rho_o = 1;              % distance of influence for obstacles
epsilon = 0.01;         % convergence tolerance

q_storage = [q_s];      % Initialize matrix of via points

q = q_s;
M = magnitude2(q,q_f);
i = 0;
% Gradient Descent Algorithm from p.179
    while M > epsilon
        
        alpha = 0.1;         % step size (0.1)
        O1 = getO1(a1,a2,q); % O1(q)
        O2 = getO2(a1,a2,q); % O2(q)
        F_att_1 = getF_att(O1,O1f,d,zeta1); % From eq. 5.4
        F_att_2 = getF_att(O2,O2f,d,zeta2); % From eq. 5.4
        F_rep_1 = getF_rep(O1,Xobs,Yobs,eta1,rho_o); % From eq. 5.6
        F_rep_2 = getF_rep(O2,Xobs,Yobs,eta2,rho_o); % From eq. 5.6
        J1 = getJ1(q,a1,a2); % Jacobian for O1 evaluated at q
        J2 = getJ2(q,a1,a2); % Jacobian for O2 evaluated at q
        tau = J1'*F_att_1 + J2'*F_att_2 + J1'*F_rep_1 + J2'*F_rep_2;  % From eq. 5.8
        
        q_new = q + alpha*tau/magnitude(tau);   % Calculate new q
        q_storage = [q_storage q_new];          % Add q to q_storage array
        q = q_new;                              % update q for next iteration
        M = magnitude2(q,q_f);                  % update M for next iteration
        
        Xlinks = [0 ;O1(1); O2(1)];            
        Ylinks = [0 ;O1(2); O2(2)];
        plot(Xlinks, Ylinks,'bd-')             % Plot link geometry at q
%       pause
%       i=i+1;
        pause(0.5)
        i=i+1
%          MovieFrames(i)=getframe;
    end

end

