function dofExpression = CreateFEMDof(elementInfo, lambdaToxCell, referanceDofNum)
dofExpression = cell(referanceDofNum, 1);

%% nodes
id = [1,1;1,2;2,2;1,3;2,3;3,3];
for i = 1:4
    for j = 1:6
        dofExpression{6*(i-1)+j,1} = eval(sprintf("@(fun) fun{%d, %d}.Evaluation(elementInfo.nodes(i,:));", id(j,1), id(j,2)));
    end
end

%% edges
id = [1,2;1,3;2,2;2,3;3,3];
for i = 1:6
    for j = 1:5
        for k = 1:2
            dofExpression{24+10*(i-1)+2*(j-1)+k,1} = eval(sprintf("@(fun) elementInfo.edgeLength(%d)*MultinomialsIntegralAverageOnSimplex(MultinomialsTensorTimesVMV(fun, elementInfo.edgesTNN(%d,:,%d), elementInfo.edgesTNN(%d,:,%d))*lambdaToxCell{%d}, elementInfo.nodes(elementInfo.edgeId(%d,:),:), 1)",i, i, id(j,1), i,id(j,2),elementInfo.edgeId(i,k), i));
        end
    end
end
% 
%% face
w = eye(3);
for i = 1:4
    for j = 1:3
        dofExpression{84+3*(i-1)+j,1} = eval(sprintf("@(fun) elementInfo.faceArea(%d)*MultinomialsIntegralAverageOnSimplex(MultinomialsTensorTimesVMV(fun, elementInfo.faceNormal(%d,:), w(%d,:)), elementInfo.nodes(elementInfo.faceId(%d,:),:), 2)",i, i, j, i));
    end
end
id = [1 2;1 3;2 3];
for i = 1:4
    for j = 1:3
        dofExpression{96+6*(i-1)+j,1} = eval(sprintf("@(fun) elementInfo.faceArea(%d)*MultinomialsIntegralAverageOnSimplex(MultinomialsTensorTimesVV(fun, elementInfo.faceNormal(%d,:))*lambdaToxCell{%d}, elementInfo.nodes(elementInfo.faceId(%d,:),:),2)",i, i, elementInfo.faceId(i,j), i));
    end
    for j = 1:3
        dofExpression{96+6*(i-1)+3+j,1} = eval(sprintf("@(fun) elementInfo.faceArea(%d)*MultinomialsIntegralAverageOnSimplex(MultinomialsTensorTimesVV(fun, elementInfo.faceNormal(%d,:))*(lambdaToxCell{%d}*lambdaToxCell{%d}), elementInfo.nodes(elementInfo.faceId(%d,:),:),2)",i, i, elementInfo.faceId(i,id(j,1)), elementInfo.faceId(i,id(j,2)), i));
    end
end
end
