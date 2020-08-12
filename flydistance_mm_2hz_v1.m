% fly is the fly number
% startt and endt are in frames
% you will need to take cumsum(dist) to get cumulative distance
function dist = flydistance_mm_2hz_v1(trx,fly,startt,endt)
dist = [];
for i = (startt):1:(endt-13)
    X = trx(1,fly).x_mm(i);
    Y = trx(1,fly).y_mm(i);
    Xn = (trx(1,fly).x_mm(i+12)+trx(1,fly).x_mm(i+13))./2;
    Yn = (trx(1,fly).y_mm(i+12)+trx(1,fly).y_mm(i+13))/.2;
    dist(i-startt+1) = pdist([X Y; Xn Yn],'euclidean');
end

