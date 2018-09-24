function [pcm, MI, aa] = Devoir1(posA, ar, va, Forces)
    plane = Plane();
    pcm = plane.calculateGlobalPCM(posA, ar)
    MI = [0; 0; 0]
    aa = 0
end
