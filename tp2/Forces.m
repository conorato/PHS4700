classdef Forces
    methods(Static)
        function gravitationForce = gravitationForce( )
            gravitationForce = [0;0;-Constants.BALL_MASS * Constants.GRAVITY];
        end

        function dragForce = dragForce( velocity )
            area = pi * Constants.BALL_RADIUS^2;
            dragCoefficient = Forces.calculateDragCoefficient(norm(velocity));

            dragForce = -area * Constants.AIR_DENSITY * dragCoefficient * velocity;
        end
        
        function forceM = magnusForce(v, w)
            magnusCoefficient = Forces.calculateMagnusCoefficient(v, w);
            speed = norm(v);
            crossProduct = cross(w,v);
            crossProductNorm =  norm(crossProduct);
            if  (crossProductNorm ~= 0)
                forceM = Constants.AIR_DENSITY * magnusCoefficient * Constants.BALL_AREA * speed^2 * crossProduct /crossProductNorm;
            else
                forceM = [0;0;0];
            end    
        end

        function coefficient = calculateDragCoefficient(speed)
            reynoldNumber = (Constants.AIR_DENSITY * speed * Constants.BALL_RADIUS) / Constants.AIR_VISCOSITY;
            if(reynoldNumber < 1e+5) 
                coefficient = 0.235 * speed;
            elseif(reynoldNumber < 1.35e+5)
                coefficient = 0.235 * speed - (0.125 * speed * (reynoldNumber - 1e+5)/3.5e+4);
            else
                coefficient = 0.11 * speed;
            end
        end
        
        function magnusCoefficient = calculateMagnusCoefficient(v, w)
            magnusCoefficient = 0.1925*(norm(w)*Constants.BALL_RADIUS/norm(v))^(1/4);
        end
    end
end

