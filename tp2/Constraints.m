classdef Constraints
    enumeration
        None,
        Ground,
        FreeThrow
    end

    methods(Static)
        function brokenConstraint = getBrokenConstraint(position)
            brokenConstraint = Constraints.None;
            if(Helper.touchesGround(position))
                brokenConstraint = Constraints.Ground;
            elseif(Helper.isFreeThrow(position))
                brokenConstraint = Constraints.FreeThrow;
            end
        end
    end
end
