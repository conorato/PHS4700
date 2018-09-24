classdef Cockpit < PlanePart
    methods
        function obj = Cockpit()
            obj.mass = Constants.COCKPIT_MASS;
            obj.massCenterPosition = obj.calculateMassCenter();
            obj.momentOfInertiaMatrix = obj.getIMatrix();
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
        function momentOfInertiaMatrix = getIMatrix(obj)
            radius = Constants.COCKPIT_RADIUS;
            height = Constants.COCKPIT_LENGTH;
            mass =   Constants.COCKPIT_MASS;
            
            momentOfInertiaMatrix = mass*[(12*radius^2+3*height^2)/80, 0, 0;
                                            0,(12*radius^2+3*height^2)/80, 0;
                                            0, 0, 3/10*radius^2];
        end
    end
end
