function [finalQCan, finalQBall] = rungeKutta(vbal, wboi, tl)
    Display.init();    

    qCan    = [Constants.CAN_INITIAL_VELOCITY; Constants.CAN_INITIAL_POSITION; wboi; Constants.IDENTITY_QUATERNION];
    qBall   = [vbal; Constants.BALL_INITIAL_POSITION; Constants.BALL_INITIAL_ANG_VELOCITY; Constants.IDENTITY_QUATERNION];
    gCan = @calculateGCan;
    gBall = @calculateGBall;
    t = 0;
    
    while(true)
        qCanPrecedent = qCan;
        qBallPrecedent = qBall;
        qCan  = SEDRK4t0(qCan, t, Constants.DELTA_T, gCan)
        qBall = SEDRK4t0(qBall, t, Constants.DELTA_T, gBall)
        if( qCan(6) <= 0 )
            break;
        end
        t = Constants.DELTA_T + t;
        Display.drawLine(qCanPrecedent(4:6), qCan(4:6), GameObject.Can);
        Display.drawLine(qBallPrecedent(4:6), qBall(4:6), GameObject.Ball);
    end
    
    finalQCan = qCan;
    finalQBall = qBall;
end

function vector = calculateGCan(q, t)
    acceleration = Cinematic.getAcceleration(GameObject.Can, q(1:3));
    velocity = q(1:3);
    vector = [acceleration ; velocity ; Constants.ANGULAR_ACCELERATION ; getQuaternionRotation(q)];
end

function vector = calculateGBall(q, t)
    acceleration = Cinematic.getAcceleration(GameObject.Ball, q(1:3));
    velocity = q(1:3);
    vector = [acceleration ; velocity ; Constants.ANGULAR_ACCELERATION ; getQuaternionRotation(q)];
end

function quaternion = getQuaternionRotation(q)
    rotationQuaternion = transpose(q(10:13));
    angularVelocity = [0 transpose(q(7:9))];
    quaternion = transpose(0.5 * QProduit(rotationQuaternion, angularVelocity));
end