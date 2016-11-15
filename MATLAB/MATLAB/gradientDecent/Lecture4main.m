%%   Gradient Descent Algorithm for 2-Link Planar Arm
clear all
close all

% Starting joint coordinate configuration
q_s = [pi/4 ; 0];

% Final (goal) joint coordinate configuration
q_f = [pi/2; pi/2];

% Obstacle Coordinates
a = [1; 4]; 
b = [3; 4];    
c = [3, 6];
d = [1, 6];  

Xobs = [3;2];
Yobs = [0;5];

% Plot Obstacles, and Manipulator Initial and Starting Configurations
XobsPlot = [a(1); b(1); c(1); d(1); a(1)];
YobsPlot = [a(2); b(2); c(2); d(2); a(2)];
scrsz = get(0,'ScreenSize');
%figure('Position',[100 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2])
figure('Position',[100 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2])
plot(XobsPlot, YobsPlot, 'r')
%axis([-1.25 3 -0.5 2.5])
hold on

% Link lengths
a1 = 3;
a2 = 3;


% Plot Manipulator Starting Configuration
O1s = getO1(a1,a2,q_s);
O2s = getO2(a1,a2,q_s);
Xlinks = [0 ;O1s(1); O2s(1)];
Ylinks = [0 ;O1s(2); O2s(2)];
plot(Xlinks, Ylinks,'kd-')

% Plot Manipulator Final (Goal) Configuration
O1f = getO1(a1,a2,q_f);
O2f = getO2(a1,a2,q_f);
Xlinks = [0 ;O1f(1); O2f(1)];
Ylinks = [0 ;O1f(2); O2f(2)];
plot(Xlinks, Ylinks,'kd-')

% Attractive and Repulsive Field Parameters
eta1 = .1;               % controls the relative influence of the repulsive potential for O1
eta2 = 10;               % controls the relative influence of the repulsive potential for O2
zeta1 = 1;              % controls the relative influence of the attractive potential for O1
zeta2 = 1;              % controls the relative influence of the attractive potential for O2
d = 5;                 % distance that defines the transition from conic to parabolic attractive wells
rho_o = 10;              % distance of influence for obstacles
epsilon = 0.1;         % convergence tolerance

q_storage = [q_s];      % Initialize matrix of via points

q = q_s;
M = magnitude2(q,q_f);
i = 0;
% Gradient Descent Algorithm from p.179
    while M > epsilon
        
        if( M < .15)
            alpha = .1;
        else
            alpha = 0.25;         % step size (0.1)
        end
        alpha
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
        M = magnitude2(q,q_f)               % update M for next iteration
        
        Xlinks = [0 ;O1(1); O2(1)];            
        Ylinks = [0 ;O1(2); O2(2)];
        plot(Xlinks, Ylinks,'bd-')             % Plot link geometry at q
%       pause
%       i=i+1;
        pause(0.5)
        i=i+1;
%          MovieFrames(i)=getframe;
    end
    
%    movie(MovieFrames)
%    movie2avi(MovieFrames, '2LinkRobotPath.avi')
    