classdef Body < PlanePart
    methods
        function obj = Body()
            obj.mass = Constants.BODY_MASS;
            obj.massCenterPosition = obj.calculateMassCenter();
            obj.momentOfInertiaMatrix = obj.calculateMomentOfInertia();
        end
    end
    methods(Static)
        function massCenterPosition = calculateMassCenter()
            xMassCenter = Constants.BODY_LENGTH/2;
            yMassCenter = 0;
            zMassCenter = Constants.BODY_RADIUS + Constants.WING_THICKNESS;
            massCenterPosition = [xMassCenter; yMassCenter; zMassCenter];
        end
    end
    methods
        function momentOfInertiaMatrix = calculateMomentOfInertia(obj)
            radius = Constants.BODY_RADIUS;
            height = Constants.BODY_LENGTH;
            Ix = 0.5*radius^2; 
            Iy = (3*radius^2+height^2)/12;
            Iz = (3*radius^2+height^2)/12;
            momentOfInertiaMatrix = obj.mass*[ Ix, 0, 0;
                                               0, Iy, 0;
                                               0, 0, Iz];
        end
    end
end