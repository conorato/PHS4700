classdef (Abstract) PlanePart < matlab.mixin.Heterogeneous
    properties
       mass
       massCenterPosition
       momentOfInertiaMatrix
    end
    methods(Static)
        massCenterPosition = calculateMassCenter()
    end
end