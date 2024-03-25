function  p = MultinomialsTensorSymCurl(multinomialsCell)
% symcurl(multinomialsCell)
m = size(multinomialsCell, 1);
n = size(multinomialsCell, 2);
p = cell(m, n);
if m==3&&n==3
        p{1,1} = multinomialsCell{1,3}.Derivate(2) - multinomialsCell{1,2}.Derivate(3);
        p{1,2} = 0.5*(multinomialsCell{1,1}.Derivate(3) - multinomialsCell{1,3}.Derivate(1) + multinomialsCell{2,3}.Derivate(2) - multinomialsCell{2,2}.Derivate(3));
        p{1,3} = 0.5*(multinomialsCell{1,2}.Derivate(1) - multinomialsCell{1,1}.Derivate(2) + multinomialsCell{3,3}.Derivate(2) - multinomialsCell{3,2}.Derivate(3));
        p{2,1} = p{1,2};
        p{2,2} = multinomialsCell{2,1}.Derivate(3) - multinomialsCell{2,3}.Derivate(1);
        p{2,3} = 0.5*(multinomialsCell{2,2}.Derivate(1) - multinomialsCell{2,1}.Derivate(2) + multinomialsCell{3,1}.Derivate(3) - multinomialsCell{3,3}.Derivate(1));
        p{3,1} = p{1,3};
        p{3,2} = p{2,3};
        p{3,3} = multinomialsCell{3,2}.Derivate(1) - multinomialsCell{3,1}.Derivate(2);
elseif n==2
    
else
    error("need m==n and n must be 2 or 3!");
end

end

