function  p = MultinomialsTensorDivForMatrix(multinomialsCell)
% div(multinomialsCell) for matrix
[nr,nc] = size(multinomialsCell);
p = cell(nr,1);
for i = 1:nr
    p{i,1} = multinomialsCell{i,1}.Derivate(1);
    for j = 2:nc
        p{i,1}  = p{i,1}+ multinomialsCell{i,j}.Derivate(j);
    end
end

end