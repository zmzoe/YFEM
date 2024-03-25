function p = MultinomialsTensorCrossProductVM(multinomialsCell, m1)
% multinomialsCellVector times m1Matrix(multinomials or numeric matrix)
p = cell(3,3);
if isnumeric(m1)
    for i = 1:3
        p{i,1} = multinomialsCell{2}*m1(i,3)-multinomialsCell{3}*m1(i,2);
        p{i,2} = multinomialsCell{3}*m1(i,1)-multinomialsCell{1}*m1(i,3);
        p{i,3} = multinomialsCell{1}*m1(i,2)-multinomialsCell{2}*m1(i,1);
    end
else
    for i = 1:3
        p{i,1} = multinomialsCell{2}*m1{i,3}-multinomialsCell{3}*m1{i,2};
        p{i,2} = multinomialsCell{3}*m1{i,1}-multinomialsCell{1}*m1{i,3};
        p{i,3} = multinomialsCell{1}*m1{i,2}-multinomialsCell{2}*m1{i,1};
    end
end
end

