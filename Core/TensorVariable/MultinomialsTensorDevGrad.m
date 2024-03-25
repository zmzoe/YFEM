function  p = MultinomialsTensorDevGrad(multinomialsCell)
% grad(multinomialsCell)
n = length(multinomialsCell); % vector length
variableNum = multinomialsCell{1}.n;  %Number of unknown variables(x y z)
p = cell(n,variableNum);
for i = 1:n
    for j = 1:variableNum
        p{i,j} = multinomialsCell{i}.Derivate(j);
    end
end
y = p{1,1};
for i = 2:n
    y = y+p{i,i};
end
y = y/variableNum;

for i = 1:n
    p{i,i} = p{i,i} - y;
end
end