classdef GaussianIntegralInfo < handle
    %GaussIntegralInfo [-1,1]上的一维高斯积分的 points 和 weights, 且sum(weights) = 1;
    
    properties(Access = private)
        info = cell(2,1);   % points 和 weights
        legendrePolynomials = cell(2,1);
    end
    
    methods
        function obj = GaussianIntegralInfo()
            obj.legendrePolynomials{1} = [1.5 0 -0.5];
            obj.legendrePolynomials{2} = [2.5 0 -1.5 0];
            obj.info{1} = [-sqrt(3)/3, 0.5;
                            sqrt(3)/3, 0.5];
            obj.info{2} = [-sqrt(15)/5, 5/18;
                                     0,  4/9;
                            sqrt(15)/5, 5/18];
        end
    end
    
    methods(Static)
        function obj = GetInstence()
            persistent ins;
            if isempty(ins)||~isvalid(ins)
                ins = GaussianIntegralInfo();
            end
            obj = ins;
        end
    end

    methods
        function Set(obj, n)
             if n > numel(obj.legendrePolynomials)
                for i = numel(obj.legendrePolynomials)+1:n
                    obj.legendrePolynomials{i} = ((2*i+1)*[obj.legendrePolynomials{i-1} 0] - i*[0 0 obj.legendrePolynomials{i-2}])/(i+1);
                    obj.info{i} = zeros(i+1,2);
                    obj.info{i}(:,1) = sort(roots(obj.legendrePolynomials{i}));
                    integralDegree = (0:1:i)';
                    obj.info{i}(:,2) = ((repmat(obj.info{i}(:,1)', i+1, 1).^repmat(integralDegree, 1, i+1))\(((1+(-1).^integralDegree))./(1+integralDegree)))*0.5;
                end
            end
        end
        function [points, weights] = GetInfo(obj, k)
            % k:  最低代数精度
            n = max(1, floor((k-1)/2));
            obj.Set(n);
            points = obj.info{n}(:,1);
            weights = obj.info{n}(:,2);
        end
    end
end

