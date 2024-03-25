function value = GaussianIntegralAverage(fun, nodes, k, type)
%GaussianIntegralAverageOnCube cube上的数值积分
%   fun:    函数表达式或它构成的cell, 该函数需要支持 fun([p1;...;pn]) = [fun(p1);...;fun(pn)]
%   nodes:  cube的顶点坐标
%   k:      代数精度
%
n = size(nodes,2);
switch type
    case 'simplex'
        [gpoints, weights] = GetHammerIntegralInfoOnSimplex(n, k);
        points = AffineTransformForHammerPoints(gpoints, nodes);
    case 'cube'
        [gpoints, weights] = GetGaussianIntegralInfoOnCube(n, k);
        points = AffineTransformForGaussianPoints(gpoints, nodes);
end
value = BaseNumericalIntegral(fun, points, weights);
end