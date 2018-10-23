classdef Cinematic
    methods(Static)
        function acceleration = getAcceleration(v, w)
            totalForce  = Forces.dragForce(v) + Forces.magnusForce(v, w) + Forces.gravitationForce();
            acceleration = totalForce / Constants.BALL_MASS;
        end
        
        function newVelocity = getVelocity(velocity, angularVelocity, deltaT)
            k1 = Cinematic.getAcceleration(velocity, angularVelocity);
            k2 = Cinematic.getAcceleration(velocity + deltaT/2  * k1, angularVelocity);
            k3 = Cinematic.getAcceleration(velocity + deltaT/2  * k2, angularVelocity);
            k4 = Cinematic.getAcceleration(velocity + deltaT  * k3, angularVelocity);

            newVelocity = velocity + deltaT/6 * (k1 + 2*k2 + 2*k3 + k4);
        end
        
        function position = getPosition( ri, vi, deltaT)
            position = ri + vi * deltaT;
        end
    end
end
