function T = CreateTracelessTensorBase()
T = zeros(3,3,8);
T(1,1,1) = 1;
T(2,2,1) = -1;
T(1,1,2) = 1;
T(3,3,2) = -1;
T(1,2,3) = 1;
T(1,3,4) = 1;
T(2,1,5) = 1;
T(2,3,6) = 1;
T(3,1,7) = 1;
T(3,2,8) = 1;
end

