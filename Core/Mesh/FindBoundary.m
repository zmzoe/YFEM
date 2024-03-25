function isBoundary = FindBoundary(geometricObjectList,isBoundaryNode)
%判断几何体的所有顶点是否都在边界上
%   geometricObjectList:    通过顶点表示的几何体
%   isBoundaryNode:         顶点是否在边界上, 由 FindBoundaryNode() 函数产生
    isBoundary = all(isBoundaryNode(geometricObjectList), 2);
end

