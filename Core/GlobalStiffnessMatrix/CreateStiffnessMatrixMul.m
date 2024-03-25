function M = CreateStiffnessMatrixMul(base1, base2, elementInfo, isNumerical)
base1DofNum = base1.m;
base2DofNum = base2.m;
M = zeros(base1DofNum, base2DofNum);
if exist("isNumerical", "var") && isNumerical
    if elementInfo.type == "simplex"
        [gpoints, weights] = GetHammerIntegralInfoOnSimplex(base1.n, 14);
        points = AffineTransformForHammerPoints(gpoints, elementInfo.nodes);
    elseif elementInfo.type == "cube"
        [gpoints, weights] = GetGaussianIntegralInfoOnCube(base1.n, 14);
        points = AffineTransformForGaussianPoints(gpoints, elementInfo.nodes);
    end
    pointsValue1 = base1.Evaluation(points);
    pointsValue2 = base2.Evaluation(points);
    for j = 1:base2DofNum
        M(:, j) = sum(pointsValue1 .* (pointsValue2(j, :) .* weights'), 2);
    end
else
    for j = 1:base2DofNum
        p = base1*base2.Get(j);
        if elementInfo.type == "simplex"
            M(:,j) = p.IntegralAverageOnSimplex(elementInfo.nodes, base1.n);
        elseif elementInfo.type == "cube"
            M(:,j) = p.IntegralOnCube(elementInfo.nodes, base1.n);
        end
    end
end
if elementInfo.type == "simplex" || isNumerical
    M = M*elementInfo.volume;
end
end