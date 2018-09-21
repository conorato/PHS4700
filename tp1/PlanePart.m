classdef (Abstract) PlanePart
    properties
       mass
       massCenterPosition
    end
    methods(Static)
        massCenterPosition = calculateMassCenter()
    end
end