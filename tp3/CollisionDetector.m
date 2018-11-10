classdef CollisionDetector 
    methods(Static) 
        function output = touchesGround(ballPos)
            output = ballPos(3) - Constants.BALL_RADIUS <= 0;
        end

        function output = isCollision(ballPos, canPos, canQuaternion) 
            ballPosInNewRef = transformPositionToLocalSpace(ballPos, canPos, canQuaternion);
            output = ballPosInNewRef;
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