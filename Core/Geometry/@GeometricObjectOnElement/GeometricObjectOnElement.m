classdef GeometricObjectOnElement < handle
    %GeometricObjectOnElement
    
    properties
        simplexGeometricObject = cell(1);
        cubeGeometricObject = cell(1);
        specialGeometricObject;
    end
    
    methods(Access = private)
        function obj = GeometricObjectOnElement()
            obj.specialGeometricObject = containers.Map();
        end
    end
    methods(Static)
        function obj = GetInstence()
            persistent ins;
            if isempty(ins)||~isvalid(ins)
                ins = GeometricObjectOnElement();
            end
            obj = ins;
        end
    end
    methods
        function Set(obj, n, type, varargin)
            switch type 
                case 'simplex'
                    if numel(obj.simplexGeometricObject) < n || isempty(obj.simplexGeometricObject{n})
                        obj.simplexGeometricObject{n} = cell(n,1);
                        for i = 1:n
                            obj.simplexGeometricObject{n}{i,1} = nchoosek(1:(n+1), i+1);
                        end
                    end
                case 'cube'
                    if numel(obj.cubeGeometricObject) < n || isempty(obj.cubeGeometricObject{n})
                        obj.cubeGeometricObject{n} = cell(n,1);
                        for i = 1:n
                            obj.cubeGeometricObject{n}{i,1} = Subcubes(n, i);
                        end
                    end
                case 'special'
                    % 特殊几何体自己定义, varargin{2} 需要是个n*1的cell
                    obj.specialGeometricObject(varargin{1}) = varargin{2};
                otherwise
                    error("Only support type 'simplex', 'cube' and 'special'!");
            end
        end
        
        function geometricObject = Get(obj, n, type, d, varargin)
            switch type 
                case 'simplex'
                    geometricObject = obj.simplexGeometricObject{n}{d};
                case 'cube'
                    geometricObject = obj.cubeGeometricObject{n}{d};
                case 'special'
                     geometricObjectCell = obj.specialGeometricObject(varargin{1});
                     geometricObject = geometricObjectCell{d};
                otherwise
                      error("Only support type 'simplex', 'cube' and 'special'!");
            end
        end
    end
end

