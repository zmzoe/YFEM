function [elementList, nodeList, elementMap] = DeleteMesh(elementList, nodeList, MarkedElement)
%   MarkedElement 会被删去从网格中删去，然后删去没有用到的 node，最后重新编号
elementList(MarkedElement, :) = [];
validNode = false(size(nodeList, 1), 1);
validNode(elementList(:)) = true;
validNodeNum = sum(validNode);
indMap = 1:size(nodeList, 1);
indMap(validNode) = 1:validNodeNum;
nodeList = nodeList(validNode, :);
elementList = indMap(elementList);
elementMap = cumsum(~MarkedElement) .* (~MarkedElement);
end

