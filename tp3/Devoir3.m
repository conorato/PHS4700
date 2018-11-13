function [Coup, tf, vbaf, vbof, wbof, rbaf, rbof] = Devoir3(vbal, wboi, tl)
    [finalQCan, finalQBall] = rungeKutta(vbal, wboi, tl);
    vbaf = [finalQBall(1:3); finalQBall(1:3)];
    vbof = [finalQCan(1:3); finalQCan(1:3)];

    [vap,vbp,rap,rbp] = calculateContactPointSpeed(finalQCan, finalQBall);
    brokenConstraint = CollisionDetector.getBrokenConstraint(finalQBall(4:6), finalQCan(4:6), finalQCan(10:13));
    n = calculateN(finalQBall(4:6), brokenConstraint);
    
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
    j = -alpha(1+ Constants.RESTITUTION_COEFFICIENT)*vr;
    
    %calcul de wfinal:
    wbof = wboi + j*inv(Ican)*cross(rbp,n);
    
    %calcul des vitesses finales au point de contact:
    vapf = vap + j*(n/Constants.BALL_MASS + cross(inv(Iball)*cross(rap,n),rap));
    vbpf = vbp + j*(n/Constants.BALL_MASS + cross(inv(Ican)*cross(rbp,n),rbp));
    
    %reste a trouver les vitesses du centre de masse: 
    Coup = 0;
    tf = 0;
    vbaf = [0 0 0; 0 0 0]';
    vbof = [0 0 0; 0 0 0]';
    rbaf = [0; 0; 0];
    rbof = [0; 0; 0];
end

