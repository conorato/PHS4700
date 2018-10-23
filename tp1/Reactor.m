classdef Reactor < PlanePart
    properties
        partPosition
    end
    methods
        function obj = Reactor(partPosition)
            obj.mass = Constants.REACTOR_MASS;
            obj.partPosition = partPosition;
            obj.massCenterPosition = obj.calculateMassCenter();
            obj.momentOfInertiaMatrix = obj.calculateMomentOfInertia();
        end
    end
    methods
        function massCenterPosition = calculateMassCenter(obj)
            xMassCenter = Constants.REACTOR_X_CENTER_OFFSET;
            yMassCenter = obj.partPosition * (Constants.BODY_RADIUS + Constants.REACTOR_RADIUS);
            zMassCenter = Constants.BODY_RADIUS + Constants.WING_THICKNESS;
            massCenterPosition = [xMassCenter; yMassCenter; zMassCenter];
        end
    end
    methods
        function momentOfInertiaMatrix = calculateMomentOfInertia(obj)
            radius = Constants.REACTOR_RADIUS;
            height = Constants.REACTOR_LENGTH;
            Ix = 0.5*radius^2; 
            Iy = (3*radius^2+height^2)/12;
            Iz = (3*radius^2+height^2)/12;
            momentOfInertiaMatrix = obj.mass*[ Ix, 0, 0;
                                               0, Iy, 0;
                                               0, 0, Iz];
        end
    end
end