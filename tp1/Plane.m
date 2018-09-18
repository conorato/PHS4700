classdef Plane
    properties
        cockpit
        body
        leftWing
        rightWing
        fin
        leftReactor
        rightReactor
    end
    methods
        function obj = Plane(posA)
            cockpit = Cockpit(posA)
            
        end
        function pcm = calculateMassCenter()
            pcm = cockpit.calculateMassCenter(posA);
                  
        end
    end
end