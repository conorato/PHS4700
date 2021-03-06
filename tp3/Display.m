classdef Display
    methods(Static)
        function init()
            clf;
            Display.displayField();
            xlabel('x(m)');
            ylabel('y(m)');
            zlabel('z(m)');
            title('Trajectoire de la boite de conserve');
            axis equal;
            hold on;
        end
        
        function displayField()
            X = [0 0 6 6];
            Y = [-2 2 2 -2];
            Z = [0 0 0 0];
            darkGreen = [0.4 0.75 0.31];
            fill3(X, Y, Z, darkGreen);
            hold on;
        end

        function drawLine(from, to, gameObject)
            if gameObject == GameObject.Ball 
                char = 'p'; 
            else
                char = '*';
            end
            plot3([from(1) to(1)], [from(2) to(2)], [from(3) to(3)], char, 'MarkerSize', 5);
        end
    end
end

