function forceM = magnusForce(v, w)
    magnusCoefficient = calculateMagnusCoefficient(v, w);
    speed = norm(v);
    crossProduct = cross(w,v);
    crossProductNorm =  norm(crossProduct);
    if  (crossProductNorm ~= 0)
        forceM = Constants.AIR_DENSITY * magnusCoefficient * Constants.BALL_AREA * speed^2 * crossProduct /crossProductNorm;
    else
        forceM = [0;0;0];
    end    
end

function magnusCoefficient = calculateMagnusCoefficient(v, w)

    magnusCoefficient = 0.1925*(norm(w)*Constants.BALL_RADIUS/norm(v))^(1/4);
end
