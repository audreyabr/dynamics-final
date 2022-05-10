
function animation(Output)

t = [0:500];    % time range
for point = 1:length(t)

        % create wing vectors
        AB_x = [Output(1,point) Output(3,point)]
        AB_y = [Output(2,point) Output(4,point)]
        BC_x = [Output(3,point) Output(5,point)]
        BC_y = [Output(4,point) Output(6,point)]
        CD_x = [Output(5,point) Output(7,point)]
        CD_y = [Output(6,point) Output(8,point)]
        CE_x = [Output(5,point) Output(9,point)]
        CE_y = [Output(6,point) Output(10,point)]
        FG_x = [Output(11,point) Output(13,point)]
        FG_y = [Output(12,point) Output(14,point)]
        EG_x = [Output(9,point) Output(13,point)]
        EG_y = [Output(10,point) Output(14,point)]
        EH_x = [Output(9,point) Output(15,point)]
        EH_y = [Output(10,point) Output(16,point)]

        plot(AB_x, AB_y,"-b","MarkerSize",5), hold on
        plot(BC_x, BC_y,"-b","MarkerSize",5)
        plot(CD_x, CD_y, "-b","MarkerSize",5)
        plot(CE_x, CE_y,"-b","MarkerSize",5)
        plot(FG_x, FG_y,"-b","MarkerSize",5)
        plot(EG_x, EG_y,"-b","MarkerSize",5)
        plot(EH_x, EH_y,"-b","MarkerSize",5)
%         xline(Output(7,point))
%         yline(Output(8,point))

        trail_x = Output(1:1,point)
        trail_y = Output(1:2,point)

        plot(trail_x,trail_y,":k","MarkerSize",.1),hold off
        xlabel('x position, m')
        ylabel('y position, m')
        title('Trajectory of Wing')

        axis([-1 8.5 -3 4])
        drawnow
end
end