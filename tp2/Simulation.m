classdef Simulation
    methods(Static)
        function [lastPosition, nextPosition, lastVelocity, nextVelocity, time, brokenConstraint] = simulateTrajectory(ri, vi, wi, deltaT, time) 
            lastPosition =ri; nextPosition = ri; lastVelocity = vi; nextVelocity = vi;
            while(true)
                brokenConstraint = Constraints.getBrokenConstraint(nextPosition);
                if(brokenConstraint ~= Constraints.None)
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
                if(Simulation.isPositionValid(lastPosition, brokenConstraint))
                    position = lastPosition;
                    time = lastTime;
                    velocity = lastVelocity;
                    break
                elseif(Simulation.isPositionValid(nextPosition, brokenConstraint))
                    position = nextPosition;
                    velocity = nextVelocity;
                    break
                end
                deltaT = deltaT / 2;
                [lastPosition, nextPosition, lastVelocity, nextVelocity, time, brokenConstraint] = Simulation.simulateTrajectory(lastPosition, lastVelocity, wi, deltaT, lastTime);
            end
        end
        
        function isPositionValid = isPositionValid(position, brokenConstraint)
            if(brokenConstraint == Constraints.Ground)
                isPositionValid = abs(position(3) - Constants.MIN_Z) < Constants.MAX_ERROR;
            elseif(brokenConstraint == Constraints.FreeThrow)
                if position(2) > Constants.MAX_Y/2; reference = Constants.MAX_Y; else; reference = Constants.MIN_Y; end
                isPositionValid = abs(position(2) - reference) < Constants.MAX_ERROR;
            elseif(brokenConstraint == Constraints.Goal || brokenConstraint == Constraints.GoalKick)
                if position(1) > Constants.MAX_X/2; reference = Constants.MAX_X; else; reference = Constants.MIN_X; end
                isPositionValid = abs(position(1) - reference) < Constants.MAX_ERROR;
            elseif(brokenConstraint == Constraints.TouchesVerticalPost)
                verticalPosts = Helper.getVerticalPosts(position);
                if position(2) > Constants.MAX_Y/2; reference = verticalPosts(:,2); else; reference = verticalPosts(:,1); end
                isPositionValid = (Helper.getDistance(position(1), reference(1), position(2), reference(2)) - Constants.BALL_RADIUS) < Constants.MAX_ERROR;
            elseif(brokenConstraint == Constraints.TouchesHorizontalPost)
                if position(1) > Constants.MAX_X/2; referenceX = Constants.MAX_X; else; referenceX = Constants.MIN_X; end
                isPositionValid = Helper.getDistance(position(1), referenceX, position(3), Constants.GOAL_HEIGHT) - 0.11 < Constants.MAX_ERROR;
            end
        end
    end
end
