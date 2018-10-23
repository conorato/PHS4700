classdef Helper
    methods(Static)
        % Returns distance between 2 points in 2 dimensions.
        function d = getDistance(x1, x2, y1, y2)
           d = sqrt((x1 - x2).^2 + (y1 - y2).^2);
        end

        % Returns vertical posts positions of whichever goal the ball is closest to.
        function posts = getVerticalPosts(ri)
           if (ri(1) < Constants.MAX_X / 2) 
              post1 = Constants.POST_BOTTOM_LEFT;
              post2 = Constants.POST_TOP_LEFT;
           else 
              post1 = Constants.POST_BOTTOM_RIGHT;
              post2 = Constants.POST_TOP_RIGHT;
           end
           posts = [post1, post2];
        end

        % Returns whether or not the ball is in contact with a post.
        function res = touchesVerticalPost(ri) 
           posts = Helper.getVerticalPosts(ri);
           if (ri(3) > Constants.GOAL_HEIGHT + Constants.BALL_RADIUS) 
              res = false;
              return;
           end
           res = Helper.getDistance(posts(1, 1), ri(1), posts(2,1), ri(2)) <= Constants.BALL_RADIUS || Helper.getDistance(posts(1, 2), ri(1), posts(2, 2), ri(2)) <= Constants.BALL_RADIUS;
        end

        function res = touchesHorizontalPost(ri)
           posts = Helper.getVerticalPosts(ri);
           if (ri(2) <= posts(2, 1) - Constants.BALL_RADIUS || ri(2) >= posts(2, 2) + Constants.BALL_RADIUS)
              res = false;
              return;
           end
           res = Helper.getDistance(ri(1), posts(1, 1), ri(3), Constants.GOAL_HEIGHT) <= Constants.BALL_RADIUS;
        end

        % Returns whether or not the ball is inside one of the goals.
        function res = isGoal(ri)
           posts = Helper.getVerticalPosts(ri);
           if (ri(3) >= Constants.GOAL_HEIGHT - Constants.BALL_RADIUS || ri(2) <= posts(2, 1) + Constants.BALL_RADIUS || ri(2) >= posts(2,2) - Constants.BALL_RADIUS)
              res = false;
              return;
           end
           res = ri(1) <= Constants.MIN_X || ri(1) >= Constants.MAX_X;
        end

        % Returns whether or not the ball is out the sides of the pitch.
        function res = isFreeThrow(ri)
           res = ri(2) < Constants.MIN_Y || ri(2) > Constants.MAX_Y;
        end

        % Returns whether or not the ball is behind the goal line without being a goal.
        function res = isGoalKick(ri)
           res = ri(1) <= Constants.MIN_X || ri(1) >= Constants.MAX_X;
        end

        % Returns whether or not the ball is touching the ground.
        function res = touchesGround(ri) 
           res = ri(3) < Constants.BALL_RADIUS;
        end
    end
end
