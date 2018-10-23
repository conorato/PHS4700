classdef Simulation
    methods(Static)
        function [lastPosition, nextPosition, lastVelocity, nextVelocity, time] = simulateTrajectory(ri, vi, wi, deltaT, time) 
            lastPosition =ri; nextPosition = ri; lastVelocity = vi; nextVelocity = vi;
            while(true)
                if(Constraints.areBroken(nextPosition))
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
        
        function [position, velocity, time] = correctError(lastPosition, nextPosition, lastVelocity, nextVelocity, time, wi)
            deltaT = Constants.DELTA_T;
            while(deltaT > 0)
                lastTime = time - deltaT;
                if(Simulation.isPositionValid(lastPosition))
                    position = lastPosition;
                    time = lastTime;
                    velocity = lastVelocity;
                    break
                elseif(Simulation.isPositionValid(nextPosition))
                    position = nextPosition;
                    velocity = nextVelocity;
                    break
                end
                deltaT = deltaT / 2;
                [lastPosition, nextPosition, lastVelocity, nextVelocity, time] = Simulation.simulateTrajectory(lastPosition, lastVelocity, wi, deltaT, lastTime);
            end
        end
        
        function isPositionValid = isPositionValid(position)
            isPositionValid = abs(position(3) - Constants.MIN_Z) < Constants.MAX_ERROR;
        end
    end
end

