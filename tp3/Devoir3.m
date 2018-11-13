function [Coup, tf, vbaf, vbof, wbof, rbaf, rbof] = Devoir3(vbal, wboi, tl)
    [finalQCan, finalQBall, brokenConstraint] = rungeKutta(vbal, wboi, tl);
    [vap,vbp,rap,rbp] = Physics.calculateContactPointSpeed(brokenConstraint, finalQCan, finalQBall);
    contactPoint = CollisionDetector.getContactPoint(brokenConstraint, finalQBall(4:6), finalQCan(4:6), finalQCan(10:13));
    n = Physics.calculateN(finalQBall(4:6), contactPoint);
    
    %matrice d'inertie
    Iball = [2/3 * Constants.BALL_MASS*Constants.BALL_RADIUS^2, 0, 0;
             0, 2/3 * Constants.BALL_MASS*Constants.BALL_RADIUS^2, 0;
             0, 0, 2/3 * Constants.BALL_MASS*Constants.BALL_RADIUS^2];
             
    Ican = [0.5* Constants.CAN_MASS*Constants.CAN_RADIUS^2 + 1/12 * Constants.CAN_MASS*Constants.CAN_HEIGHT^2,0,0;
            0,0.5* Constants.CAN_MASS*Constants.CAN_RADIUS^2 + 1/12 * Constants.CAN_MASS*Constants.CAN_HEIGHT^2, 0;
            0, 0,  Constants.CAN_MASS*Constants.CAN_RADIUS^2];

    %constante pour calculer j:        
    Gball = dot(n, cross((inv(Iball)*cross(rap, n)), rap));
    GCan = dot(n, cross((inv(Ican)*cross(rbp, n)), rbp));
    alpha = 1/(1/Constants.BALL_MASS + 1/Constants.CAN_MASS + Gball + GCan);
    vr = dot(n, (vap-vbp));

    %calcul de j:
    j = -alpha *(1+ Constants.RESTITUTION_COEFFICIENT)*vr;
    
    %calcul de wfinal:
    wbof = wboi + j*inv(Ican)*cross(rbp,n);
    
    %calcul des vitesses finales:
    if(brokenConstraint ~=Constraints.Ground)
        vapf = vap + j*(n/Constants.BALL_MASS + cross(inv(Iball)*cross(rap,n),rap));
        vbpf = vbp + j*(n/Constants.BALL_MASS + cross(inv(Ican)*cross(rbp,n),rbp));
    else
        vapf = finalQBall(1:3);
        vbpf = finalQCan(1:3);
    end
    %reste a trouver les vitesses du centre de masse: 
    if(brokenConstraint ~= Constraints.Ground)
       Coup = 1;
    else
       Coup = 0;
    end
    tf = 0;
    vbaf = [finalQBall(1:3), vapf];
    vbof = [finalQCan(1:3), vbpf];
    rbaf = finalQBall(4:6);
    rbof = finalQCan(4:6);
end

