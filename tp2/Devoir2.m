function [ But, tf, rf, vf ] = Devoir2( ri, vi, wi )
    Display.displayField();
    time = 0;
    [lastPosition, nextPosition, lastVelocity, nextVelocity, time] = Simulation.simulateTrajectory(ri, vi, wi, Constants.DELTA_T, time);
    if(lastPosition == nextPosition) % Then initial position is already breaking a constraint 
        tf = time
        rf = ri
        vf = vi
    else
        [rf, vf, tf] = Simulation.correctError(lastPosition, nextPosition, lastVelocity, nextVelocity, time, wi)
    end
end
