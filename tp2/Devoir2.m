function [ But tf rf vf ] = Devoir2( ri, vi, wi )
    time = 0;
    
    correctError(ri, time);
end


function rf = simulateTrajectory(ri, vi, wi, deltaT, time) 
    
    while(true)
        %todo: contraintes a respecter a implementer
        if(isOutOfField(ri))
            break;
        end
        vi = calculateNewVelocity(vi, wi, deltaT);
        ri = getPosition(ri, vi);
        time = time + deltaT;
    end
    rf = ri;
end