classdef Constants
    properties(Constant)
        BALL_MASS           = 0.45                              % [kg]
        BALL_RADIUS         = 0.11                              % [m]
        BALL_AREA           = pi * Constants.BALL_RADIUS^2      % [m^2]
        GRAVITY             = 9.8                               % [m/s^2]
        AIR_DENSITY         = 1.2754                            % [kg/m^2]
        AIR_VISCOSITY       = 1.8e-5                            % [kg/(m*s)]
        
        DELTA_T             = 1/60;                             % [s]
        MAX_ERROR           = 0.001                             % [m]
        
        % constraints
        MIN_X               = 0;                                % [m]
        MAX_X               = 120;                              % [m]
        MIN_Y               = 0;                                % [m]
        MAX_Y               = 90;                               % [m]
        MIN_Z               = 0 + Constants.BALL_RADIUS;        % [m]

        POST_BOTTOM_LEFT    = [0; 41.35];                       % [posX, posY]
        POST_TOP_LEFT       = [0; 48.67];                  
        POST_BOTTOM_RIGHT   = [120; 41.35];               
        POST_TOP_RIGHT      = [120; 48.67];                    
        GOAL_HEIGHT         = 2.44;                             % [m]                 
    end
end