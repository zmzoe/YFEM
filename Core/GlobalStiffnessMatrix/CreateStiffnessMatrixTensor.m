function M = CreateStiffnessMatrixTensor(base1, base2, elementInfo, isNumerical)
base1DofNum = base1{1}.m;
base2DofNum = base2{1}.m;
M = zeros(base1DofNum, base2DofNum);
if exist("isNumerical", 'var') && isNumerical
    if elementInfo.type == "simplex"
        [gpoints, weights] = GetHammerIntegralInfoOnSimplex(base1{1}.n, 14);
        points = AffineTransformForHammerPoints(gpoints, elementInfo.nodes);
    elseif elementInfo.type == "cube"
        [gpoints, weights] = GetGaussianIntegralInfoOnCube(base1{1}.n, 14);
        points = AffineTransformForGaussianPoints(gpoints, elementInfo.nodes);
    end
    pointsValue1 = cell(size(base1));
    pointsValue2 = cell(size(base2));
    for i = 1:numel(base1)
        pointsValue1{i} = base1{i}.Evaluation(points);
    end
    for i = 1:numel(base2)
        pointsValue2{i} = base2{i}.Evaluation(points);
    end
    for j = 1:base2DofNum
        for i = 1:numel(base1)
            M(:, j) = M(:, j) + sum(pointsValue1{i} .* (pointsValue2{i}(j, :) .* weights'), 2);
        end
    end
else
    for j = 1:base2DofNum
        p = (base1{1})*(base2{1}.Get(j));
        for k = 2:numel(base1)
            p = p + (base1{k})*(base2{k}.Get(j));
        end
        if elementInfo.type == "simplex"
            M(:,j) = p.IntegralAverageOnSimplex(elementInfo.nodes, base1{1}.n);
        elseif elementInfo.type == "cube"
            M(:,j) = p.IntegralOnCube(elementInfo.nodes, base1{1}.n);
        end
    end
end
if elementInfo.type == "simplex" || isNumerical
    M = M*elementInfo.volume;
end
end
