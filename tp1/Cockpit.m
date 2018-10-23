classdef Cockpit < PlanePart
    methods
        function obj = Cockpit()
            obj.mass = Constants.COCKPIT_MASS;
            obj.massCenterPosition = obj.calculateMassCenter();
            obj.momentOfInertiaMatrix = obj.calculateMomentOfInertia();
        end
    end
    methods(Static)
        function massCenterPosition = calculateMassCenter()
            xMassCenter = Constants.COCKPIT_LENGTH/4 + Constants.BODY_LENGTH;
            yMassCenter = 0;
            zMassCenter = Constants.COCKPIT_RADIUS + Constants.WING_THICKNESS;
            massCenterPosition = [xMassCenter; yMassCenter; zMassCenter];
        end
    end
    methods
        function momentOfInertiaMatrix = calculateMomentOfInertia(obj)
            radius = Constants.COCKPIT_RADIUS;
            height = Constants.COCKPIT_LENGTH;
            Ix = (3*radius^2)/10;
            Iy = (12*radius^2+3*height^2)/80;
            Iz = (12*radius^2+3*height^2)/80;
            momentOfInertiaMatrix = obj.mass* [Ix, 0, 0;
                                               0, Iy, 0;
                                               0, 0, Iz];
        end
    end
end
