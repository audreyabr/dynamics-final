
Output = dynamics_wing(60*pi/180, 60*pi/180, 1.2562, 2.2169);
animation(Output)

for idx = 30:5:90
    Output = dynamics_wing(60*pi/180, idx*pi/180, 1.2562, 2.2169);
    t = [0:100];    % time range
    hold on
    plot(t,Output(16,:),'DisplayName',strcat('sigma=',num2str(idx)))
    legend('show')
    xlabel('time, s')
    ylabel('y position, m')
    title('vertical displacement of H at different sigma angles')  
end