classdef Helper
    methods(Static)
        % Returns distance between 2 points in 2 dimensions.
        function d = getDistance(x1, x2, y1, y2)
           d = sqrt((x1 - x2).^2 + (y1 - y2).^2);
        end

        % Returns vertical posts positions of whichever goal the ball is closest to.
        function posts = getPosts(ri)
           if (ri(1) < Constants.MAX_X / 2) 
              post1 = Constants.POST1;
              post2 = Constants.POST2;
           else 
              post1 = Constants.POST3;
              post2 = Constants.POST4;
           end
           posts = [post1, post2];
        end

        % Returns whether or not the ball is in contact with a post.
        function res = touchesPost(ri) 
           posts = getPosts(ri);
           if (ri(3) > Constants.GOAL_HEIGHT + Constants.BALL_RADIUS) 
              res = false;
              return;
           end
           res = getDistance(posts(1).x, ri(1), posts(1).y, ri(2)) <= Constants.BALL_RADIUS || getDistance(posts(2).x, ri(1), posts(2).y, ri(2)) <= Constants.BALL_RADIUS || touchesHorizontalPost(ri);
        end

        function res = touchesHorizontalPost(ri)
           posts = getPosts(ri);
           if (ri.y <= posts(1).y - Constants.BALL_RADIUS || ri.y >= posts(2).y + Constants.BALL_RADIUS)
              res = false;
              return;
           end
           res = getDistance(ri(1), posts(1).x, ri(3), Constants.GOAL_HEIGHT) <= Constants.BALL_RADIUS;
        end

        % Returns whether or not the ball is inside one of the goals.
        function res = isGoal(ri)
           posts = getPosts(ri);
           if (ri(3) >= Constants.GOAL_HEIGHT - Constants.BALL_RADIUS || ri(2) <= posts(1).y + Constants.BALL_RADIUS || ri(2) >= posts(2).y - Constants.BALL_RADIUS)
              res = false;
              return;
           end

           res = ri(1) <= Constants.MIN_X || ri(1) >= Constants.MAX_X;
        end

        % Returns whether or not the ball is out the sides of the pitch.
        function res = isFreeThrow(ri)
           res = ri(2) <= Constants.MIN_Y - Constants.BALL_RADIUS || ri(2) >= Constants.MAX_Y + Constants.BALL_RADIUS;
        end

        % Returns whether or not the ball is behind the goal line without behing a goal.
        function res = isGoalKick(ri)
           res = ~isGoal(ri) && ri(1) <= Constants.MIN_X - Constants.BALL_RADIUS || ri(1) >= Constants.MAX_X + Constants.BALL_RADIUS;
        end

        % Returns whether or not the ball is touching the ground.
        function res = touchesGround(ri) 
           res = ri(3) < Constants.BALL_RADIUS;
        end
    end
end
