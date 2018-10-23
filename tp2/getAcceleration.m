function a = getAcceleration(v, w)
    totalForce  = Forces.dragForce(v) + Forces.magnusForce(v, w) + Forces.gravitationForce();
    a = totalForce / Constants.BALL_MASS;
end
