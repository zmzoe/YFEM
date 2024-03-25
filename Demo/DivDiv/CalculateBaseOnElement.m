function [sigmaBase, sigmaDivDivBase, uBase, Dof] = CalculateBaseOnElement(elementInfo, FEM3dP3BaseLambda, FEM3dP1BaseLambda, symmetricTensorBase, referenceDofNum)
nDim = 3;
%% 笛卡尔坐标下基函数
% lambda
lambdaTox = BarycentricToCartesian(elementInfo);
lambdaToxCell = cell(nDim+1,1);
for i = 1:nDim+1
    lambdaToxCell{i,1} = lambdaTox.Get(i);
end

uBase = FEM3dP1BaseLambda.Substitute(lambdaTox);

FEM3dP3Base = FEM3dP3BaseLambda.Substitute(lambdaTox);
dFEM3dP3Base = cell(nDim,1);
for i = 1:3
    dFEM3dP3Base{i,1} = FEM3dP3Base.Derivate(i);
end

ddFEM3dP3Base = cell(nchoosek(nDim,2),1);
for i = 1:3
    for j=1:i
        ddFEM3dP3Base{i*(i-1)/2+j, 1} = dFEM3dP3Base{i,1}.Derivate(j);
    end
end

% %% 导数
FEMBase = cell(3,3);
divFEMBase = cell(3,1);
divDivFEMBase =  Multinomials(nDim, 1, referenceDofNum);
indMatrix = [1 2 4; 2 3 5; 4 5 6];
for i1=1:3
    for j1=1:3
        FEMBase{i1,j1} = Multinomials(nDim, 3, referenceDofNum);
        for i = 1:6
            A = FEM3dP3Base*symmetricTensorBase(i1,j1,i);
            FEMBase{i1,j1}.CopyFromMultinomials(A, 'rowInd', 20*(i-1)+1:20*i);          
        end
    end
    divFEMBase{i1, 1} = Multinomials(nDim, 2, referenceDofNum);
    for i = 1:6
        A =  dFEM3dP3Base{1,1}*symmetricTensorBase(i1,1,i);
        for j1 = 2:3
            A = A + dFEM3dP3Base{j1,1}*symmetricTensorBase(i1,j1,i);
        end
        divFEMBase{i1, 1}.CopyFromMultinomials(A, 'rowInd', 20*(i-1)+1:20*i);
    end
end
for i = 1:6
    A =  Multinomials(nDim, 1, 20);
    for i1=1:3
        for j1=1:3
            A = A + ddFEM3dP3Base{indMatrix(i1,j1)}*symmetricTensorBase(i1,j1,i);
        end
    end
    divDivFEMBase.coefficient(20*(i-1)+1:20*i, :) = A.coefficient;
end

%% 自由度
Dof = CreateFEMDof(elementInfo, lambdaToxCell, referenceDofNum);

%%
M = CalculateDofValueOnBase(Dof,FEMBase,divFEMBase,elementInfo);

%% 真实的基
sigmaBase = cell(nDim, nDim);
% realDivBase = sym(zeros(3, dofNum));
sigmaDivDivBase = divDivFEMBase.SolveBase(M);
for i = 1:nDim
    for j = 1:nDim
        sigmaBase{i,j} = FEMBase{i,j}.SolveBase(M);
    end
end

end

