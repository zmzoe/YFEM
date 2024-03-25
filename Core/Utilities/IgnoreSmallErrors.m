function M = IgnoreSmallErrors(M)
M = M.*(abs(M)>1e-10);
M = double(sym(M));
end

