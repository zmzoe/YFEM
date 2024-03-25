function [elementToDof, dofNum] = CreateElementToDof(elementList, edgeNum, faceNum, elementToEdge, elementToFace)
N = round(power(size(elementList,1)/6,1/3));
nodeNum = (N+1)^3;
elementNum = 6*N^3;
dofNum = 6*nodeNum+10*edgeNum+9*faceNum;
elementToDof = zeros(elementNum, 120);
for e = 1:elementNum
    % nodes
    for i = 1:4
        for j = 1:6
            elementToDof(e, 6*(i-1)+j) = elementList(e,i)+(j-1)*nodeNum;
        end
    end
    T = 6*nodeNum;
    % edges
    for i = 1:6
        for j = 1:5
            for k = 1:2
                elementToDof(e, 24+10*(i-1)+2*(j-1)+k) = elementToEdge(e, i)+(2*(j-1)+(k-1))*edgeNum+T;
            end
        end
    end
    T = T + 10*edgeNum;
    % faces
    for i = 1:4
        for j = 1:3
            elementToDof(e, 84+3*(i-1)+j) = elementToFace(e,i) + (j-1)*faceNum + T;
        end
    end
    T = T + 3*faceNum;
    for i = 1:4
        for j = 1:3
            elementToDof(e, 96+6*(i-1)+j) = elementToFace(e,i) + (j-1)*faceNum + T;
        end
        for j = 1:3
            elementToDof(e, 96+6*(i-1)+3+j) = elementToFace(e,i) + (j+2)*faceNum + T;
        end
    end
end
end

