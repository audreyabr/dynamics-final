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

t = [0:0.001:100];
alpha = alpha_0+alphadot*t
beta = beta_0+betadot*t;
delta = delta_0+deltadot*t;

A = [0;0]*t;

B = [L1*cos(alpha); L1*sin(alpha)] + A;

C = B+[beta*L2];

D = [L4;0]+A;


AB = [L1*cos(alpha); L1*sin(alpha)];
BC = [L2*cos(beta); L2*sin(beta)];
DC = [L3*cos(delta); -L3*sin(delta)];
AD = [L4;0];

wing_tot = AB+BC

for point = 1:length(wing_tot)
        
        % create wing vectors
        wing_x = [0 AB(1,point); AB(1,point) BC(1,point); BC(1,point) wing_tot(1,point)]
        wing_y = [0 AB(2,point); AB(2,point) BC(2,point); BC(2,point) wing_tot(2,point)]

        x = [AB(1,point) BC(1,point) wing_tot(1,point)];
        y = [AB(2,point) BC(2,point) wing_tot(2,point)];

        plot(wing_x, wing_y,"-b","MarkerSize",5), hold on

        x = [AB(1,point) BC(1,point) wing_tot(1,point)];
        y = [AB(2,point) BC(2,point) wing_tot(2,point)];

        trail_x = wing_tot(1:1,point)
        trail_y = wing_tot(1:2,point)

        plot(trail_x,trail_y,":k","MarkerSize",.1),hold off
        axis([-(L1+L2) L1+L2 -(L1+L2) L1+L2])
        drawnow
        
end

