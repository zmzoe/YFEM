function [simplexList, nodeList] = SimplexMesh(cubeList, nodeList, splitMethod, elementType)
%%SimplexMesh 基于矩形网格剖分产生单纯形网格
dim = size(nodeList, 2);
cubeNum = size(cubeList, 1);
nodeNum = size(nodeList, 1);
simplexList = cell(cubeNum, 1);
newNodeList = cell(cubeNum, 1);
cumsumSimplexNum = zeros(cubeNum+1, 1);
cumsumNodeNum = zeros(cubeNum+1, 1);
cumsumNodeNum(1) = nodeNum;
if exist('elementType', 'var')
    if numel(elementType) == 1
        elementType = ones(cubeNum, 1)*elementType;
    elseif numel(elementType)~=cubeNum
        error("The size of elementType dismatch!");
    end
else
    elementType = zeros(cubeNum, 1);
end
for i = 1:cubeNum
    [simplexList{i}, newNodeList{i}, cumsumNodeNum(i+1)] = splitMethod(cubeList(i,:), cumsumNodeNum(i), elementType(i));
    cumsumSimplexNum(i+1) = cumsumSimplexNum(i) + size(simplexList{i}, 1);
end
totalSimplexList = zeros(cumsumSimplexNum(end), dim + 1);
totalNodeList = zeros(cumsumNodeNum(end), dim);
totalNodeList(1:nodeNum,:) = nodeList;
for i = 1:cubeNum
    totalSimplexList( cumsumSimplexNum(i)+1: cumsumSimplexNum(i+1), : ) = simplexList{i};
    totalNodeList( cumsumNodeNum(i)+1:cumsumNodeNum(i+1) ) = newNodeList{i};
end
[nodeList, ia] = unique(totalNodeList(:,end:-1:1), "rows");
nodeList = nodeList(:,end:-1:1);
simplexList = ia(totalSimplexList);
end

