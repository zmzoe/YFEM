function [ndQkBase, ndQkDof] = NdQkElement(n, k)
% n维下Qk元的基
baseNum = (k+1)^n;
baseFaceCoefficient = zeros(n*(k+1), n+1);
baseFaceFactor = cell(n*k,1);
for i = 1:n*k
    degree = zeros(n,1);
    degree(ceil(i/k)) = 1;
    baseFaceFactor{i} = Multinomials(n, degree, baseNum, 'Q');
end
ndQkBase = 1;
ndQkDof = cell(baseNum,1);
for i = 1:n
    baseFaceCoefficient(1 + (i-1)*(k+1): i*(k+1), i+1) = 1;
    baseFaceCoefficient(1 + (i-1)*(k+1): i*(k+1), 1) = -(-1:2/k:1)';
end
inds = CubeGrid(zeros(1, n), k*ones(1, n));
indValues = 2*inds/k-1;
for i = 1:baseNum
    q = 0;
    for j = 1:n
        for l = 0:k
            if l~=inds(i,j)
                q = q+1;
                baseFaceFactor{q}.coefficient(i,1:4) = baseFaceCoefficient((j-1)*(k+1) +l+1,:);
            end
        end
    end
    ndQkDof{i} = @(fun) fun.Evaluation(indValues(i,:));
end
for i = 1:n*k
    ndQkBase = ndQkBase *baseFaceFactor{i};
end
factor = zeros(baseNum, 1);
for i=1:baseNum
    factor(i) = ndQkBase.Evaluation(indValues(i,:),i);
end
ndQkBase = ndQkBase/factor;
end

