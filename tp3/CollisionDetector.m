classdef CollisionDetector 
    methods(Static)
        function output = getBrokenConstraint(ballPos, canPos, canQuaternion)
            ballPosInNewRef = transformPositionToLocalSpace(ballPos, canPos, canQuaternion);
            output = Constraints.None;
            if (CollisionDetector.touchesGround(ballPos))
                output = Constraints.Ground;
            elseif (CollisionDetector.touchesCanTopFace(ballPosInNewRef))
                output = Constraints.CanTopFace;
            elseif (CollisionDetector.touchesCanBottomFace(ballPosInNewRef))
                output = Constraints.CanBottomFace;
            elseif (CollisionDetector.touchesCanSide(ballPosInNewRef))
                output = Constraints.CanSide;
            elseif (CollisionDetector.touchesCanTopCorner(ballPosInNewRef))
                output = Constraints.CanTopCorner;
            elseif (CollisionDetector.touchesCanBottomCorner(ballPosInNewRef))
                output = Constraints.CanBottomCorner;
            end
        end

        function output = touchesGround(ballPos)
            output = ballPos(3) - Constants.BALL_RADIUS <= 0;
        end

        function output = touchesCanSide(ballPos)
            output = (-Constants.CAN_HEIGHT/2 < ballpos(3) < Constants.CAN_HEIGHT/2) && ...
                distance(ballPos(1), ballPos(2),0 ,0) <= Constants.BALL_RADIUS + Constants.CAN_RADIUS;
        end
        
        function output = touchesCanTopFace(ballPos)
            output = (-Constants.CAN_HEIGHT/2 >= ballPos(3) > Constants.CAN_HEIGHT/2) && ... 
                distance(ballPos(1), ballPos(2), 0, 0) < Constants.CAN_RADIUS && ...
                (Constants.CAN_HEIGHT/2 + Constants.BALL_RADIUS/2) >= ballPos(3);
        end
        
        function output = touchesCanBottomFace(ballPos)
            output = (-Constants.CAN_HEIGHT/2 >= ballPos(3) > Constants.CAN_HEIGHT/2) && ... 
                distance(ballPos(1), ballPos(2), 0, 0) < Constants.CAN_RADIUS && ...
                (-Constants.CAN_HEIGHT/2 - Constants.BALL_RADIUS/2) <= ballPos(3);
        end
        
        function output = touchesCanTopCorner(ballPos)
            output = (Constants.CAN_HEIGHT/2 <= ballPos(3) <= Constants.CAN_HEIGHT/2 + Constants.BALL_RADIUS) && ... 
                Constants.BALL_RADIUS <= distance(ballPos(1)^2, ballPos(2)^2, 0, 0) <= Constants.BALL_RADIUS + Constants.CAN_RADIUS;
        end
        
        function output = touchesCanBottomCorner(ballPos)
            output = (-Constants.CAN_HEIGHT/2 - Constants.BALL_RADIUS <= ballPos(3) <= -Constants.CAN_HEIGHT/2) && ... 
                Constants.BALL_RADIUS <= distance(ballPos(1)^2, ballPos(2)^2, 0, 0) <= Constants.BALL_RADIUS + Constants.CAN_RADIUS;
        end

        function output = transformPositionToLocalSpace(pos, refPos, refQuaternion)
            pos = pos - refPos;
            invertedQuaternion = CollisionDetector.invertQuaternion(refQuaternion);
            % ball position in can's local space.
            pos = QRotation(invertedQuaternion, [0 pos]);
            output = pos(2:4);
        end

        function output = invertQuaternion(q)
            invFactor = q(1)^2 + q(2)^2 + q(3)^2 + q(4)^2;
            output = QConjugue(q) / invFactor;
        end
    end
end