function measure = SimplexMeasure(vectors)
%SIMPLEXMEASURE 此处显示有关此函数的摘要
%   vectors:    按行存储的向量
[d, n] = size(vectors);
if d == 1
    measure = norm(vectors);
else
    ind = nchoosek(1:n, d);
    measure = 0;
    for i = 1:size(ind,1)
        measure = measure + det(vectors(:, ind(i,:)))^2;
    end
    measure = sqrt(measure)/factorial(d);
end
end
