function [finalQCan, finalQBall] = rungeKutta(vbal, wboi, tl)
    Display.init();    
    
    qCan    = [Constants.CAN_INITIAL_VELOCITY; Constants.CAN_INITIAL_POSITION; wboi; Constants.IDENTITY_QUATERNION];
    qBall   = [vbal; Constants.BALL_INITIAL_POSITION; Constants.BALL_INITIAL_ANG_VELOCITY; Constants.IDENTITY_QUATERNION];
    t = 0; stepDistance = Constants.INITIAL_STEP_DISTANCE;
    deltaT = getDeltaT(stepDistance, vbal);
    conv = 0;
    
    while(~conv)
        [qCan, qBall, t, conv, constraint] = simulate(qBall, qCan, t, tl, deltaT);
        stepDistance = stepDistance / 10;
        deltaT = getDeltaT(stepDistance, norm(vbal));
    end
    finalQCan = qCan
    finalQBall = qBall
    
    CollisionDetector.getContactPoint(constraint, finalQBall(4:6), finalQCan(4:6), finalQCan(10:13))
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

function deltaT = getDeltaT(distance, velocity)
    if(norm(velocity))
        deltaT = distance / norm(velocity);
    else
        deltaT = distance;
    end
end

function [qCan, qBall, t, conv, constraint] = simulate(qBall, qCan, t, tl, deltaT)
    qCanPrecedent = qCan; qBallPrecedent = qBall;
    while(true)
        brokenConstraint = CollisionDetector.getBrokenConstraint(qBall(4:6), qCan(4:6), qCan(10:13));
        if (brokenConstraint ~= Constraints.None)
            constraint = brokenConstraint
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
    convCan = ErrSol(qCan, qCanPrecedent, Constants.EPSILON);
    convBall = ErrSol(qBall, qBallPrecedent, Constants.EPSILON);
    qCan = qCanPrecedent;
    qBall = qBallPrecedent;
    conv = convCan && convBall;
    t = t - deltaT;
end
