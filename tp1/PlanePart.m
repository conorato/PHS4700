classdef (Abstract) PlanePart < matlab.mixin.Heterogeneous
    properties
       mass
       massCenterPosition
    end
    methods(Static)
        massCenterPosition = calculateMassCenter()
    end
end