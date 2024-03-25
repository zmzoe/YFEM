function [ndPkBase, ndPkDof] = NdPkElement(n, k)
% n维下Pk元的基
baseNum = nchoosek(n+k,n);
baseFaceCoefficient = zeros((n+1)*(k+1), n+2);
baseFaceFactor = cell(k,1);
for i = 1:k
    baseFaceFactor{i} = Multinomials(n+1, 1, baseNum);
end
ndPkBase = 1;
ndPkDof = cell(baseNum,1);
for i = 1:n+1
    baseFaceCoefficient(1 + (i-1)*(k+1): i*(k+1), i+1) = 1;
    baseFaceCoefficient(1 + (i-1)*(k+1): i*(k+1), 1) = -(0:1/mp(k):1)';
end
inds = NonNegativeIntegerSolutionEq(n+1,k);
indValues = mp(inds)/mp(k);
for i = 1:baseNum
    q = 0;
    for j = 1:n+1
        for l = 0:inds(i,j)-1
            q = q+1;
            baseFaceFactor{q}.coefficient(i,:) = baseFaceCoefficient((j-1)*(k+1) +l+1,:);
        end
    end
    ndPkDof{i} = @(fun) fun.Evaluation(indValues(i,:));
end
for i = 1:k
    ndPkBase = ndPkBase *baseFaceFactor{i};
end
factor = zeros(baseNum, 1);
for i=1:baseNum
    factor(i) = ndPkBase.Evaluation(indValues(i,:),i);
end
ndPkBase = ndPkBase / factor;
end

