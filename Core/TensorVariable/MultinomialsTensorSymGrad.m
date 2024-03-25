function p = MultinomialsTensorSymGrad(multinomialsCell)
% 
n = length(multinomialsCell);
p = cell(n,n);
for i = 1:n
    p{i,i} = multinomialsCell{i}.Derivate(i);
    for j = i+1:n
        p{i,j} = 0.5*(multinomialsCell{i}.Derivate(j) + multinomialsCell{j}.Derivate(i));
        p{j,i} = p{i,j};
    end
end

