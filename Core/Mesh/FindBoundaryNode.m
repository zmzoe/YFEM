function isBoundaryNode = FindBoundaryNode(NodeList, bf)
%FindBoundaryNode 判断NodeList中每个点是否在边界bf上
%   NodeList:   需要判断的顶点
%   bf:         表示边界的函数, bf(x) = 0 为边界, 满足bf([p1;p2;...;pn]) = [bf(p1);bf(p2);...;bf(pn)]
	isBoundaryNode = abs(bf(NodeList))<1e-7;
end

