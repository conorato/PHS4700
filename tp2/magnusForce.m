function forceM = magnusForce(v, w)
    magnusCoefficient = calculateMagnusCoefficient(v, w);
    speed = norm(v);
    crossProduct = cross(w,v);
    forceM = Constants.AIR_DENSITY* magnusCoefficient * Constants.BALL_AREA * speed^2 * crossProduct / norm(crossProduct);
end

function magnusCoefficient = calculateMagnusCoefficient(v, w)

    magnusCoefficient = 0.1925*(norm(w)*Constants.BALL_RADIUS/norm(v))^(1/4);
end
