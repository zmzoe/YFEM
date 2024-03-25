function  p = MultinomialsTensorDiv(multinomialsCell)
% div(multinomialsCell)
n = length(multinomialsCell);
p = multinomialsCell{1}.Derivate(1);
for i = 2:n
    p = p + multinomialsCell{i}.Derivate(i);
end
end