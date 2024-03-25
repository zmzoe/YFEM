function p = MultinomialsTensorInner(MultinomialsCell1, MultinomialsCell2)
if numel(MultinomialsCell1) ~= numel(MultinomialsCell2)
    error('Tensor size dismatch!');
else
    p = MultinomialsCell1{1} * MultinomialsCell2{1};
    for i=2:numel(MultinomialsCell1)
        p = p + MultinomialsCell1{i} * MultinomialsCell2{i};
    end
end
end