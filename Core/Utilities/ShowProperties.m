function ShowProperties(obj)
multinomialsPropertiesName = properties(obj);
for i = 1:numel(multinomialsPropertiesName)
    eval(sprintf("help Multinomials.%s", multinomialsPropertiesName{i}))
end
end

