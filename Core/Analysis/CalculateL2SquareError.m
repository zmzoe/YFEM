function [elementError, baseValue, L2uh] = CalculateL2SquareError(uh, femBase, refElementInfo, u, elementList, nodeList, elementToDof, type, k, M )
%CalculateError 计算 u_h-u 的在 elementList 每个单元上的L2误差的平方
%   uh:                 femBase的系数, 用列向量表示
%   femBase:            基函数, 可以是个cell, 真实计算中，矩阵会被拉直成一个向量
%   refElementInfo:     femBase 所在的单元
%   u:                  真解, 和femBase匹配
%   elementList:        Mesh上所有单元
%   nodeList:           Mesh上顶点
%   elementToDof:       单元到全局自由度的映射
%   type:               'simplex' 或 'cube'
%   k:                  可选变量, 数值积分的代数精度
%   M:                  可选变量, femBase的单元刚度矩阵, 您可以从外部导入刚度矩阵避免重复计算, 没有就得重新计算
if ~isvarname('k')
    k = 9;
end
if ~isvarname('M')
    if iscell(femBase)
        M = CreateStiffnessMatrixTensorMul(femBase, femBase, refElementInfo);
    else
        M = CreateStiffnessMatrixMul(femBase, femBase, refElementInfo);
    end
end
elementNum = size(elementList,1);
n = size(nodeList,2);
elementError = zeros(elementNum, 1);
baseValue = zeros(elementNum, 1);
L2uh = zeros(elementNum, 1);
switch type
    case 'simplex'
        [gpoints, weights] = GetHammerIntegralInfoOnSimplex(n, k);
        refPoints = AffineTransformForHammerPoints(gpoints, refElementInfo.nodes);
    case 'cube'
        [gpoints, weights] = GetGaussianIntegralInfoOnCube(n, k);
        refPoints = AffineTransformForGaussianPoints(gpoints, refElementInfo.nodes);
end
if iscell(femBase)
    uhValue = cell(size(femBase));
    for i = 1:numel(femBase)
        uhValue{i} = femBase{i}.Evaluation(refPoints);
    end
else
    uhValue = femBase.Evaluation(refPoints);
end
for e = 1:elementNum
    nodes = nodeList(elementList(e,:),:);
    elementInfo = CreateGeometricInfo(elementList(e,:), nodeList, type, 0);
    uh_e = uh(elementToDof(e,:));
    switch type
        case 'simplex'
            funPoints = AffineTransformForHammerPoints(gpoints, nodes);
        case 'cube'
            funPoints = AffineTransformForGaussianPoints(gpoints, nodes);
    end
    uValue = u(funPoints);
    if iscell(femBase)
        uuhValue = (uh_e'*uhValue{1}.*weights')*uValue(:,1);
        for i = 2:numel(femBase)
            uuhValue  = uuhValue + (uh_e'*uhValue{i}.*weights')*uValue(:,i);
        end
    else
        uuhValue = (uh_e'*uhValue.*weights')*uValue;
    end
    elementError(e) = uh_e'*M*uh_e + (-2*uuhValue + weights'*sum(uValue.^2, 2))*elementInfo.measure;
    baseValue(e) = weights'*sum(uValue.^2, 2)*elementInfo.measure;
    L2uh(e) = uh_e'*M*uh_e;
end
end