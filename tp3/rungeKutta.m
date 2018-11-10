function [finalQCan, finalQBall] = rungeKutta(vbal, wboi, tl)
    
    qCan = [Constants.CAN_INITIAL_VELOCITY; Constants.CAN_INITIAL_POSITION; wboi; Constants.IDENTITY_QUATERNION];
    gCan = @calculateGCan;
    tCan = 0;
    
    while(true)
        qCan = SEDRK4t0(qCan, tCan, Constants.DELTA_T, gCan)
        if( qCan(6) <= 0 )
            break;
        end
        tCan = Constants.DELTA_T + tCan;
    end
    
    finalQCan = qCan;
end

function vector = calculateGCan(q, t)
    acceleration = Cinematic.getAcceleration(GameObject.Can, q(1:3));
    velocity = q(1:3);
    angularAcceleration = [0; 0; 0];
    rotationQuaternion = transpose(q(10:13));
    angularVelocity = [0 transpose(q(7:9))];
    quaternionRotationMatrix = transpose(0.5 * QProduit(rotationQuaternion, angularVelocity));
    vector = [acceleration ; velocity ; angularAcceleration ; quaternionRotationMatrix];
end

function vector = calculateGBall(q, t)

end
