function T = CreateSymmetricTensorBase()
T = zeros(3,3,6);
T(1,1,1) = 1;
T(1,2,2) = 1;
T(2,1,2) = 1;
T(2,2,3) = 1;
T(1,3,4) = 1;
T(3,1,4) = 1;
T(2,3,5) = 1;
T(3,2,5) = 1;
T(3,3,6) = 1;
end

