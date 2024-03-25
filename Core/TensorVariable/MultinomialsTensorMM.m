function p = MultinomialsTensorMM(MultinomialsCell1, MultinomialsCell2)
%multinomials Matrix * multinomials Matrix(or numeric matrix)
[a1,b1] = size(MultinomialsCell1);[a2,b2] = size(MultinomialsCell2);
if b1 ~= a2
    error('Tensor size dismatch!');
else
    p = cell(a1,b2);
    if isnumeric(MultinomialsCell2)
        for i = 1:a1
            for j = 1:b2
                p{i,j} = MultinomialsCell1{i,1}*MultinomialsCell2(1,j);
                for k = 2:b1
                    p{i,j} = p{i,j} + MultinomialsCell1{i,k}*MultinomialsCell2(k,j);
                end
            end
        end
    else
        for i = 1:a1
            for j = 1:b2
                p{i,j} = MultinomialsCell1{i,1}*MultinomialsCell2{1,j};
                for k = 2:b1
                    p{i,j} = p{i,j} + MultinomialsCell1{i,k}*MultinomialsCell2{k,j};
                end
            end
        end
    end
end

end


