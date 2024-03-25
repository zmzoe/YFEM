function [elementCenter] = ElementCenter(elementList, NodeList)
nodes = zeros([size(elementList, 1), size(NodeList, 2), size(elementList, 2)]);
for i = 1:size(nodes, 3)
    nodes(:, :, i) = NodeList(elementList(:, i), :);
end
elementCenter = mean(nodes, 3);
end

