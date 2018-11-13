classdef CollisionDetector 
    methods(Static)
    
        function output = getContactPoint(constraint, ballPos, canPos, canQuaternion)
            ballPosInNewRef = CollisionDetector.transformPositionToLocalSpace(ballPos, canPos, canQuaternion);
            switch(constraint)
                case Constraints.CanSide
                    output = CollisionDetector.calculateSideContactPoint(ballPos);
                case Constraints.CanTopFace
                    output = [ballPosInNewRef(1:2),  Constants.CAN_HEIGHT / 2];
                case Constraints.CanBottomFace
                    output = [ballPosInNewRef(1:2), -Constants.CAN_HEIGHT / 2];
                case Constraints.CanTopCorner
                    xy = CollisionDetector.calculateSideContactPoint(ballPos);
                    output = [xy(1:2),  Constants.CAN_HEIGHT / 2];
                case Constraints.CanBottomCorner
                    xy = CollisionDetector.calculateSideContactPoint(ballPos);
                    output = [xy(1:2), -Constants.CAN_HEIGHT / 2];
                otherwise
                    % invalid constraint
                    output = ballPos;
            end
        end

        function output = getBrokenConstraint(ballPos, canPos, canQuaternion)
            ballPosInNewRef = CollisionDetector.transformPositionToLocalSpace(ballPos, canPos, canQuaternion);
            output = Constraints.None;
            if (CollisionDetector.touchesGround(ballPos))
                output = Constraints.Ground;
            elseif (CollisionDetector.touchesCanSide(ballPosInNewRef))
                output = Constraints.CanSide;
            elseif (CollisionDetector.touchesCanTopFace(ballPosInNewRef))
                 output = Constraints.CanTopFace;
            elseif (CollisionDetector.touchesCanBottomFace(ballPosInNewRef))
                output = Constraints.CanBottomFace;
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
            output = (-Constants.CAN_HEIGHT/2 < ballPos(3) && ...
                ballPos(3) < Constants.CAN_HEIGHT/2) && ... 
                distance(ballPos(1), ballPos(2), 0, 0) <= Constants.BALL_RADIUS + Constants.CAN_RADIUS;
        end
        
        function output = touchesCanTopFace(ballPos)
            output = ballPos(3) > 0 && ...
                distance(ballPos(1), ballPos(2), 0, 0) < Constants.CAN_RADIUS && ...
                (Constants.CAN_HEIGHT/2 + Constants.BALL_RADIUS) >= ballPos(3);
        end
        
        function output = touchesCanBottomFace(ballPos)
            output = ballPos(3) < 0 && ...
                distance(ballPos(1), ballPos(2), 0, 0) < Constants.CAN_RADIUS && ...
                (-Constants.CAN_HEIGHT/2 - Constants.BALL_RADIUS) <= ballPos(3);
        end

        function output = touchesCanTopCorner(ballPos)
            rho = sqrt(Constants.BALL_RADIUS^2 - (abs(ballPos(3)) - Constants.CAN_HEIGHT/2)^2);
            output = ballPos(3) > 0 && ...
                (Constants.CAN_HEIGHT/2 <= ballPos(3) && ...
                ballPos(3) <= Constants.CAN_HEIGHT/2 + Constants.BALL_RADIUS) && ... 
                Constants.CAN_RADIUS <= distance(ballPos(1), ballPos(2), 0, 0) && ...
                distance(ballPos(1), ballPos(2), 0, 0) <= Constants.CAN_RADIUS + rho;
        end
        
        function output = touchesCanBottomCorner(ballPos)
            rho = sqrt(Constants.BALL_RADIUS^2 - (abs(ballPos(3)) - Constants.CAN_HEIGHT/2)^2);
            output = ballPos(3) < 0 && ... 
                (-Constants.CAN_HEIGHT/2 - Constants.BALL_RADIUS <= ballPos(3) && ...
                ballPos(3) <= -Constants.CAN_HEIGHT/2) && ... 
                Constants.BALL_RADIUS <= distance(ballPos(1), ballPos(2), 0, 0) && ...
                distance(ballPos(1), ballPos(2), 0, 0) <= Constants.CAN_RADIUS + rho;
        end

        function output = transformPositionToLocalSpace(pos, refPos, refQuaternion)
            pos = pos - refPos;
            invertedQuaternion = CollisionDetector.invertQuaternion(refQuaternion);
            % ball position in can's local space.
            pos = transpose(QRotation(transpose(invertedQuaternion), [0 transpose(pos)]));
            output = pos(2:4);
        end

        function output = calculateSideContactPoint(ballPos)
            distanceFactor = Constants.CAN_RADIUS / distance(ballPos(1), ballPos(2), 0, 0);

            output = [ballPos(1) * distanceFactor, ballPos(2) * distanceFactor, ballPos(3)];
        end

        function output = invertQuaternion(q)
            invFactor = q(1)^2 + q(2)^2 + q(3)^2 + q(4)^2;
            output = transpose(QConjugue(transpose(q))) / invFactor;
        end
    end
end