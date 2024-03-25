function [simplexList, newNodeList, cumsumNodeNum] = SplitCube(cube, cumsumNodeNum, type)
%SPLITCUBE 
dim = round(log(size(cube,2))/log(2));
if dim == 2
    inds = [1 2 4; 1 3 4];
elseif dim == 3
    inds = [1 2 4 8;
            1 3 4 8;
            1 5 6 8;
            1 5 7 8;
            1 2 6 8;
            1 3 7 8];
elseif dim == 1
    inds = [1 2];
else
    error("暂不支持")
end
simplexList = cube(inds);
newNodeList = [];
end

