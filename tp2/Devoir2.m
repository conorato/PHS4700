function [ But, tf, rf, vf ] = Devoir2( ri, vi, wi )
    Display.displayField();
    time = 0;
    [lastPosition, nextPosition, lastVelocity, nextVelocity, time] = simulateTrajectory(ri, vi, wi, Constants.DELTA_T, time);
    if(lastPosition == nextPosition)
        tf = time
        rf = ri
        vf = vi
    else
        [rf, vf, tf] = correctError(lastPosition, nextPosition, lastVelocity, nextVelocity, time, wi)
    end
end

function [position, velocity, time] = correctError(lastPosition, nextPosition, lastVelocity, nextVelocity, time, wi)
    deltaT = Constants.DELTA_T;
    while(deltaT > 0)
        lastTime = time - deltaT;
        if(isPositionValid(lastPosition))
            position = lastPosition;
            time = lastTime;
            velocity = lastVelocity;
            break
        elseif(isPositionValid(nextPosition))
            position = nextPosition;
            velocity = nextVelocity;
            break
        end
        deltaT = deltaT / 2;
        [lastPosition, nextPosition, lastVelocity, nextVelocity, time] = simulateTrajectory(lastPosition, lastVelocity, wi, deltaT, lastTime);
    end
end

function isPositionValid = isPositionValid(position)
    isPositionValid = abs(position(3) - Constants.MIN_Z) < Constants.MAX_ERROR;
end

function [lastPosition, nextPosition, lastVelocity, nextVelocity, time] = simulateTrajectory(ri, vi, wi, deltaT, time) 
    lastPosition =ri; nextPosition = ri; lastVelocity = vi; nextVelocity = vi;
    while(true)
        if(areConstraintsBroken(nextPosition))
            break;
        end
        Display.drawLine(lastPosition, nextPosition);
        lastPosition = nextPosition;
        lastVelocity = nextVelocity;
        nextVelocity = calculateNewVelocity(lastVelocity, wi, deltaT);
        nextPosition = getPosition(lastPosition, nextVelocity, deltaT);
        time = time + deltaT;
    end
end

function areConstraintsBroken = areConstraintsBroken(position)
    areConstraintsBroken = Helper.touchesGround(position);
end