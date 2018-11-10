function [finalQCan, finalQBall] = rungeKutta(vbal, wboi, tl)
    Display.init();    

    qCan = [Constants.CAN_INITIAL_VELOCITY; Constants.CAN_INITIAL_POSITION; wboi; Constants.IDENTITY_QUATERNION];
    gCan = @calculateGCan;
    tCan = 0;
    
    while(true)
        qCanPrecedent = qCan;
        qCan = SEDRK4t0(qCan, tCan, Constants.DELTA_T, gCan)
        if( qCan(6) <= 0 )
            break;
        end
        tCan = Constants.DELTA_T + tCan;
        Display.drawLine(qCanPrecedent(4:6), qCan(4:6));
    end
    
    finalQCan = qCan;
end

function vector = calculateGCan(q, t)
    acceleration = Cinematic.getAcceleration(GameObject.Can, q(1:3));
    velocity = q(1:3);
    angularAcceleration = [0; 0; 0];
    rotationQuaternion = transpose(q(10:13));
    angularVelocity = [0 transpose(q(7:9))];
    quaternionRotation = transpose(0.5 * QProduit(rotationQuaternion, angularVelocity));
    vector = [acceleration ; velocity ; angularAcceleration ; quaternionRotation];
end

function vector = calculateGBall(q, t)

end
