classdef Reactor < PlanePart
    properties
        partPosition
    end
    methods
        function obj = Reactor(partPosition)
            obj.mass = Constants.REACTOR_MASS;
            obj.partPosition = partPosition;
            obj.massCenterPosition = obj.calculateMassCenter();
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
end