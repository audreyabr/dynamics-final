function dynamics_wing
clear all
close all

% Define system parameters

alphadot = 100; % input angular velocity in rad/sec
t = [0:100];    % time range

L1 = 4;              % length of the rod AB in m
L2 = 10;             % length of the rod BC in m
L3 = 7;              % length of the rod CD in m
L4 = 12;             % length of the rod AD in m
L5 = 12;             % length of the rod CE in m
L6 = 4;              % length of the rod CF in m
L7 = 10;             % length of the rod FG in m
L8 = 7;              % length of the rod EG in m
L9 = 5;              % length of the rod EH in m
ls = [L1, L2, L3, L4, L5, L6, L7, L8,L9];

alpha_0 = 45*pi/180;               % initial alpha in rad
beta_0 = 24.652*pi/180;            % initial beta in rad
delta_0 = 90.6794*pi/180;          % initial delta in rad
phi = 30*pi/180;                   % fixed phi in rad
sigma = 30*pi/180;                 % fixed sigma in rad

% Calculate the angular velocity of beta and delta
J = [-L2*sin(beta_0) L3*sin(delta_0); L2*cos(beta_0) -L3*cos(delta_0)];
b = [alphadot*L1*sin(alpha_0); -alphadot*L1*cos(alpha_0)];
omega23 = inv(J)*b;
betadot = omega23(1);
deltadot = omega23(2);

% Calculate matrices holding the angles over time
alpha = alpha_0+alphadot*t;
beta = beta_0+betadot*t;
delta = delta_0+deltadot*t;

% Calculate the positions of A, B, C, D in the 4-bar frame
A = [0;0]*t;
B = [L1*cos(alpha); L1*sin(alpha)] + A;
C = B+[beta*L2];
D = [L4;0]+A; 

% Rotate A, B, C, D to the inertial frame 
R_sigma = [];

A = A;
B = B;
C = C;
D = D;

% Calcualte F and E based of the position of C
CD = C - D;
cd = CD./norm(CD);
E = C + cd * L5;

CB = C - B;
cb = CB./norm(CB);
F = C + cb * L6;

% Calculate G based off of intersection of circles
G = [];
for idx = 1:length(E)
    [Gx,Gy] = circcirc(E(1,idx), E(2,idx), L8, F(1,idx), F(2,idx), L7);
    G(:,idx) = [Gx(1);Gy(1)];
end

% Calculate H based off of E and G
EG = E - G;
eg = EG./norm(EG);

R_phi = [];
eh = eg * R_phi;

H = E + eh * L9;

