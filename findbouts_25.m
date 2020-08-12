
% you provide the array of velocities before the egg laying event
function bouts = findbouts_25(veldata)

swin = 18*25+1;
swinhalf = 9*25;
bouts = 1;


veldata_smooth = nanfastsmooth(veldata,swin,1,1)';
[a b] = find(veldata_smooth(1:1:end-swinhalf) < .1, 1, 'last');
bouts = a;
if(isempty(bouts))
    bouts = 1;
end
end
