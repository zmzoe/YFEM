function value = BaseNumericalIntegral(fun, points, weights)
%NUMERICALINTEGRAL 计算[-1,1]^n区域上的数值积分平均值
%   fun:        函数表达式, 该函数需要支持 fun([p1;...;pn]) = [fun(p1);...;fun(pn)]
%   points:     积分点
%   weights:    积分点权重, 满足sum(weights) = 1, 支持有多组 weights, 一列对应一组
if iscell(fun)
    value = cell(size(fun));
    for i = 1:numel(fun)
        value{i} = weights'*fun{i}(points);
    end
else
    value = weights'*fun(points);
end
end

