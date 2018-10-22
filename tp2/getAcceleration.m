function a = getAcceleration(v, w)
    totalForce  = dragForce(v) + magnusForce(v, w) + gravitationForce();
    a = totalForce / Constants.BALL_MASS;
end
