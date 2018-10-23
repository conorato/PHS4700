classdef Simulation
    methods(Static)
        function [lastPosition, nextPosition, lastVelocity, nextVelocity, time, brokenConstraint] = simulateTrajectory(ri, vi, wi, deltaT, time) 
            lastPosition =ri; nextPosition = ri; lastVelocity = vi; nextVelocity = vi;
            while (true)
                brokenConstraint = Constraints.getBrokenConstraint(nextPosition);
                if (brokenConstraint ~= Constraints.None)
                    break;
                end
                Display.drawLine(lastPosition, nextPosition);
                lastPosition = nextPosition;
                lastVelocity = nextVelocity;
                nextVelocity = Cinematic.getVelocity(lastVelocity, wi, deltaT);
                nextPosition = Cinematic.getPosition(lastPosition, nextVelocity, deltaT);
                time = time + deltaT;
            end
        end
        
        function [position, velocity, time, brokenConstraint] = correctError(lastPosition, nextPosition, lastVelocity, nextVelocity, time, wi, brokenConstraint)
            deltaT = Constants.DELTA_T;
            while(deltaT > 0)
                lastTime = time - deltaT;
                if (Simulation.isPositionValid(lastPosition, brokenConstraint))
                    position = lastPosition;
                    time = lastTime;
                    velocity = lastVelocity;
                    break
                elseif (Simulation.isPositionValid(nextPosition, brokenConstraint))
                    position = nextPosition;
                    velocity = nextVelocity;
                    break
                end
                deltaT = deltaT / 2;
                [lastPosition, nextPosition, lastVelocity, nextVelocity, time, brokenConstraint] = Simulation.simulateTrajectory(lastPosition, lastVelocity, wi, deltaT, lastTime);
            end
        end
        
        function isPositionValid = isPositionValid(position, brokenConstraint)
            X = 1; Y = 2; Z = 3;
            switch brokenConstraint
                case Constraints.Ground
                    isPositionValid = abs(position(Z) - Constants.MIN_Z) < Constants.MAX_ERROR;
                case Constraints.FreeThrow
                    isPositionValid = abs(position(Y) - Constants.MIN_Y) < Constants.MAX_ERROR || abs(position(Y) - Constants.MAX_Y) < Constants.MAX_ERROR;
                case Constraints.Goal
                case Constraints.GoalKick
                    isPositionValid = abs(position(X) - Constants.MIN_X) < Constants.MAX_ERROR || abs(position(X) - Constants.MAX_X) < Constants.MAX_ERROR;
                case Constraints.TouchesVerticalPost
                    verticalPosts = Helper.getVerticalPosts(position);
                    d1 = Helper.getDistance(position(X), verticalPosts(1, X), position(Y), verticalPosts(1, Y));
                    d2 = Helper.getDistance(position(X), verticalPosts(2, X), position(Y), verticalPosts(2, Y));
                    isPositionValid = abs(d1 - Constants.BALL_RADIUS) < Constants.MAX_ERROR || abs(d2 - Constants.BALL_RADIUS) < Constants.MAX_ERROR;
                case Constraints.TouchesHorizontalPost
                    d1 = Helper.getDistance(position(X), Constants.MIN_X, position(Z), Constants.GOAL_HEIGHT);
                    d2 = Helper.getDistance(position(X), Constants.MAX_X, position(Z), Constants.GOAL_HEIGHT);
                    isPositionValid = abs(d1 - 0.11) < Constants.MAX_ERROR || abs(d2 - 0.11 < Constants.MAX_ERROR);
                otherwise
                    isPositionValid = false;
            end    
        end
    end
end
