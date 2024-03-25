function  p = MultinomialsScalarGrad(multinomials)
% grad(multinomials)
variableNum = multinomials.n;  %Number of unknown variables(x y z)
p = cell(variableNum, 1);
for j = 1:variableNum
    p{j,1} = multinomials.Derivate(j);
end
end