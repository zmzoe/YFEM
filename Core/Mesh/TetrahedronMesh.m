function [elements, nodes] = TetrahedronMesh(N)
[cubes, nodes] = CubeMesh(N);
elements = zeros(6*N*N*N,4);
t = 0;
for k =1:N
    for j = 1:N
        for i = 1:N
            t = t + 1;
            elements(6*(t-1)+1,:)= cubes(t,[1 2 4 8]);
            elements(6*(t-1)+2,:)= cubes(t,[1 3 4 8]);
            elements(6*(t-1)+3,:)= cubes(t,[1 5 6 8]);
            elements(6*(t-1)+4,:)= cubes(t,[1 5 7 8]);
            elements(6*(t-1)+5,:)= cubes(t,[1 2 6 8]);
            elements(6*(t-1)+6,:)= cubes(t,[1 3 7 8]);
        end
    end
end
end
