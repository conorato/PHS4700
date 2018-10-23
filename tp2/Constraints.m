classdef Constraints
    enumeration
        None,
        Ground,
        FreeThrow,
        Goal,
        TouchesVerticalPost,
        TouchesHorizontalPost,
        IsGoalKick
    end

    methods(Static)
        function brokenConstraint = getBrokenConstraint(position)
            brokenConstraint = Constraints.None;
            if(Helper.touchesGround(position))
                brokenConstraint = Constraints.Ground;
            elseif(Helper.isFreeThrow(position))
                brokenConstraint = Constraints.FreeThrow;
            elseif(Helper.isGoal(position))
                brokenConstraint = Constraints.Goal;
            elseif(Helper.touchesVerticalPost(position))
                brokenConstraint = Constraints.TouchesVerticalPost;
            elseif(Helper.isGoalKick(position))
                brokenConstraint = Constraints.IsGoalKick;
            end
    
        end
    end
end
