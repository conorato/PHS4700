classdef Wing < PlanePart
    properties
        partPosition
    end
    methods
        function obj = Wing(partPosition)
            obj.mass = Constants.WING_MASS;
            obj.partPosition = partPosition;
            obj.massCenterPosition = obj.calculateMassCenter();
        end
    end
    methods
        function massCenterPosition = calculateMassCenter(obj)
            xMassCenter = Constants.WING_X_CENTER_OFFSET;
            yMassCenter = obj.partPosition * Constants.WING_LENGTH/2;
            zMassCenter = Constants.WING_THICKNESS/2;
            massCenterPosition = [xMassCenter; yMassCenter; zMassCenter];
        end
    end
end