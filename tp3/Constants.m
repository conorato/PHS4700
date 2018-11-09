classdef Constants
    properties(Constant)
        CAN_MASS                = 0.075;                %[kg]
        CAN_HEIGHT              = 0.15;                 %[m]
        CAN_RADIUS              = CAN_HEIGHT / sqrt(6); %[m]
        CAN_INITIAL_POSITION    = [3; 0; 10];           %[m]
        
        BALL_RADIUS             = 0.0335;               %[m]
        BALL_MASS               = 0.058;                %[kg]
        BALL_INITIAL_POSITION   = [0; 0; 2];            %[m]
       
        GRAVITATIONAL_FORCE     = 9.8;                  %[m/s]
        DRAG_COEFFICIENT        = 0.1;                  %[kg/(m^2*s)]
        
        RESTITUTION_COEFFICIENT = 0.5;
    end
end
