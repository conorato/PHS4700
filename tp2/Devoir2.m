function [ But, tf, rf, vf ] = Devoir2( ri, vi, wi )
    Display.displayField();
    time = 0;
    rf = simulateTrajectory(ri, vi, wi, Constants.DELTA_T, time)
end

function rf = simulateTrajectory(ri, vi, wi, deltaT, time) 
    nextPosition = ri;
    while(true)
        if(areConstraintsBroken(nextPosition))
            break;
        end
        lastPosition = nextPosition;
        vi = calculateNewVelocity(vi, wi, deltaT);
        nextPosition = getPosition(nextPosition, vi);
        time = time + deltaT;
        Display.drawLine(lastPosition, nextPosition);
    end
    rf = lastPosition;
end

function areConstraintsBroken = areConstraintsBroken(position)
    areConstraintsBroken = Helper.touchesGround(position);
end