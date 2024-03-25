function p = MultinomialsTensorTimesSV(multinomialsScalar, m1)
% scalarmultinomials * constantCell
p = cell(size(m1));
for i = 1:numel(m1)
    p{i} = multinomialsScalar*m1(i);
end
end
