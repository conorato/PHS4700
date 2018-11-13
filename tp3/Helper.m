classdef Helper
    methods(Static)
        function output = distance(x1, y1, x2, y2)
            output = sqrt((x1 - x2).^2 + (y1 - y2).^2);
        end
    end
end
