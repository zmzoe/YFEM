function [newElements, newNodes] = SplitFunc2dTriangle(nodes, varargin)
allinds = find(varargin{1});
inds = [3 1 2;2 1 3;1 2 3];
maxEdgeInd = FindMaxEdge(nodes);

if numel(allinds) == 1
    [newElements, newNodes] = SplitMaxEdge(nodes, inds, maxEdgeInd);
elseif numel(allinds) == 3
    [newElements, newNodes] = SplitAllEdge(nodes, inds, maxEdgeInd);
else
    [newElements, newNodes] = SplitTwoEdge(nodes, inds, maxEdgeInd, setdiff(allinds, maxEdgeInd));
end
end

function [newElements, newNodes] = SplitMaxEdge(nodes, inds, maxEdgeInd)
        j = inds(maxEdgeInd, 1);
        k1 = inds(maxEdgeInd, 2);
        k2 = inds(maxEdgeInd, 3);
        newElements = sort([j k1 4;j k2 4], 2);
        newNodes = [nodes; (nodes(k1, :) + nodes(k2, :))*0.5];
end

function [newElements, newNodes] = SplitAllEdge(nodes, inds, maxEdgeInd)
        j = inds(maxEdgeInd, 1);
        k1 = inds(maxEdgeInd, 2);
        k2 = inds(maxEdgeInd, 3);
        newElements = sort([j 4 5;j 4 6;k1 4 5;k2 4 6], 2);
        newNodes = [nodes; (nodes(k1, :) + nodes(k2, :))*0.5; (nodes(j, :) + nodes(k1, :))*0.5; (nodes(k2, :) + nodes(j, :))*0.5];
end

function [newElements, newNodes] = SplitTwoEdge(nodes, inds, maxEdgeInd, edgeInd)
j = inds(maxEdgeInd, 1);
k1 = inds(maxEdgeInd, 2);
k2 = inds(maxEdgeInd, 3);
if inds(edgeInd, 1) == k1
    newElements = sort([j k1 4;j 4 5;k2 4 5], 2);
    newNodes = [nodes; (nodes(k1, :) + nodes(k2, :))*0.5; (nodes(k2, :) + nodes(j, :))*0.5];
else
    newElements = sort([j k2 4;j 4 5;k1 4 5], 2);
    newNodes = [nodes; (nodes(k1, :) + nodes(k2, :))*0.5; (nodes(j, :) + nodes(k1, :))*0.5];
end
end

function ind = FindMaxEdge(nodes)
L = zeros(3, 1);
L(1) = norm(nodes(1, :) - nodes(2, :));
L(2) = norm(nodes(1, :) - nodes(3, :));
L(3) = norm(nodes(2, :) - nodes(3, :));

[~, ind] = max(L);
end
