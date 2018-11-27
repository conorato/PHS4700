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
            receivedIntensity = Constants.INITIAL_INTENSITY_LVL - 20 * log10(distance/Constants.DISTANCE_INIT_INTENSITY) ...
                                - viscosityCoefficient * (distance - Constants.DISTANCE_INIT_INTENSITY);
        end
        
        function norma = normalize(a)
            norma = a/norm(a);
        end
        
        function output = kphToMps(v)
            output = v / 3.6;
        end
    end
end
