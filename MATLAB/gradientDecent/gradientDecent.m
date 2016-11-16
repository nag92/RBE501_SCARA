function [ q_storage ] = gradientDecent( q_s, q_f, box )
%GRADIENTDECENT Summary of this function goes here
%   Detailed explanation goes here
% Link lengths
a1 = 5.24;
a2 = a1+2;
%q_s= [ 0;0];
%q_f = [pi/2;pi/2];
q_s = [q_s(1);q_s(2)]
q_f = [q_f(1);q_f(2)];
% Obstacle Coordinates
yDist = 31.965;
xDist = 39.75667;   
p = correctPoint(0.5*(box(:,1)+box(:,3)),0.5*(box(:,3)+box(:,4))) ;
xList(:,1) =  (0.5*(box(:,1)+box(:,3)))/xDist  - 640/(2*xDist);
yList(:,1) =  (480 - ( 0.5*(box(:,2)+box(:,4))))/yDist ;
% 
% Xobs = box(1,:);
% Yobs = box(2,:);

Xobs = [  p(1) ]
Yobs = [  p(2)]
% Plot Obstacles, and Manipulator Initial and Starting Configurations
% XobsPlot = [a(1); b(1); c(1); a(1)];
% YobsPlot = [a(2); b(2); c(2); a(2)];


scrsz = get(0,'ScreenSize');
%figure('Position',[100 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2])
figure('Position',[100 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2])
size(box)
%axis( [-6 6 0 20  ] )
axis('equal')  
for ii = 1 : size(box)
        p =  correctPoint(box(ii,1),box(ii,2)); 
        p1 = p(1);
        p2 = p(2);
        p3 = box(ii,3)/xDist;
        p4 = box(ii,4)/yDist;
        h = rectangle('Position',[ p1  p2 p3 p4] ,'LineWidth',2);
        set(h,'EdgeColor',char('r'));
    end

hold on 


%plot(XobsPlot, YobsPlot, 'r')



% Plot Manipulator Starting Configuration
O1s = getO1(a1,a2,q_s);
O2s = getO2(a1,a2,q_s)
Xlinks = [0; O1s(1); O2s(1)];
Ylinks = [0; O1s(2); O2s(2)];
plot(Xlinks, Ylinks,'kd-')



% Plot Manipulator Final (Goal) Configuration
O1f = getO1(a1,a2,q_f);
O2f = getO2(a1,a2,q_f)
Xlinks = [0 ;O1f(1); O2f(1)];
Ylinks = [0 ;O1f(2); O2f(2)];
plot(Xlinks, Ylinks,'kd-')

% % Attractive and Repulsive Field Parameters
eta1 = 0;               % controls the relative influence of the repulsive potential for O1
eta2 = 0;               % controls the relative influence of the repulsive potential for O2
zeta1 = 10;              % controls the relative influence of the attractive potential for O1
zeta2 = 20;              % controls the relative influence of the attractive potential for O2
d = 50;                 % distance that defines the transition from conic to parabolic attractive wells
rho_o = .1;              % distance of influence for obstacles
epsilon = 0.05;         % convergence tolerance

q = q_s;
q_storage = [q];      % Initialize matrix of via points


M = magnitude2(q,q_f);
i = 0;
% Gradient Descent Algorithm from p.179
    while M > epsilon
        
        if( M < .15)
            alpha = .1;
        else
            alpha = 0.25;         % step size (0.1)
        end
        alpha;
        O1 = getO1(a1,a2,q); % O1(q)
        O2 = getO2(a1,a2,q); % O2(q)
        F_att_1 = getF_att(O1,O1f,d,zeta1); % From eq. 5.4
        F_att_2 = getF_att(O2,O2f,d,zeta2); % From eq. 5.4
        F_rep_1 = getF_rep(O1,Xobs,Yobs,eta1,rho_o); % From eq. 5.6
        F_rep_2 = getF_rep(O2,Xobs,Yobs,eta2,rho_o); % From eq. 5.6
        J1 = getJ1(q,a1,a2); % Jacobian for O1 evaluated at q
        J2 = getJ2(q,a1,a2); % Jacobian for O2 evaluated at q
        tau = J1'*F_att_1 + J2'*F_att_2 + J1'*F_rep_1 + J2'*F_rep_2;  % From eq. 5.8
        
        q_new = q - alpha*tau/magnitude(tau);   % Calculate new q
        q_storage = [q_storage q_new];          % Add q to q_storage array
        q = q_new;                              % update q for next iteration
        M = magnitude2(q,q_f)             % update M for next iteration
        
        Xlinks = [0 ;O1(1); O2(1)];            
        Ylinks = [0 ;O1(2); O2(2)];
        plot(Xlinks, Ylinks,'bd-')             % Plot link geometry at q
%       pause
%       i=i+1;
        pause(2)
        i=i+1;
%          MovieFrames(i)=getframe;

end

