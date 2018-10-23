classdef Constraints
    enumeration
        None,
        Ground,
        FreeThrow,
        Goal,
        TouchesVerticalPost,
        TouchesHorizontalPost,
        GoalKick
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
            elseif(Helper.touchesHorizontalPost(position))
                brokenConstraint = Constraints.TouchesHorizontalPost;
            elseif(Helper.isGoalKick(position))
                brokenConstraint = Constraints.GoalKick;
            end
        end
    end
end
