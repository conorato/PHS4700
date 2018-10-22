function [ But, tf, rf, vf ] = Devoir2( ri, vi, wi )
    time = 0;
    rf = simulateTrajectory(ri, vi, wi, Constants.DELTA_T, time)
end


function rf = simulateTrajectory(ri, vi, wi, deltaT, time) 
    while(true)
        if(areConstraintsBroken(ri))
            break;
        end
        vi = calculateNewVelocity(vi, wi, deltaT);
        ri = getPosition(ri, vi);
        time = time + deltaT;
    end
    rf = ri;
end

function areConstraintsBroken = areConstraintsBroken(ri)
    areConstraintsBroken = Helper.touchesGround(ri);
end