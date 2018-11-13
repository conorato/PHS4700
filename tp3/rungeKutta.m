function [finalQCan, finalQBall] = rungeKutta(vbal, wboi, tl)
    Display.init();    
    
    qCan    = [Constants.CAN_INITIAL_VELOCITY; Constants.CAN_INITIAL_POSITION; wboi; Constants.IDENTITY_QUATERNION];
    qBall   = [vbal; Constants.BALL_INITIAL_POSITION; Constants.BALL_INITIAL_ANG_VELOCITY; Constants.IDENTITY_QUATERNION];
    t = 0; 
    if(norm(vbal))
        deltaT = Constants.INITIAL_STEP_DISTANCE / norm(vbal)
    else
        deltaT = 0.001;
    end
    [qCan, qBall, t] = simulate(qBall, qCan, t, tl, deltaT);
    [finalQCan] = SEDRK4t0ER(qCan, t, t + deltaT, Constants.EPSILON, @gCan)
    [finalQBall] = SEDRK4t0ER(qBall, t, t + deltaT, Constants.EPSILON, @gBall)
end

function vector = gCan(q, t)
    acceleration = Cinematic.getAcceleration(GameObject.Can, q(1:3));
    velocity = q(1:3);
    vector = [acceleration ; velocity ; Constants.ANGULAR_ACCELERATION ; getQuaternionRotation(q)];
end

function vector = gBall(q, t)
    acceleration = Cinematic.getAcceleration(GameObject.Ball, q(1:3));
    velocity = q(1:3);
    vector = [acceleration ; velocity ; Constants.ANGULAR_ACCELERATION ; getQuaternionRotation(q)];
end

function quaternion = getQuaternionRotation(q)
    rotationQuaternion = transpose(q(10:13));
    angularVelocity = [0 transpose(q(7:9))];
    quaternion = transpose(0.5 * QProduit(rotationQuaternion, angularVelocity));
end

function [qCan, qBall, t] = simulate(qBall, qCan, t, tl, deltaT)
    qCanPrecedent = qCan; qBallPrecedent = qBall;
    while(true)
        brokenConstraint = CollisionDetector.getBrokenConstraint(qBall(4:6), qCan(4:6), qCan(10:13));
        if (brokenConstraint ~= Constraints.None)
            brokenConstraint
            break;
        end
        if(qCan(6) > 0 && qBall(6)> 0 && t > tl && qBall(4) < 3.3)
            Display.drawLine(qCanPrecedent(4:6), qCan(4:6), GameObject.Can);
            Display.drawLine(qBallPrecedent(4:6), qBall(4:6), GameObject.Ball);
        end
        qCanPrecedent = qCan; qBallPrecedent = qBall;
        qCan  = SEDRK4t0(qCan, t, deltaT, @gCan);
        if(t >= tl)
            qBall = SEDRK4t0(qBall, t, deltaT, @gBall);
        end
        t = deltaT + t;
    end
    qCan = qCanPrecedent;
    qBall = qBallPrecedent;
    t = t - deltaT;
end
