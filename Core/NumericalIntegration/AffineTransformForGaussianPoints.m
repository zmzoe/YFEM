function points = AffineTransformForGaussianPoints(gpoints, cubeNodes)
bottom = min(cubeNodes);
top = max(cubeNodes);
A = 0.5*(top-bottom);
b = 0.5*(top+bottom);
if size(gpoints, 2) == 1
    points = gpoints.*A + b;
else
    variableInd = (top~=bottom);
    gpoints_ = zeros(size(gpoints, 1), size(A, 2));
    gpoints_(:, variableInd) = gpoints;
    points =  gpoints_.*A + b;
end
end
