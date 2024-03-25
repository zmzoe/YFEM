function  p = MultinomialsTensorGradForMatrix(multinomialsCell)
% grad(multinomialsCell matrix)
[nr,nc] = size(multinomialsCell); %
variableNum = multinomialsCell{1}.n;  %Number of unknown variables(x y z)
p = cell(nr,nc,variableNum);
for i = 1:nr
    for j = 1:nc
        for k = 1:variableNum
            p{i,j,k} = multinomialsCell{i,j}.Derivate(k);
        end
    end
end
end