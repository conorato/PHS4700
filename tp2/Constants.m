classdef Constants
    properties(Constant)
        BALL_MASS       = 0.45                  % [kg]
        BALL_RADIUS     = 0.11                  % [m]
        BALL_AREA       = pi * Constants.BALL_RADIUS^2    % [m^2]
        
        GRAVITY         = 9.8                   % [m/s^2]
        AIR_DENSITY     = 1.2754                % [kg/m^2]
        AIR_VISCOSITY   = 1.8e-5                % [kg/(m*s)]
        
        DELTA_T         = 1/60;                 % [1/s]
    end
end