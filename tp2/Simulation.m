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
            end
        end
    end
end
