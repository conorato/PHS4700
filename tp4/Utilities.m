classdef Utilities
    methods(Static)
        function receivedFrequency = dopplerEffect(u, receiverVelocity, sourceFrequency)
            receivedFrequency = ((Constants.SOUND_SPEED - dot(receiverVelocity,  u))/            ...
                                 (Constants.SOUND_SPEED - dot(Constants.PLANE_VELOCITY, u))) ...
                                  * sourceFrequency;
        end
        
        function receivedIntensity = getSoundIntensityLevel(trainPosition, planePosition, frequency)
            distance = norm(planePosition - trainPosition);
            viscosityCoefficient = (0.8 + 0.0041 * frequency)/1000;
            receivedIntensity = Constants.INITIAL_INTENSITY_LVL - 20 * log(distance/Constants.DISTANCE_INIT_INTENSITY) ...
                                - viscosityCoefficient * (distance - Constants.DISTANCE_INIT_INTENSITY);
        end
        
        function norma = normalize(a)
            norma = a/norm(a);
        end
        
        function output = kphToMps(v)
            output = v / 3.6;
        end

        function output = distance(p1, p2)
            output = sqrt( (p1(1) - p2(1))^2 + (p1(2) - p2(2))^2 + (p1(3) - p2(3))^2 );
        end
    end
end
