classdef Plane
    properties
        parts
        mass
        massCenterPosition
    end
    methods
        function obj = Plane()
            obj.parts = PlanePart.empty();
            obj.parts(end + 1) = Cockpit();
            obj.parts(end + 1) = Body();
            obj.parts(end + 1) = Wing(PartPosition.Left);
            obj.parts(end + 1) = Wing(PartPosition.Right);
            obj.parts(end + 1) = Fin();
            obj.parts(end + 1) = Reactor(PartPosition.Left);
            obj.parts(end + 1) = Reactor(PartPosition.Right);
            obj.mass = sum(arrayfun(@(part) part.mass, obj.parts));
            obj.massCenterPosition = obj.calculateMassCenter();
        end
    end
    
    methods(Static)
        function  localPosA = calculateLocalPosA()
            
            z = Constants.BODY_RADIUS + Constants.WING_THICKNESS;
            y = 0;
            x = Constants.BODY_LENGTH + Constants.COCKPIT_LENGTH;
            
            localPosA = [x; y; z];
        end
        
        function translationMatrix = calculateTranslationMatrix(partCMtoPlaneCM)
            
        end
    end
    
    methods
        function massCenterPosition = calculateMassCenter(obj)
            sumOfWeightedMassCenters = 0;
            for idx = 1:numel(obj.parts)
                part = obj.parts(idx);
                sumOfWeightedMassCenters = sumOfWeightedMassCenters + (part.mass * part.massCenterPosition);
            end
            massCenterPosition = sumOfWeightedMassCenters ./ obj.mass;
        end
        
        function globalPCM = calculateGlobalPCM(obj, posA, ar)
            localPosA = obj.calculateLocalPosA();
            localOrigin = [posA(1)- localPosA(1); posA(2)- localPosA(2); posA(3)- localPosA(3)];
            centeredPCM = obj.massCenterPosition + localOrigin - posA;
            
            rotationMatrix = [cos(ar), 0, -sin(ar); 0, 1, 0; sin(ar), 0, cos(ar)];
            
            globalPCM = rotationMatrix * centeredPCM + posA;
        end
        
        function momentOfInertia = calculateMomentOfInertia(obj)
            for idx = 1:numel(obj.parts)
                part = obj.parts(idx);
               % translate local moment of inertia to the system PCM 
               % 1. Calculate vector of plane CM - part CM
               partCMtoPlaneCM = obj.massCenterPosition  - part.massCenterPosition;
               translationMatrix = calculateTranslationMatrix(partCMtoPlaneCM);
            end
        end
    end
end