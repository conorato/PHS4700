classdef Cinematic
    methods(Static)
        function gravitationForce = gravitationForce(mass)
            gravitationForce = [0;0;-mass * Constants.GRAVITATIONAL_FORCE];
        end
        
        function dragForce = dragForce(velocity, area)
            dragForce = - Constants.DRAG_COEFFICIENT * area * velocity;
        end
        
        function acceleration = getAcceleration(gameObject, velocity)
            if(gameObject == GameObject.Can)
                mass = Constants.CAN_MASS;
                area = Constants.CAN_HEIGHT ^ 2 + Constants.CAN_RADIUS ^ 2;
            elseif(gameObject == GameObject.Ball)
                mass = Constants.BALL_MASS;
                area = pi * Constants.BALL_RADIUS ^ 2;
            end
            acceleration = (Cinematic.gravitationForce(mass) + Cinematic.dragForce(velocity, area)) / mass;
        end
    end
end

