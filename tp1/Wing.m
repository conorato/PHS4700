classdef Wing < PlanePart
    properties
        partPosition
    end
    methods
        function obj = Wing(partPosition)
            obj.mass = Constants.WING_MASS;
            obj.partPosition = partPosition;
            obj.massCenterPosition = obj.calculateMassCenter();
            obj.momentOfInertiaMatrix = obj.calculateMomentOfInertia();
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
    methods
        function momentOfInertiaMatrix = calculateMomentOfInertia(obj)
            length = Constants.WING_LENGTH;
            width = Constants.WING_WIDTH;
            depth = Constants.WING_THICKNESS;
            
            Ix = (length^2 + depth^2)/12;
            Iy = (width^2 + depth^2)/12;
            Iz = (length^2 + width^2)/12;
            momentOfInertiaMatrix = obj.mass*[Ix, 0, 0;
                                              0, Iy, 0;
                                              0,  0, Iz];
        end
    end
end