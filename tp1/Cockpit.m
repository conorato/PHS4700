classdef Cockpit < PlanePart
    methods
        function obj = Cockpit()
            obj.mass = Constants.COCKPIT_MASS;
            obj.massCenterPosition = calculateMassCenter();
        end
    end
    methods(Static)
        function massCenterPosition = calculateMassCenter()
            xMassCenter = Constants.COCKPIT_LENGTH/4 + Constants.BODY_LENGTH;
            yMassCenter = 0;
            zMassCenter = Constants.COCKPIT_RADIUS;
            massCenterPosition = (xMassCenter : yMassCenter : zMassCenter);
        end
    end
end