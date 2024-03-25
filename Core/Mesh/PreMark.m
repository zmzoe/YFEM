function markedElement = PreMark(elementList, eta, theta, method)
NT = size(elementList, 1);
isMark = false(NT, 1);
if ~exist('method', 'var')
    method = 'L2';
end
switch upper(method)
    case 'MAX'
        isMark(eta > theta * max(eta)) = true;
    case 'COARSEN'
        isMark(eta < theta * max(eta)) = true;
    case 'L2'
        [sortedEta, idx] = sort(eta.^2, 'descend'); 
        x = cumsum(sortedEta);
        isMark(idx(x < theta * x(NT))) = true;
        isMark(idx(1)) = true;
end
markedElement = isMark;
end