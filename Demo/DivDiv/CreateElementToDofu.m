function [elementToDofu, dofNumu] = CreateElementToDofu(elementList)
N = round(power(size(elementList,1)/6,1/3));
elementNum = 6*N^3;
dofNumu = 4*elementNum;
elementToDofu = zeros(elementNum, 4);
for e = 1:elementNum
    % nodes
    for i = 1:4
            elementToDofu(e, i) = i + (e-1)*4;
    end
end
end

