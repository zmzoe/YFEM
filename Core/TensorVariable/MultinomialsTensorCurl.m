function  p = MultinomialsTensorCurl(multinomialsCell)
% curl(multinomialsCell)
m = size(multinomialsCell, 1);
n = size(multinomialsCell, 2);
p = cell(m, n);
if n==3
    for i = 1:m
        p{i,1} = multinomialsCell{i,3}.Derivate(2) - multinomialsCell{i,2}.Derivate(3);
        p{i,2} = multinomialsCell{i,1}.Derivate(3) - multinomialsCell{i,3}.Derivate(1);
        p{i,3} = multinomialsCell{i,2}.Derivate(1) - multinomialsCell{i,1}.Derivate(2);
    end
elseif n==2
    
else
    error("n must be 2 or 3!");
end

end

