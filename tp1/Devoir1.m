function [pcm, MI, aa] = Devoir1(posA, ar, va, Forces)
    plane = Plane();
    pcm = plane.calculateGlobalPCM(posA, ar)
    MI = plane.momentOfInertia
    aa = plane.calculateAngularAcceleration(MI, ar, va, Forces)
end
