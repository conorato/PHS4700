classdef Display
    methods(Static)
        function displayField()
            X = [0 0  120 120];
            Y = [0 90 90  0  ];
            Z = [0 0  0   0  ];
            darkGreen = [0.4 0.75 0.31];
            fill3(X, Y, Z, darkGreen);
            xlabel('x(m)');
            ylabel('y(m)');
            zlabel('z(m)');
            title('Trajectoire de la balle');
            axis equal;
            hold on;
        end

        function drawLine(from, to)
            plot3([from(1) to(1)], [from(2) to(2)], [from(3) to(3)], 'b-', 'LineWidth', 1);
        end
    end
end

