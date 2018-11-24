classdef Constants
    properties(Constant)
        TEMPERATURE             = 10;                                                                   %[Centigrade]
        SOUND_SPEED             = 331.3 + 0.606 * Constants.TEMPERATURE;                                %[m/s]
        TRAIN_INITIAL_POSITION  = [10000; 10000; 0];                                                    %[m]
        PLANE_VELOCITY          = Utilities.convertKmPerHToMPerS(300 * [cos(pi/18); 0; sin(pi/18)]);    %[m/s]
        
        INITIAL_INTENSITY_LVL   = 160                                                                   %[dB]
        DISTANCE_INIT_INTENSITY = 100                                                                   %[m]
    end
end