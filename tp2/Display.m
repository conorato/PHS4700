classdef Display
    methods(Static)
        function init()
            clf;
            Display.displayField();
            Display.displayGoals();
            xlabel('x(m)');
            ylabel('y(m)');
            zlabel('z(m)');
            title('Trajectoire de la balle');
            axis equal;
            hold on;
        end
        
        function displayField()
            X = [Constants.MIN_X Constants.MIN_X Constants.MAX_X Constants.MAX_X];
            Y = [Constants.MIN_Y Constants.MAX_Y Constants.MAX_Y Constants.MIN_Y];
            Z = [0 0 0 0];
            darkGreen = [0.4 0.75 0.31];
            fill3(X, Y, Z, darkGreen);
            hold on;
        end
        
        function displayGoals()
            Display.drawLine([Constants.POST_BOTTOM_LEFT(1) Constants.POST_BOTTOM_LEFT(2) 0], [Constants.POST_BOTTOM_LEFT(1) Constants.POST_BOTTOM_LEFT(2) Constants.GOAL_HEIGHT]);
            Display.drawLine([Constants.POST_BOTTOM_LEFT(1) Constants.POST_BOTTOM_LEFT(2) Constants.GOAL_HEIGHT], [Constants.POST_TOP_LEFT(1) Constants.POST_TOP_LEFT(2) Constants.GOAL_HEIGHT]);
            Display.drawLine([Constants.POST_TOP_LEFT(1) Constants.POST_TOP_LEFT(2) Constants.GOAL_HEIGHT], [Constants.POST_TOP_LEFT(1) Constants.POST_TOP_LEFT(2) 0]);
            Display.drawLine([Constants.POST_BOTTOM_RIGHT(1) Constants.POST_BOTTOM_RIGHT(2) 0], [Constants.POST_BOTTOM_RIGHT(1) Constants.POST_BOTTOM_RIGHT(2) Constants.GOAL_HEIGHT]);
            Display.drawLine([Constants.POST_BOTTOM_RIGHT(1) Constants.POST_BOTTOM_RIGHT(2) Constants.GOAL_HEIGHT], [Constants.POST_TOP_RIGHT(1) Constants.POST_TOP_RIGHT(2) Constants.GOAL_HEIGHT]);
            Display.drawLine([Constants.POST_TOP_RIGHT(1) Constants.POST_TOP_RIGHT(2) Constants.GOAL_HEIGHT], [Constants.POST_TOP_RIGHT(1) Constants.POST_TOP_RIGHT(2) 0]);
            hold on;
        end

        function drawLine(from, to)
            plot3([from(1) to(1)], [from(2) to(2)], [from(3) to(3)], 'b-', 'LineWidth', 1);
        end
    end
end

