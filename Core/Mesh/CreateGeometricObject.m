function [elementToGeometricObject, objectList] = CreateGeometricObject(elementList, n, type, d)
gooe = GeometricObjectOnElement.GetInstence();
gooe.Set(n, type);
ind = gooe.Get(n, type, d);
elementNum = size(elementList,1);
GeometricObjectNum = size(ind, 1);
totalGeometricObject = zeros(elementNum*GeometricObjectNum, size(ind, 2));
for i = 1:size(ind,1)
    totalGeometricObject(elementNum*(i-1)+1:elementNum*i, :) = sort(elementList(:, ind(i,:)), 2);
end
[objectList, ~, ib] = unique(totalGeometricObject,'rows');
elementToGeometricObject = reshape(ib, elementNum, size(ind, 1));
end

