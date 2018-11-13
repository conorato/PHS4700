classdef Physics
    methods(Static)
        function [vap,vbp, rap, rbp] = calculateContactPointSpeed(brokenConstraint, finalQCan, finalQBall)
            ballPos = finalQBall(4:6);
            canPos = finalQCan(4:6);
            vap = [0;0;0]; vbp = [0;0;0]; rap = [0;0;0]; rbp = [0;0;0];
            if (brokenConstraint ~= Constraints.Ground)
                vap = finalQBall(1:3);
                rap = finalQBall(4:6) - CollisionDetector.getContactPoint(brokenConstraint, ballPos, canPos, finalQCan(10:13));
                rbp = finalQCan(4:6) - CollisionDetector.getContactPoint(brokenConstraint, ballPos, canPos, finalQCan(10:13));
                vbp = finalQCan(1:3) + cross(finalQCan(7:9), rbp);                
            end
        end

        function n = calculateN(ballPos, contactPoint)
            n = (ballPos - contactPoint)/norm(ballPos - contactPoint);
        end
    end
end