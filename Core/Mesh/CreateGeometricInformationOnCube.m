function Info = CreateGeometricInformationOnCube(element, nodeList)
gooe = GeometricObjectOnElement.GetInstence();
dim = size(nodeList,2);

%% element
Info.element = element;
Info.type = 'cube';
gooe.Set(dim, Info.type);
%% nodes
Info.nodes = nodeList(element,:);
Info.bottom = min(Info.nodes);
Info.top = max(Info.nodes);
Info.h = Info.top-Info.bottom;
%% edges
Info.edgeId = gooe.Get(dim, Info.type, 1);
Info.edge = sort(element(Info.edgeId), 2);
Info.edgeTangential = nodeList(Info.edge(:,2), :) - nodeList(Info.edge(:,1), :);
Info.edgeLength = sqrt(sum(Info.edgeTangential.*Info.edgeTangential, 2));
Info.edgeTangential = Info.edgeTangential./Info.edgeLength;

edgeNum = size(Info.edgeId, 1);
Info.edgesTNN = zeros(edgeNum, dim, dim);
for e = 1:edgeNum
    normal = null(Info.edgeTangential(e,:));
    for i=1:dim-1
        Info.edgesTNN(e,:,i+1) = normal(:,i);
    end
end
Info.edgesTNN(:,:,1) = Info.edgeTangential;

Info.edgeParallelToAxis = zeros(3,4);
ind = [0,0,0];

indices = [2,3;1,3;1,2];
for i = 1:12
    for j = 1:3
        if Info.edgeTangential(i,indices(j,1))==0 &&  Info.edgeTangential(i,indices(j,2))==0 
        ind(j) = ind(j)+1;
        Info.edgeParallelToAxis(j,ind(j)) = i;
        end
    end
end

Info.edgeVariable = zeros(12,1);
for i = 1:12
    Info.edgeVariable(i,1) = find(Info.edgeTangential(i,:)~=0);% ei这条边所涉及到的变量 比如e1如果与x轴平行，那它涉及x 
end

%% faces
Info.faceId = gooe.Get(dim, Info.type, 2);
Info.face = sort(element(Info.faceId),2);
faceNum = size(Info.faceId, 1);
Info.faceArea = zeros(faceNum, 1);
Info.faceNormal = zeros(faceNum, 3);
Info.faceTangential1 = zeros(faceNum, 3);
Info.faceTangential2 = zeros(faceNum, 3);
Info.faceVariable = zeros(faceNum, 2);Info.facePerpVariable = zeros(faceNum, 1);
for f = 1:size(Info.faceId,1)
    faceNodes = nodeList(Info.face(f, :), :);
    Info.faceTangential1(f,:) = faceNodes(2,:) - faceNodes(1,:);
    Info.faceTangential2(f,:) = faceNodes(3,:) - faceNodes(1,:);
    dx = max(faceNodes)-min(faceNodes);
    ind = 1:dim;
    Info.faceVariable(f,:) = ind(dx~=0); Info.facePerpVariable(f,:) = ind(dx==0);
    Info.faceArea(f) = prod(dx(dx~=0));
    Info.faceTangential1(f,:) = Info.faceTangential1(f,:)/norm(Info.faceTangential1(f,:));
    Info.faceTangential2(f,:) = Info.faceTangential2(f,:) - dot(Info.faceTangential1(f,:), Info.faceTangential2(f,:))*Info.faceTangential1(f,:);
    Info.faceTangential2(f,:) = Info.faceTangential2(f,:)/norm(Info.faceTangential2(f,:));
    Info.faceNormal(f,:) = cross(Info.faceTangential1(f,:), Info.faceTangential2(f,:));
end
Info.facesNTT = zeros(6,dim,dim);
Info.facesNTT(:,:,1) = Info.faceNormal;
Info.facesNTT(:,:,2) = Info.faceTangential1;
Info.facesNTT(:,:,3) = Info.faceTangential2;


Info.facePerpendicularToAxis = zeros(3,2);
indF = [0,0,0];

indicesF = [2,3;1,3;1,2];
for i = 1:6
    for j = 1:3
        if Info.faceNormal(i,indicesF(j,1))==0 &&  Info.faceNormal(i,indicesF(j,2))==0 
        indF(j) = indF(j)+1;
        Info.facePerpendicularToAxis(j,indF(j)) = i;
        end
    end
end


%% volume
Info.volume = prod(Info.h);
end

