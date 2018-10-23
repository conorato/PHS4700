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
        
        function output = convertConstraint(constraint)
            if(constraint == Constraints.Goal)
                output = 1;
            elseif(constraint == Constraints.Ground)
                output = 0;
            elseif(constraint == Constraints.TouchesVerticalPost || constraint == Constraints.TouchesHorizontalPost)
                output = -1;
            elseif(constraint == Constraints.GoalKick || constraint == Constraints.FreeThrow)
                output = -2;
            end
        end
    end
end
