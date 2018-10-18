function force = DragForce( velocity )
    area = pi * Constants.BALL_RADIUS^2;
    dragCoefficient = calculateDragCoefficient(norm(velocity));
    
    force = -area * Constants.AIR_DENSITY * dragCoefficient * velocity;
end

function coefficient = calculateDragCoefficient(speed)
    reynoldNumber = (Constants.AIR_DENSITY * speed * Constants.BALL_RADIUS) / Constants.AIR_VISCOSITY;
    
    if(reynoldNumber < 1e5) 
        coefficient = 0.235 * speed;
    elseif(reynoldNumber > 1.35e5)
        coefficient = 0.235 * speed - (0.125 * speed * (reynoldNumber - 1e5)/3.5e4);
    else
        coefficient = 0.11 * speed;
    end
end

