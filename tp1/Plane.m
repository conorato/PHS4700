classdef Plane
    properties
        parts
        massCenterPosition
    end
    methods
        function obj = Plane()
            obj.parts = [
                Cockpit()
                Body()
                Wing(PartPosition.Left)
                Wing(PartPosition.Right)
                Fin()
                Reactor(PartPosition.Left)
                Reactor(PartPosition.Right)
            ];
            obj.massCenterPosition = calculateMassCenter();
        end
    end
    
    methods(Static)
        function  localPosA = calculateLocalPosA()
            z = BODY_RADIUS + WING_THICKNESS;
            y = 0;
            x = BODY_LENGTH + COCKPIT_LENGTH;
            
            localPosA = [x; y; z];
        end
    end
    
    methods(Static)
        function massCenterPosition = calculateMassCenter()
            sumOfWeightedMassCenters = 0;
            for idx = 1:numel(obj.parts)
                part = obj.parts(idx);
                sumOfWeightedMassCenters = part.mass * part.massCenterPosition;
            end
            massCenterPosition = sumOfWeightedMassCenters / sum(vertcat(obj.parts.mass())); %arrayfun(@(part) part.getMass(), obj.parts)
        end
    end
    
    methods(Static)
        function globalPCM = calculatePCMGlobalPosition(posA, ar)
            localPosA = calculateLocalPosA();
            localOrigin = [posA(1)- localPosA(1); posA(2)- localPosA(2); posA(3)- localPosA(3)];
            centeredPCM = calculateMassCenter() + localOrigin - posA;
            
            rotationMatrix = [cos(ar), 0, sin(ar); 0, 1, 0; -sin(ar), 0, cos(ar)];
            
            globalPCM = rotationMatrix * centeredPCM + posA;
        end
    end
end