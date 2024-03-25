function K = CreateSkewSymmetricTensorBase()
K = zeros(3,3,3);
K(2,1,1) = 1;
K(1,2,1) = -1;
K(3,1,2) = 1;
K(1,3,2) = -1;
K(3,2,3) = 1;
K(2,3,3) = -1;
end

