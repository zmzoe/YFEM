function [geometricObjectToElement] = GeometricObjectToElement(elementToGeometricObject, geometricObjectNum)
geometricObjectToElement = cell(geometricObjectNum, 2);
for i = 1:size(elementToGeometricObject, 1)
    for j = 1:size(elementToGeometricObject, 2)
        geometricObjectInd = elementToGeometricObject(i,j);
        geometricObjectToElement{geometricObjectInd, 1} = [geometricObjectToElement{geometricObjectInd, 1}, i];
        geometricObjectToElement{geometricObjectInd, 2} = [geometricObjectToElement{geometricObjectInd, 2}, j];
    end
end
end

