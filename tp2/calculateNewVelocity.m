
function newVelocity = calculateNewVelocity(velocity, angularVelocity)
    k1 = getAcceleration(velocity, angularVelocity)
    k2 = getAcceleration(velocity + Constants.DELTA_T/2  * k1, angularVelocity)
    k3 = getAcceleration(velocity + Constants.DELTA_T/2  * k2, angularVelocity)
    k4 =  getAcceleration(velocity + Constants.DELTA_T  * k3, angularVelocity)

    newVelocity = velocity + Constants.DELTA_T/6 * (k1 + 2*k2 + 2*k3 + k4) + getError(); 
end

function error = getError()

    error = 0;
end