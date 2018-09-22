classdef Body < PlanePart
    methods
        function obj = Body()
            obj.mass = Constants.BODY_MASS;
            obj.massCenterPosition = obj.calculateMassCenter();
        end
    end
    methods(Static)
        function massCenterPosition = calculateMassCenter()
            xMassCenter = Constants.BODY_LENGTH/2;
            yMassCenter = 0;
            zMassCenter = Constants.BODY_RADIUS + Constants.WING_THICKNESS;
            massCenterPosition = [xMassCenter yMassCenter zMassCenter];
        end
    end
end