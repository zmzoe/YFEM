function p = MultinomialsTensorCrossProductMV(multinomialsCell, v1)
%multinomialsCell times V1vector(vector could be multinomials or numeric matrix)
p = cell(3,3);
if isnumeric(v1)
    for i = 1:3
        p{i,1} = v1(3)*multinomialsCell{i,2}-v1(2)*multinomialsCell{i,3};
        p{i,2} = v1(1)*multinomialsCell{i,3}-v1(3)*multinomialsCell{i,1};
        p{i,3} = v1(2)*multinomialsCell{i,1}-v1(1)*multinomialsCell{i,2};
    end
else
    for i = 1:3
        p{i,1} = v1{3}*multinomialsCell{i,2}-v1{2}*multinomialsCell{i,3};
        p{i,2} = v1{1}*multinomialsCell{i,3}-v1{3}*multinomialsCell{i,1};
        p{i,3} = v1{2}*multinomialsCell{i,1}-v1{1}*multinomialsCell{i,2};
    end
end

end

