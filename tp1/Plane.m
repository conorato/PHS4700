classdef Plane
    properties
        parts
        massCenterPosition
    end
    methods
        function obj = Plane()
            obj.parts = Cockpit.empty();
            obj.parts(end + 1) = Cockpit();
            obj.parts(end + 1) = Body();
            obj.parts(end + 1) = Wing(PartPosition.Left);
            obj.parts(end + 1) = Wing(PartPosition.Right);
            obj.parts(end + 1) = Fin();
            obj.parts(end + 1) = Reactor(PartPosition.Left);
            obj.parts(end + 1) = Reactor(PartPosition.Right);
            obj.massCenterPosition = obj.calculateMassCenter();
        end
    end
    methods(Static)
        function  posA = calculateLocalPosA()
            z = BODY_RADIUS + WING_THICKNESS;
            y = 0;
            x = BODY_LENGTH + COCKPIT_LENGTH;
            
            posA = [x,y,z];
        end
    end
    methods
        function massCenterPosition = calculateMassCenter(obj)
            sumOfWeightedMassCenters = 0;
            for idx = 1:numel(obj.parts)
                part = obj.parts(idx);
                sumOfWeightedMassCenters = sumOfWeightedMassCenters + (part.mass * part.massCenterPosition);
            end
            massCenterPosition = sumOfWeightedMassCenters ./ sum(arrayfun(@(part) part.mass, obj.parts));
        end
    end
end
