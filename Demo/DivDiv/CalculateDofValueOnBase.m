function M = CalculateDofValueOnBase(Dof, FEMBase, divFEMBase,elementInfo)
referenceDofNum = FEMBase{1,1}.m;
M = zeros(referenceDofNum);
for i = 1:96
        M(:, i) = Dof{i,1}(FEMBase);
end
for i = 97:referenceDofNum
        M(:, i) = Dof{i,1}(divFEMBase);
end
end

