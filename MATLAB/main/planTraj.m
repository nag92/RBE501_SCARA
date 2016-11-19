function [ traj ] = planTraj(q_i,q_f,  time )
%function 
%MAKEPATH creates a cubpic path of a function 
%   

t = time;


%get the coefs for theta
a_t  = q_i;

c_t = 3*(q_i - q_f)/ (t^2);

d_t = 2*( q_f - q_i)/(t^3);

traj = [ a_t,0,c_t,d_t];



end

