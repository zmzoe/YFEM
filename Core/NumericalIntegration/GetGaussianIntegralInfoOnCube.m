function [points, weights] = GetGaussianIntegralInfoOnCube(n,k)
%   n:  维度
%   k:  代数精度
    gii = GaussianIntegralInfo.GetInstence();
    [points1d, weights1d] = gii.GetInfo(k);
    inds = CubeGrid(ones(n,1), size(points1d,1));
    points = points1d(inds);
    weights = prod(weights1d(inds),2);
end

