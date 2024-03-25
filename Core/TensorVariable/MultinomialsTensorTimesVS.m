function p = MultinomialsTensorTimesVS(multinomialsCell, s1)
% scalar * multinomialsCell
p = cell(size(multinomialsCell));
for i = 1:numel(multinomialsCell)
    p{i} = multinomialsCell{i}*s1;
end

end

