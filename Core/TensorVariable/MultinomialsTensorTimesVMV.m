function p = MultinomialsTensorTimesVMV(multinomialsCell, v1, v2)
% v1'* multinomialsCell*v2
f = multinomialsCell{1};
p = Multinomials(f.n, f.k, f.m);
[n1, n2] = size(multinomialsCell);
for i = 1:n1
    for j= 1:n2
        p = p + multinomialsCell{i,j}*(v1(i)*v2(j));
    end
end
end

