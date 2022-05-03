function wing_4_bar_linkage
clear all
close all

% Define system parameters
%
L1 = 0.36;              % length of the first rod in m
L2 = 2;                 % length of the 2nd rod in m
L3 = 1.26;              % length of the 2nd rod in m
L4 = 2.22;              % length of the 2nd rod in m

% Define state variables: 
%  z1 = alpha z2 = alphadot z3 = beta z4 = betadot z5 = delta z6 = deltadot

% Specify initial conditions for cartesian coordinates
z1_0 = 0.52;               % initial alpha in rad
z2_0 = 20;                 % initial alphadot in rad/s
z3_0 = .174;               % initial beta in rad
z4_0 = 0;                  % initial betadot in rad/s
z5_0 = 1.39;               % initial delta in rad
z6_0 = 0;                  % initial deltadot in rad/s
% put IC's into a single variable 
Z_0 = [z1_0, z2_0, z3_0, z4_0, z5_0, z6_0];

% Define time
T_span = [0: 0.005: 20];  % time range for simulation with specified time step

% run the ODEs
[t, zout] = ode45(@cylindrical, T_span, Z_0);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Convert Cylindrical to Cartesian Frame
alpha = zout(:,1);
beta = zout(:,3);
%delta = zout(:,5);

B = [L1*sin(alpha) + L1*cos(alpha)];
Cdiff = [L2*sin(beta) + L2*cos(beta)];
C = B + Cdiff;

% Plot Position
figure (1)
plot(0,0,'r')
plot(L4,0,'r')
plot(B(:,1), B(:,2))
hold
plot(C(:,1), C(:,2))
title('Position In X-Y Space')
xlabel('x-disp (m)')
ylabel('y-disp (m)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot Position, Velocity, Tension
% figure (2)
% subplot(3,1,1), plot(t, zout(:,1))
% hold
% plot(t, zout(:,2))
% title('Angular Position Over Time')
% ylabel('Position (rad)')
% subplot(3,1,2), plot(t, zout(:,3))
% hold
% plot(t, zout(:,4))
% title('Angular Velocity Over Time')
% ylabel('Velocity (rad/s)')
% subplot(3,1,3), plot(t, T1)
% hold
% plot(t, T2)
% title('Tension Over Time')
% legend('Mass 1', 'Mass 2')
% xlabel('Time (s)')
% ylabel('Tension (N)')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate Angular Acceleration
accel1 = gradient(zout(:,3), 0.005)
accel2 = gradient(zout(:,4), 0.005)

% Plot Angular Acceleration
figure (3)
plot(t,accel1)
hold
plot(t, accel2)
title('Angular Acceleration Over Time')
xlabel('Time (s)')
ylabel('Acceleration (rad/s^2)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% function: equations of motion in first order form
    function dzdt = cylindrical(T,Z)

%  z1 = alpha z2 = alphadot z3 = beta z4 = betadot z5 = delta z6 = deltadot

    matrix = [-m1*L1*Z(2) 0 0 0 1 -cos(t2t1);
              0 -m1*L1 0 0 0 sin(t2t1); 
              -m2*L1*Z(2) 0 -m2*L2*Z(4)*cos(t2t1) -m2*L2*sin(t2t1) 0 cos(t2t1); 
              0 -m2*L1 m2*L2*Z(4)*sin(t2t1) -m2*L2*cos(t2t1) 0 -sin(t2t1); 
              1 0 0 0 0 0;
              0 0 1 0 0 0];
    vector = [m1*g*cos(Z(1)); m1*g*sin(Z(1)); m2*g*cos(Z(1)); m2*g*sin(Z(1)); Z(2); Z(4)];
%
dzdt = matrix\vector;
%
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [eventvalue,stopthecalc,eventdirection] = event_stop(T,Z)
     
 % stop when the cart traverses the full horizontal distance
        eventvalue      =  Z(1)-L    %  ‘Events’ are detected when eventvalue=0
        stopthecalc     =  1;       %  Stop if event occurs
        eventdirection  = 0;       %  Detect only events with dydt<0 (falling)
end
      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end