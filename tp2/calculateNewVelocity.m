
function newVelocity = calculateNewVelocity(velocity, angularVelocity, deltaT)
    k1 = getAcceleration(velocity, angularVelocity);
    k2 = getAcceleration(velocity + deltaT/2  * k1, angularVelocity);
    k3 = getAcceleration(velocity + deltaT/2  * k2, angularVelocity);
    k4 =  getAcceleration(velocity + deltaT  * k3, angularVelocity);

    newVelocity = velocity + deltaT/6 * (k1 + 2*k2 + 2*k3 + k4);
end
