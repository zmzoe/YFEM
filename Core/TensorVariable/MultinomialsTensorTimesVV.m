function p = MultinomialsTensorTimesVV(multinomialsCell, v1)
% v1'* multinomialsCell
f = multinomialsCell{1};
p = Multinomials(f.n, f.k, f.m, f.type);
n = numel(multinomialsCell);
for i = 1:n
    p = p + multinomialsCell{i}*(v1(i));
end
end

