function p = MultinomialsTensorCross(multinomialsCell, v)
% cross(multinomialsCell, v)
n = length(multinomialsCell);
assert(n==3, "n must be 3!");
p = cell(3,1);
p{1} = v(3)*multinomialsCell{2} - v(2)*multinomialsCell{3};
p{2} = v(1)*multinomialsCell{3} - v(3)*multinomialsCell{1};
p{3} = v(2)*multinomialsCell{1} - v(1)*multinomialsCell{2};
end

