function Output = dynamics_wing()
clear all
close all

% Define system parameters

alphadot = 100; % input angular velocity in rad/sec 
t = [0:100];    % time range

L1 = .4767;              % length of the rod AB in m
L2 = 2;             % length of the rod BC in m
L3 = 1.2562;              % length of the rod CD in m
L4 = 2.2169;             % length of the rod AD in m
L5 = 4;             % length of the rod CE in m
L6 = 0.5;              % length of the rod CF in m
L7 = 4;             % length of the rod FG in m
L8 = .5386;              % length of the rod EG in m
L9 = 4;              % length of the rod EH in m
ls = [L1, L2, L3, L4, L5, L6, L7, L8,L9];

alpha = 45*pi/180;               % initial alpha in rad
beta = 24.652*pi/180;            % initial beta in rad
delta = 90.6794*pi/180;          % initial delta in rad

phi = 60*pi/180;                   % fixed phi in rad (wing angle)
sigma = 60*pi/180;                 % fixed sigma in rad (body angle)

% Calculate the angular velocity of beta and delta
alpha_angles = [];
beta_angles = [];
delta_angles = [];
for idx = 1:length(t)
    J = [-L2*sin(beta) L3*sin(delta); L2*cos(beta) -L3*cos(delta)];
    b = [alphadot*L1*sin(alpha); -alphadot*L1*cos(alpha)];
    omega23 = inv(J)*b;
    betadot = omega23(1)
    deltadot = omega23(2)
    
    alpha = alpha + alphadot * .001;
    alpha_angles(idx) = alpha;
    
    beta = beta + betadot * .001;
    beta_angles(idx) = beta;

    delta = delta + deltadot *.001;
    delta_angles(idx) = delta;
end

% Calculate the positions of A, B, C, D in the 4-bar frame
A = [0;0]*t;
B = [L1*cos(alpha_angles); L1*sin(alpha_angles)] + A;
D = [L4;0]+A; 
C = [L3*cos(delta_angles); L3*sin(delta_angles)] + D;


% Rotate A, B, C, D to the inertial frame 
R_sigma = [cos(sigma), -sin(sigma); sin(sigma), cos(sigma)];

A = R_sigma*A;
B = R_sigma*B;
C = R_sigma*C;
D = R_sigma*D;

% Calcualte F and E based of the position of C
CD = D - C;
cd = [];
for idx = 1:length(CD)
    cd(:,idx) = CD(:,idx)/norm(CD(:,idx));
end
E = C + (cd * L5);

CB = B - C;
cb = [];
for idx = 1:length(CB)
    cb(:,idx) = CB(:,idx)/norm(CB(:,idx));
end
F = C + (cb * L6);

% Calculate G based off of intersection of circles
G = [];
for idx = 1:length(E)
    [Gx,Gy] = circcirc(E(1,idx), E(2,idx), L8, F(1,idx), F(2,idx), L7);
    [~,I] = min(Gy);
    G(:,idx) = [Gx(I);Gy(I)];
end

% Calculate H based off of E and G
EG = G - E;
eg = [];
for idx = 1:length(EG)
    eg(:,idx) = EG(:,idx)/norm(EG(:,idx));
end

R_phi = [cos(phi), -sin(phi); sin(phi), cos(phi)];
eh = R_phi * eg;

H = E + eh * L9;

%Assemble Output
Points = [A;B;C;D;E;F;G;H];
Angles = [alpha_angles; beta_angles; delta_angles];
Output = [Points;Angles];
end

