function  p = MultinomialsVectorCurl(multinomialsCell)
n = length(multinomialsCell);
p = cell(n, 1);
if n==3
p{1} = multinomialsCell{3}.Derivate(2) - multinomialsCell{2}.Derivate(3);
p{2} = multinomialsCell{1}.Derivate(3) - multinomialsCell{3}.Derivate(1);
p{3} = multinomialsCell{2}.Derivate(1) - multinomialsCell{1}.Derivate(2);
elseif n==2
    
else
    error("n must be 2 or 3!");
end

end

