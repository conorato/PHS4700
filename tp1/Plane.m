classdef Plane
    properties
        parts
        massCenterPosition
    end
    methods
        function obj = Plane(posA)
            obj.parts = [
                Cockpit(posA)
                Body(posA)
                Wing(posA, PartPosition.Left)
                Wing(posA, PartPosition.Right)
                Fin(posA)
                Reactor(posA, PartPosition.Left)
                Reactor(posA, PartPosition.Right)
            ];
            obj.massCenterPosition = calculateMassCenter();
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
        function massCenterPosition = calculateMassCenter()
            sumOfWeightedMassCenters = 0;
            for idx = 1:numel(obj.parts)
                part = obj.parts(idx);
                sumOfWeightedMassCenters = part.mass * part.massCenterPosition;
            end
            massCenterPosition = sumOfWeightedMassCenters / sum(vertcat(obj.parts.mass())); %arrayfun(@(part) part.getMass(), obj.parts)
        end
    end
    methods
        function 
    end
end