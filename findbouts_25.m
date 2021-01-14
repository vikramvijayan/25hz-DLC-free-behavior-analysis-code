
% you provide the array of velocities before the egg laying event
function bouts = findbouts_25(veldata)
% original
swin = 18*25+1;
swinhalf = 9*25;

% edit 10/2/2020
% swin = 18*25*2+1;
% swinhalf = 9*25*2;


bouts = 1;


veldata_smooth = nanfastsmooth(veldata,swin,1,1)';
% original
%[a b] = find(veldata_smooth(1:1:end-swinhalf) < .1, 1, 'last');

%edit 10/2/2020
[a b] = find(veldata_smooth(1:1:end-swinhalf) < .1, 1, 'last');
bouts = a;
if(isempty(bouts))
    bouts = 1;
end
end
