classdef Fin < PlanePart
    methods
        function obj = Fin()
            obj.mass = Constants.FIN_MASS;
            obj.massCenterPosition = obj.calculateMassCenter();
            obj.momentOfInertiaMatrix = obj.calculateMomentOfInertia();
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
    methods
        function momentOfInertiaMatrix = calculateMomentOfInertia(obj)
            height = Constants.FIN_HEIGHT;
            width = Constants.FIN_WIDTH;
            depth = Constants.FIN_THICKNESS;
            
            Ix = (height^2 + depth^2)/12;
            Iy = (width^2 + height^2)/12;
            Iz = (width^2 + depth^2)/12;
            momentOfInertiaMatrix = obj.mass*[Ix, 0, 0;
                                              0, Iy, 0;
                                              0,  0, Iz];
        end
    end
end
