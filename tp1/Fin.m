classdef Fin < PlanePart
    methods
        function obj = Fin()
            obj.mass = Constants.FIN_MASS;
            obj.massCenterPosition = obj.calculateMassCenter();
        end
    end
    methods(Static)
        function massCenterPosition = calculateMassCenter()
            xMassCenter = Constants.FIN_WIDTH/2;
            yMassCenter = 0;
            zMassCenter = Constants.FIN_HEIGHT/2 + 2 * Constants.BODY_RADIUS + Constants.WING_THICKNESS;
            massCenterPosition = [xMassCenter; yMassCenter; zMassCenter];
        end
    end
end
