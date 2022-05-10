for idx = 1:.2:2
    Output = dynamics_wing(60*pi/180, 60*pi/180, idx, 2.2169);
    animation(Output)
end