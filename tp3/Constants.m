classdef Constants
    properties(Constant)
        CAN_MASS                = 0.075;                            %[kg]
        CAN_HEIGHT              = 0.15;                             %[m]
        CAN_RADIUS              = Constants.CAN_HEIGHT / sqrt(6);   %[m]
        CAN_INITIAL_POSITION    = [3; 0; 10];                       %[m]
        CAN_INITIAL_VELOCITY    = [0; 0; 0];                        %[m/s]
        
        BALL_RADIUS                 = 0.0335;               %[m]
        BALL_MASS                   = 0.058;                %[kg]
        BALL_INITIAL_POSITION       = [0; 0; 2];            %[m]
        BALL_INITIAL_ANG_VELOCITY   = [0; 0; 0];            %[rad/s]
       
        ANGULAR_ACCELERATION    = [0; 0; 0];                %[rad/s^2]
        GRAVITATIONAL_FORCE     = 9.8;                      %[m/s]
        DRAG_COEFFICIENT        = 0.1;                      %[kg/(m^2*s)]
        
        RESTITUTION_COEFFICIENT = 0.5;
        
        IDENTITY_QUATERNION     = [1; 0; 0; 0]; 
        INITIAL_STEP_DISTANCE   = 0.1;                     %[m]
        EPSILON                 = [0.001, 0.001, 0.001];    %[m]
    end
end
