function p = MultinomialsTensorInnerForMatrix(MultinomialsCell1, m1)
if numel(MultinomialsCell1) ~= numel(m1)
    error('Tensor size dismatch!');
else
    p = MultinomialsCell1{1} * m1(1);
    for i=2:numel(MultinomialsCell1)
        p = p + MultinomialsCell1{i} * m1(i);
    end
end
end