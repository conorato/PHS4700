function [tps ftrain Itrain] = Devoir4(vtrainkmh,fAvion)
    vtrainms = Utilities.kphToMps(vtrainkmh);
    tps = findTimeAtCollision(vtrainms, Constants.TRAIN_INITIAL_POSITION);
    time = tps;
    [ftrain, Itrain] = fillWithZeros(time);
    planePosition = [0; 0; 0];
    planePosition = updatePosition(planePosition, Constants.PLANE_VELOCITY, time);
    while(true)
        trainPosition = getTrainPosition(time, vtrainms);
        u = Utilities.normalize(trainPosition - planePosition);
        frequency = Utilities.dopplerEffect(u, vtrainms, fAvion);
        intensity = Utilities.getSoundIntensityLevel(trainPosition, planePosition, fAvion);
        ftrain = [ftrain; frequency];
        Itrain = [Itrain; intensity];
        if (intensity <= 20)
            break;
        end
        planePosition = updatePosition(planePosition, Constants.PLANE_VELOCITY, 1);
        time = time + 1;
    end
end

function [ftrain, Itrain] = fillWithZeros(time)
    ftrain = zeros(int32(time), 1);
    Itrain = zeros(int32(time), 1);
end

function newPosition = updatePosition(position, velocity, deltaT)
    newPosition = position + velocity * deltaT;
end

function trainPosition = getTrainPosition(time, trainVelocity)
    trainPosition = Constants.TRAIN_INITIAL_POSITION + time * trainVelocity;
end

function tps = findTimeAtCollision(trainSpeed, trainInitialPosition)
    a = (trainSpeed(1)^2 + trainSpeed(2)^2 + trainSpeed(3)^2 - Constants.SOUND_SPEED^2);
    b = 2 * (trainSpeed(1) * trainInitialPosition(1) + trainSpeed(2) * trainInitialPosition(2) + trainSpeed(3) * trainInitialPosition(3));
    c = trainInitialPosition(1)^2 + trainInitialPosition(2)^2 + trainInitialPosition(3)^2;
    
    tps = max(resolveQuadraticEquation(a, b, c));
end

function x = resolveQuadraticEquation(a, b, c)
   x = zeros(2,1);
   d = sqrt(b^2 - 4*a*c);
   x(1) = ( -b + d ) / (2*a);
   x(2) = ( -b - d ) / (2*a);
end