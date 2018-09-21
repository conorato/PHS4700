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
        end
    end
    methods(Static)
        function calculateMassCenter()
            sumOfWeightedMassCenters = 0;
            for idx = 1:numel(obj.parts)
                part = obj.parts(idx);
                sumOfWeightedMassCenters = part.mass * part.massCenterPosition;
            end
            obj.massCenterPosition = sumOfWeightedMassCenters / sum(vertcat(obj.parts.mass())); %arrayfun(@(part) part.getMass(), obj.parts)
        end
    end
end