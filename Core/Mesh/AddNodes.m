function [NodeList, newNodesInd] = AddNodes(NodeList, newNodes)
newNodeNum = size(newNodes, 1);
newNodesInd = zeros(newNodeNum, 1);
for i = 1:newNodeNum
    if isinf(newNodes(i, 1))
        continue
    end
    ind = find(all(abs(NodeList - newNodes(i, :))<1e-10, 2));
    if ind~=0
        newNodesInd(i) = ind;
    else
        NodeList = [NodeList; newNodes(i, :)];
        newNodesInd(i) = size(NodeList, 1);
    end
end
end