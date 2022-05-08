function dynamics_wing
clear all
close all

% Define system parameters
alphadot = 100; % rad/sec

L1 = 4;              % length of the first rod in m
L2 = 10;                 % length of the 2nd rod in m
L3 = 7;              % length of the 3rd rod in m
L4 = 12;
L5 = 12;
L6 = 4;
L7 = 10;
L8 = 7;
rs = [L1, L2, L3, L4, L5, L6, L7, L8];

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

%theta_0 = 2*pi - alpha(1) - beta(1) - delta(1);
theta_0 = 0*pi/180;
sigma_0 = 45*pi/180;
phi_0 = 135*pi/180; 
th = [theta_0, sigma_0, phi_0]

A = [0;0]*t;

B = [L1*cos(alpha); L1*sin(alpha)] + A;

C = B+[beta*L2];

D = [L4;0]+A;

wing_tot = A+B+C+D;

[sigma, phi] = possol4(th,rs);


% for point = 1:length(wing_tot)
%         
%         % create pendulum arms vectors
%         wing_x = [0 A(point,1);
%                            A(point,1) wing_tot(point,1)];
%         wing_y = [0 A(point,2);
%                            A(point,2) wing_tot(point,2)];
% 
%         plot(wing_x, wing_y,"-b","MarkerSize",5), hold on
%         
% end

