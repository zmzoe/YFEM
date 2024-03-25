classdef HammerIntegralInfo < handle
    %GaussIntegralInfo [-1,1]上的一维高斯积分的 points 和 weights, 且sum(weights) = 1;

    properties%(Access = private)
        info = cell(1);   % points 和 weights
    end

    methods
        function obj = HammerIntegralInfo()
        end
    end

    methods(Static)
        function obj = GetInstence()
            persistent ins;
            if isempty(ins)||~isvalid(ins)
                ins = HammerIntegralInfo();
            end
            obj = ins;
        end
    end

    methods
        function Set(obj, n, k)
            if  n > size(obj.info, 1) || k > size(obj.info, 2) || isempty(obj.info{n, k})
                degree = mp(k);
                points = mp(NonNegativeIntegerSolutionEq(n+1, degree)) / degree;
                points = (points - 1/(n+1)) * 0.9 + 1/(n+1);
                p = Multinomials(n+1, k, nchoosek(n + k, k));
                p.coefficient = mp(eye(p.coefficientNum));
                M = p.Evaluation(points);
                d = mp(n);
                integralFactor = mp(zeros(p.coefficientNum, 1));
                exponents = mp(p.GetExpeonents());
                for i = 1:p.coefficientNum
                    e = exponents(i,:);
                    integralFactor(i) = prod(factorial(e))/factorial(sum(e)+d);
                end
                value = (p.coefficient*integralFactor)*factorial(d);
                obj.info{n, k} = mp(zeros(size(points) + [0, 1]));
                obj.info{n, k}(:, 1:n+1) = points;
                obj.info{n, k}(:, end) = M \ value;
            end
        end
        function [points, weights] = GetInfo(obj, n, k)
            % k:  最低代数精度
            if n == 1
                gii = GaussianIntegralInfo.GetInstence();
                [points, weights] = gii.GetInfo(k);
            else
                obj.Set(n, k);
                points = obj.info{n, k}(:, 1:n+1);
                weights = obj.info{n, k}(:, end);
            end
        end
    end
end
