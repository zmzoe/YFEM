function p = CellSum(Mcell1, Mcell2)
if numel(Mcell1) ~= numel(Mcell2)
    error('Tensor size dismatch!');
else
    p = cell(size(Mcell1));
    for i = 1:size(Mcell1,1)
        for j = 1:size(Mcell1,2)
            p{i,j} = Mcell1{i,j} + Mcell2{i,j};
        end
    end
end
end