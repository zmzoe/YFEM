function Info = CreateGeometricInfo(element, nodeList, type, level)
%CREATEGEOMETRICINFO 计算单元的几何信息, 随着 level 提高信息更加丰富
%   element:    单元顶点编号
%   nodeList:   顶点坐标
%   type:       'cube' 或 'simplex'
%   level:      0:  只有单元的顶点和测度   
%               1:  单元及其所有子几何体的顶点、测度、切向、法向
Info.element = element;
Info.type = type;
Info.nodes = nodeList(element, :);
Info.n = size(nodeList, 2);  %   空间维度
switch type
    case 'simplex'
        Info.d = size(element, 2) - 1;
        vectors = Info.nodes(2:end, :) - Info.nodes(1,:);
        Info.measure = SimplexMeasure(vectors);
    case 'cube'
        Info.d = log(size(element, 2))/log(2);
        Info.bottom = min(Info.nodes);
        Info.top = max(Info.nodes);
        Info.h = Info.top-Info.bottom;
        Info.measure = prod(Info.h);
        E = eye(Info.n);
end
d = Info.d;
ind = 1:Info.n;
if level>0
    gooe = GeometricObjectOnElement.GetInstence();
    gooe.Set(d, Info.type);
    Info.geometricObjectId = cell(d,1);
    Info.geometricObject = cell(d,1);
    Info.geometricObjectMeasure = cell(d,1);
    Info.geometricObjectVariable = cell(d,1);
    Info.geometricObjectTN = cell(d,1); % 切向与法相 
    for i = 1:d
        Info.geometricObjectId{i} = gooe.Get(d, Info.type, i);
        Info.geometricObject{i} = sort(element(Info.geometricObjectId{i}), 2);
        geometricObjectNum = size(Info.geometricObject{i},1);
        Info.geometricObjectMeasure{i} = zeros(geometricObjectNum,1);
        Info.geometricObjectTN{i} = zeros(geometricObjectNum, Info.n, Info.n);
        for j = 1:geometricObjectNum
            nodes = nodeList(Info.geometricObject{i}(j, :), :);
            switch type
                case 'simplex'
                    vectors = nodes(2:end,:) - nodes(1,:);
                    Info.geometricObjectVariable{i} = Info.geometricObjectId{i};    %重心坐标下
                    Info.geometricObjectMeasure{i}(j) =  SimplexMeasure(vectors);
                    gd = size(vectors, 1);
                    Info.geometricObjectTN{i}(j, :, 1:gd) = orth(vectors');
                    Info.geometricObjectTN{i}(j, :, gd+1:end) = null(vectors);
                case 'cube'
                    dh = max(nodes) - min(nodes);
                    var = (dh~=0);
                    gd = sum(var);
                    Info.geometricObjectVariable{i} = ind(var);                   %笛卡尔坐标下
                    Info.geometricObjectMeasure{i}(j) = prod(dh(var));
                    Info.geometricObjectTN{i}(j, :, 1:gd) = E(:, var);
                    Info.geometricObjectTN{i}(j, :, gd+1:end) = E(:, ~var);
            end
        end
    end
end
end


