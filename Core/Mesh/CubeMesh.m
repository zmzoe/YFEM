function [cubes, nodes] = CubeMesh(N, varargin)
if nargin == 1
    up = [1 1 1];
    down = [0 0 0];
elseif nargin==2
    up = varargin{1};
    down = [0 0 0];
elseif nargin==3
    up = varargin{1};
    down = varargin{2};
end
h = (up-down)./N;
t = 0;
nodes = zeros((N+1)^3, 3);
cubes = zeros(N^3,8);
for k = 1:N+1
    for j = 1:N+1
        for i = 1:N+1
            t = t+1;
            nodes(t, :) = down + h.*([i,j,k]-1);
        end
    end
end
t = 0;
for k = 1:N
    for j = 1:N
        for i = 1:N
            t = t+1;
            ind = (k-1)*(N+1)*(N+1)+(j-1)*(N+1) + i;
            cubes(t, :) = ind + [0, 1, (N+1), (N+1)+1 , (N+1)*(N+1) ,(N+1)*(N+1)+1, (N+1)*(N+2), (N+1)*(N+2)+1];
        end
    end
end
end

