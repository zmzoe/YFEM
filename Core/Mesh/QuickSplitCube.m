function simplexList = QuickSplitCube(dim)
    if dim == 1
        simplexList = [1 2];
        return
    end
    n = 2^(dim-1);
    baseSimplexNum = factorial(dim-1);
    simplexList = zeros(dim*baseSimplexNum, dim + 1);
    baseSimplex = QuickSplitCube(dim - 1);
    t = 1;
    simplexList(1:dim:end,:) = [ baseSimplex, baseSimplex(:, 1) + n];
    for i = 2:dim
        t = t + 1;
        simplexList(t:dim:end,:) = simplexList(t-1:dim:end,:);
        simplexList(t:dim:end,i-1) = simplexList(t:dim:end,i) + n;
    end
    simplexList = sort(simplexList, 2);
end