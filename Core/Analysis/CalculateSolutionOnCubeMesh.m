function y = CalculateSolutionOnCubeMesh(x, gridN, h, lower, uh, variableFemBase, elementToDof, varargin)
    dim = size(x,2);
    if numel(gridN)==1
        gridN = gridN*ones(1, dim);
    end
    if numel(h)==1
        h = h*ones(1, dim);
    end
    if numel(lower)==1
        lower = lower*ones(1, dim);
    end
    id = ceil((x-lower).*gridN) + (x==lower);
    elementId = ((id(3)-1)*gridN(3) + (id(2)-1))*gridN(2)+id(1);
    if nargin == 7
        rx = x-(id-1).*h;
    elseif nargin == 9
        rh = varargin{1}-varargin{2};
        rx = varargin{2} + rh.*((x-(id-1).*h)./h);
    else
        error("input error");
    end
    
    variableNum = size(variableFemBase, 1);
    y = zeros(variableNum, 1);
    elementToDof_ = elementToDof(elementId, :);
    for i = 1:variableNum
        t = 0;
        for j = 1:numel(variableFemBase{i})
            elementToDof__ = elementToDof_(t+(1:variableFemBase{i}{j}.m));
            y(i) = y(i)+ uh(elementToDof__)'*variableFemBase{i}{j}.Evaluation(rx);
            t = t + variableFemBase{i}{j}.m;
        end
    end
    
end

