classdef Constants
    properties(Constant)
        BALL_MASS       = 0.45                              % [kg]
        BALL_RADIUS     = 0.11                              % [m]
        BALL_AREA       = pi * Constants.BALL_RADIUS^2      % [m^2]
        
        GRAVITY         = 9.8                               % [m/s^2]
        AIR_DENSITY     = 1.2754                            % [kg/m^2]
        AIR_VISCOSITY   = 1.8e-5                            % [kg/(m*s)]
        
        DELTA_T         = 1/60;                             % [1/s]
        
        % constraints
 
        MIN_X           = 0 + Constants.BALL_RADIUS;        % [m]
        MAX_X           = 120 - Constants.BALL_RADIUS;      % [m]
        
        MIN_Y           = 0 + Constants.BALL_RADIUS;        % [m]
        MAX_Y           = 90 - Constants.BALL_RADIUS;       % [m]
        
        MIN_Z           = 0 + Constants.BALL_RADIUS;        % [m]

        % bottom left post
        POST1           = [1, 2]                         % [posX, posY]
        % top left post
        POST2           = [1, 2]                         % [posX, posY]
        % bottom right post 
        POST3           = [1, 2]                         % [posX, posY]
        % top right post
        POST4           = [1, 2]                         % [posX, posY]
    end
end