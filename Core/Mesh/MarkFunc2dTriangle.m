function [elementSplitType] = MarkFunc2dTriangle(treeMesh, markedElementInd)

[elementList, nodeList] = treeMesh.OutputMesh();
elementSplitType = false(size(markedElementInd, 1), 3);
[elementToEdge, edgeList] = CreateGeometricObject(elementList, 2, 'simplex', 1);

edgeToElement = GeometricObjectToElement(elementToEdge, size(edgeList, 1));
for i = 1:size(markedElementInd)
    if markedElementInd(i)
        elementInd = i;
        while true
            ind = FindMaxEdge(nodeList(elementList(elementInd, :), :));
            elementSplitType(elementInd, ind) = true;
            edgeInd = elementToEdge(elementInd, ind);
            elements = edgeToElement{edgeInd};
            newElement = setdiff(elements, elementInd);
            if isempty(newElement)
                break;
            end
            maxEdgeInd = FindMaxEdge(nodeList(elementList(newElement, :), :));
            elementSplitType(newElement, maxEdgeInd) = true;
            if edgeInd == elementToEdge(newElement, maxEdgeInd)
                break;
            else
                indi = FindEdge(elementList(newElement, :), edgeList(edgeInd, :));
                elementSplitType(newElement, indi) = true;
                elementInd = newElement;
            end
        end
    end
end

end

function ind = FindEdge(element, edge)
if element(1) == edge(1)
    if element(2) == edge(2)
        ind = 1;
    else
        ind = 2;
    end
else
    ind = 3;
end
end

function ind = FindMaxEdge(nodes)
L = zeros(3, 1);
L(1) = norm(nodes(1, :) - nodes(2, :));
L(2) = norm(nodes(1, :) - nodes(3, :));
L(3) = norm(nodes(2, :) - nodes(3, :));

[~, ind] = max(L);
end

