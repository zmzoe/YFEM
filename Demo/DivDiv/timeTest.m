% i = 1;
% testA1 = CreateStiffnessMatrixTensor(sigmaBase{i,1}, sigmaBase{i,1}, elementInfo{i,1});
[LHS, RHS] = CreateStiffnessMatrixOnMesh(A, B, C, elementToDof, elementToDofu);