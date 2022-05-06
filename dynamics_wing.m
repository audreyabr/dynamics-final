function dynamics_wing
clear all
close all

% Define system parameters
alphadot = 100; % rad/sec

L1 = 4;              % length of the first rod in m
L2 = 10;                 % length of the 2nd rod in m
L3 = 7;              % length of the 3rd rod in m
L4 = 12;

alpha_0 = 45*pi/180;               % initial alpha in rad
beta_0 = 24.652*pi/180;               % initial beta in rad
delta_0 = 90.6794*pi/180;               % initial delta in rad

J = [-L2*sin(beta_0) L3*sin(delta_0); L2*cos(beta_0) -L3*cos(delta_0)]; % calculates vectors for links 2 and 3
b = [alphadot*L1*sin(alpha_0); -alphadot*L1*cos(alpha_0)];
omega23 = inv(J)*b;
betadot = omega23(1);
deltadot = omega23(2);

t = [0:100];
alpha = alpha_0+alphadot*t;
beta = beta_0+betadot*t;
delta = delta_0+deltadot*t;

A = [0;0];

B = [L1*cos(alpha); L1*sin(alpha)] + A;

C = B+[beta*L2];

D = [A+L4;0];

plot(C')


end

