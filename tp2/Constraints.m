classdef Constraints
    methods(Static)
        function areBroken = areBroken(position)
            areBroken = Helper.touchesGround(position);
        end
    end
end

