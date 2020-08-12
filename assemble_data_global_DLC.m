%% if search_dur is 0, you will use the traditional computationally determiend search. Otherwise it is the search duration in seconds

%% min search is the minimum search duration in seconds

%% input csv like:



% csv{1} = 'fly3DeepCut_resnet50_GPU_07232019Jul23shuffle1_1030000.csv';
% csv{2} = 'fly5DeepCut_resnet50_GPU_07232019Jul23shuffle1_1030000.csv';
% csv{3} = 'fly6DeepCut_resnet50_GPU_07232019Jul23shuffle1_1030000.csv';
% csv{4} = 'fly7DeepCut_resnet50_GPU_07232019Jul23shuffle1_1030000.csv';
% csv{5} = 'fly8DeepCut_resnet50_GPU_07232019Jul23shuffle1_1030000.csv';



% csv{1} = 'fly3_ALL_ffmpegDeepCut_resnet50_GPU_07232019Jul23shuffle1_1030000.csv';
% csv{2} = 'fly5_ALL_ffmpegDeepCut_resnet50_GPU_07232019Jul23shuffle1_1030000.csv';
% csv{3} = 'fly6_ALL_ffmpegDeepCut_resnet50_GPU_07232019Jul23shuffle1_1030000.csv';
% csv{4} = 'fly7_ALL_ffmpegDeepCut_resnet50_GPU_07232019Jul23shuffle1_1030000.csv';
% csv{5} = 'fly8_ALL_ffmpegDeepCut_resnet50_GPU_07232019Jul23shuffle1_1030000.csv';
%  lengths_to_use = [inf,inf,295000,355500, 175200];
%[eggs, trx] = assemble_data_global_DLC(csv, egg, 0, 0, 0, 30, inf,lengths_to_use);


% R65H10 chrimson
% csv{1} = 'R65H10_425_chrimson_Gcamp7f_FLY6_2019-12-20-112216-0000_ffmpegDeepCut_resnet50_GPU_07232019Jul23shuffle1_1030000.csv';
% lengths_to_use = [inf];
%[eggs, trx] = assemble_data_global_DLC(csv, egg, 0, 0, 0, 30, inf,lengths_to_use);

% SS01048 chrimson
% csv{1} = 'SS01048_425_chrimson_Gcamp7f_FLY3_2019-12-17-184217-0000_ffmpegDeepCut_resnet50_GPU_07232019Jul23shuffle1_1030000.csv';
% lengths_to_use = [215500];
% egg = [];
%[eggs, trx] = assemble_data_global_DLC(csv, egg, 0, 0, 0, 30, inf,lengths_to_use);

% SS53469 chrimson
% csv{1} = 'SS53469_425_chrimson_Gcamp7f_FLY2_ffmpegDeepCut_resnet50_GPU_07232019Jul23shuffle1_1030000.csv';
% csv{2} = 'SS53469_425_chrimson_Gcamp7f_FLY4_2019-12-18-155303-0000_ffmpegDeepCut_resnet50_GPU_07232019Jul23shuffle1_1030000.csv';
% csv{3} = 'SS53469_425_chrimson_Gcamp7f_FLY5_2019-12-18-185850-0000_ffmpegDeepCut_resnet50_GPU_07232019Jul23shuffle1_1030000.csv';
% lengths_to_use = [inf,inf,inf];
%[eggs, trx] = assemble_data_global_DLC(csv, egg, 0, 0, 0, 30, inf,lengths_to_use);


function [eggs, trx] = assemble_data_global_DLC(csv, egg, substrate, search_dur, chamber_type, min_search, max_search, lengths_to_use)


% reorder egg to make sure all eggs are in ascending order. all new data
% files should already be in ascending order, but some of the old ones are
% not always in ascending order. this is a new addition to the code on
% 1/5/2015

for i = 1:1:length(csv)
    if(~isempty(egg))
        [a, ~] = find(egg(:,i) > 0);
        egg(1:1:length(a),i) = sort(egg(1:1:length(a),i),'ascend');
    end
end


% for trx 5 2121 pixels = 30 mm (the diameter of the outside of the
% chamber -- used the diagonal)
% 70.7 pixels per mm
pixels_per_mm = 70.7;
image_y = 1972;

for fly_num = 1:1:length(csv)
    disp(['entering csv ' num2str(fly_num)]);
    tmp = cell2str(csv(fly_num));
    tmp = tmp(4:end-3)
    
    [bodypart]= importDeepLabCutfile_VV(tmp, 4, inf);
    bodypart = bodypart(2:61,:);
    
    tot_frames_to_use = min(lengths_to_use(fly_num),length(bodypart(19,:)));
    bodypart = bodypart(:,1:tot_frames_to_use);
    
    clrz = linspecer(11);
    
    time = 0:1/25:(length(bodypart(19,:))-1)./25;
    frame=0:1:length(bodypart(19,:))-1;
    
    disp(['loaded DLC ' num2str(fly_num)]);
    % .99 to .9
    % 20 to 2000
    %filtering
%     for i = 2:1:(length(bodypart(19,:)))
%         if(bodypart(21,i) < .95 || abs(bodypart(19,i)-bodypart(19,i-1)) > 10)
%             bodypart(19,i) = NaN;
%             bodypart(20,i) = NaN;
%         end
%         if(bodypart(21,i) < .95 || abs(bodypart(20,i)-bodypart(20,i-1)) > 10)
%             bodypart(19,i) = NaN;
%             bodypart(20,i) = NaN;
%         end
%         
%         if(bodypart(24,i) < .95 || abs(bodypart(22,i)-bodypart(22,i-1)) > 10)
%             bodypart(22,i) = NaN;
%             bodypart(23,i) = NaN;
%         end
%         if(bodypart(24,i) < .95 || abs(bodypart(23,i)-bodypart(23,i-1)) > 10)
%             bodypart(22,i) = NaN;
%             bodypart(23,i) = NaN;
%         end
%         
%         if(bodypart(27,i) < .95 || abs(bodypart(25,i)-bodypart(25,i-1)) > 10)
%             bodypart(25,i) = NaN;
%             bodypart(26,i) = NaN;
%         end
%         if(bodypart(27,i) < .95 || abs(bodypart(26,i)-bodypart(26,i-1)) > 10)
%             bodypart(25,i) = NaN;
%             bodypart(26,i) = NaN;
%         end
%         
%         if(bodypart(30,i) < .1 || abs(bodypart(28,i)-bodypart(28,i-1)) > 50)
%             bodypart(29,i) = NaN;
%             bodypart(28,i) = NaN;
%         end
%         if(bodypart(30,i) < .1 || abs(bodypart(29,i)-bodypart(29,i-1)) > 50)
%             bodypart(29,i) = NaN;
%             bodypart(28,i) = NaN;
%         end
%     end
%     
    
    tip_to_thorax_x = (bodypart(19,:)-bodypart(22,:))./pixels_per_mm;
    tip_to_thorax_y = (bodypart(20,:)-bodypart(23,:))./pixels_per_mm;
    tip_to_thorax = ((tip_to_thorax_x.^2+tip_to_thorax_y.^2).^(.5));
    
    thorax_to_head_x = (bodypart(22,:)-bodypart(25,:))./pixels_per_mm;
    thorax_to_head_y = (bodypart(23,:)-bodypart(26,:))./pixels_per_mm;
    thorax_to_head = ((thorax_to_head_x.^2+thorax_to_head_y.^2).^(.5));
    
    head_to_prob_x = (bodypart(25,:)-bodypart(28,:))./pixels_per_mm;
    head_to_prob_y = (bodypart(26,:)-bodypart(29,:))./pixels_per_mm;
    head_to_prob = ((head_to_prob_x.^2+head_to_prob_y.^2).^(.5));
    
    thorax_to_prob_x = (bodypart(22,:)-bodypart(28,:))./pixels_per_mm;
    thorax_to_prob_y = (bodypart(23,:)-bodypart(29,:))./pixels_per_mm;
    thorax_to_prob = ((thorax_to_prob_x.^2+thorax_to_prob_y.^2).^(.5))./pixels_per_mm;
    
    head_to_tip_x = (bodypart(25,:)-bodypart(19,:))./pixels_per_mm;
    head_to_tip_y = (bodypart(26,:)-bodypart(20,:))./pixels_per_mm;
    head_to_tip = ((head_to_tip_x.^2+head_to_tip_y.^2).^(.5));
    
    % changed this on 5/11 to be to the head
    trx(1,fly_num).x = bodypart(25,:);
    trx(1,fly_num).y = image_y-bodypart(26,:)+1;
    trx(1,fly_num).x_mm = trx(1,fly_num).x./pixels_per_mm;
    trx(1,fly_num).y_mm = trx(1,fly_num).y./pixels_per_mm;
    trx(1,fly_num).sucrose = zeros(1,length(bodypart(26,:)));
    
    % smoothing
    head_to_prob_smooth = nanfastsmooth(head_to_prob,25,1,24/25);
    tip_to_thorax_smooth = nanfastsmooth(tip_to_thorax,25,1,24/25);
    thorax_to_prob_smooth = nanfastsmooth(thorax_to_prob,25,1,24/25);
    thorax_to_head_smooth = nanfastsmooth(thorax_to_head,25,1,24/25);
    head_to_tip_smooth = nanfastsmooth(head_to_tip,25,1,24/25);
    
    % smoothing wit detrend
    head_to_prob_smooth_det = head_to_prob_smooth - nanfastsmooth(head_to_prob,25*250,1,1);
    head_to_tip_smooth_det = head_to_tip_smooth - nanfastsmooth(head_to_tip,25*250,1,1);
    
    
    % PER events
    [trace_out_PER]=add_proboscis_ext_event(head_to_prob_smooth_det,25,4/pixels_per_mm);
    [a_PER, b_PER] =find(trace_out_PER > 0);
    % abd extention events
    [trace_out_ABD]=add_proboscis_ext_event(head_to_tip_smooth_det,4*25,5/pixels_per_mm);
    [a_ABD, b_ABD] =find(trace_out_ABD > 0);
    
    % figure;
    % hold on; ax1 = subplot(7,1,1); hold on;  title('tip to thorax');
    % plot(frame, tip_to_thorax);
    % plot(frame, tip_to_thorax_smooth, 'k');
    %
    % hold on; ax2 = subplot(7,1,2); hold on;  title('thorax to head');
    % plot(frame, thorax_to_head);
    % plot(frame, thorax_to_head_smooth, 'k');
    %
    % hold on; ax3 = subplot(7,1,3); hold on;  title('thorax to prob');
    % plot(frame, thorax_to_prob);
    % plot(frame, thorax_to_prob_smooth, 'k');
    %
    % hold on; ax4 = subplot(7,1,4); hold on;  title('head to prob');
    % plot(frame, head_to_prob);
    % plot(frame, head_to_prob_smooth, 'k');
    % scatter(b_PER,head_to_prob(b_PER),3,'r','filled');
    %
    % hold on; ax5 = subplot(7,1,5); hold on;  title('head to prob detrend');
    % plot(frame, head_to_prob_smooth_det, 'k');
    % scatter(b_PER,head_to_prob_smooth_det(b_PER),3,'r','filled');
    %
    % hold on; ax6 = subplot(7,1,6); hold on; title('head to tip');
    % plot(frame, head_to_tip);
    % plot(frame, head_to_tip_smooth, 'k');
    % scatter(b_ABD,head_to_tip_smooth(b_ABD),3,'r','filled');
    %
    % hold on; ax7 = subplot(7,1,7); hold on; title('head to tip detrend');
    % plot(frame, head_to_tip_smooth_det, 'k');
    % scatter(b_ABD,head_to_tip_smooth_det(b_ABD),3,'r','filled');
    %
    % linkaxes([ax1,ax2,ax3,ax4,ax5,ax6,ax7],'x')
    
    
    % need to put all this in structure
    % the need to take averages based on egg-laying events from Hessam/Kris
    % code
    trx(1,fly_num).bodypart = bodypart;
    trx(1,fly_num).tip_to_thorax_x = tip_to_thorax_x;
    trx(1,fly_num).tip_to_thorax_y = tip_to_thorax_y;
    trx(1,fly_num).tip_to_thorax = tip_to_thorax;
    trx(1,fly_num).thorax_to_head_x = thorax_to_head_x;
    trx(1,fly_num).thorax_to_head_y = thorax_to_head_y;
    trx(1,fly_num).thorax_to_head = thorax_to_head;
    trx(1,fly_num).head_to_prob_x = head_to_prob_x;
    trx(1,fly_num).head_to_prob_y = head_to_prob_y;
    trx(1,fly_num).head_to_prob = head_to_prob;
    trx(1,fly_num).thorax_to_prob_x = thorax_to_prob_x;
    trx(1,fly_num).thorax_to_prob_y = thorax_to_prob_y;
    trx(1,fly_num).thorax_to_prob = thorax_to_prob;
    trx(1,fly_num).head_to_tip_x = head_to_tip_x;
    trx(1,fly_num).head_to_tip_y = head_to_tip_y;
    trx(1,fly_num).head_to_tip = head_to_tip;
    trx(1,fly_num).head_to_tip_median = head_to_tip./nanmedian(head_to_tip);

    tmp_valx =trx(1,fly_num).x_mm(1);
    tmp_valy =trx(1,fly_num).y_mm(1);
    
    % remaking a 2 hz array
    for i = 1:1:length(trx(1,fly_num).x_mm)
        if(mod(i,25) == 13)
            tmp_valx = (trx(1,fly_num).x_mm(i)+trx(1,fly_num).x_mm(i-1))./2;
            tmp_valy = (trx(1,fly_num).y_mm(i)+trx(1,fly_num).y_mm(i-1))./2;
        end
        if(mod(i,25) == 0)
            tmp_valx = (trx(1,fly_num).x_mm(i));
            tmp_valy = (trx(1,fly_num).y_mm(i));
        end
        
        trx(1,fly_num).x_mm_2hz(i) = tmp_valx;
        trx(1,fly_num).y_mm_2hz(i) = tmp_valy;
    end
    
    
    disp(['computing distances csv ' num2str(fly_num)]);
    tmp = flydistance_mm(trx,fly_num,1,length(trx(1,fly_num).x_mm));
    tmp(isnan(tmp)) = 0;
    trx(1,fly_num).distance = cumsum(tmp);
    
    tmp = flydistance_mm_2hz_v1(trx,fly_num,1,length(trx(1,fly_num).x_mm));
    tmp(isnan(tmp)) = 0;
    trx(1,fly_num).distance_2hz_v1 = cumsum(tmp);
    
    tmp = flydistance_mm_2hz(trx,fly_num,1,length(trx(1,fly_num).x_mm));
    tmp(isnan(tmp)) = 0;
    trx(1,fly_num).distance_2hz = cumsum(tmp);
    
    tmp = flydistance_xmm(trx,fly_num,1,length(trx(1,fly_num).x_mm));
    tmp(isnan(tmp)) = 0;
    trx(1,fly_num).distancex = cumsum(tmp);
    
    tmp = flydistance_ymm(trx,fly_num,1,length(trx(1,fly_num).x_mm));
    tmp(isnan(tmp)) = 0;
    trx(1,fly_num).distancey = cumsum(tmp);
    
    trx(1,fly_num).distance = [0 trx(1,fly_num).distance];
    trx(1,fly_num).distancex = [0 trx(1,fly_num).distancex];
    trx(1,fly_num).distancey = [0 trx(1,fly_num).distancey];
    trx(1,fly_num).distance_2hz = [0 trx(1,fly_num).distance_2hz];
    trx(1,fly_num).distance_2hz_v1 = [0 trx(1,fly_num).distance_2hz_v1];
    
    trx(1,fly_num).speed_2hz = [0 25.*diff(trx(1,fly_num).distance_2hz)];
    trx(1,fly_num).speed_2hz_v1 = [0 2.*diff(trx(1,fly_num).distance_2hz_v1)];
    trx(1,fly_num).speed = [0 25.*diff(trx(1,fly_num).distance)];
    
    
    
    % this holdsthe value of the speed (so its not jumping between 0 and a
    % value). Since we are holding we are dividing by 12.5
    tmp_valsp = trx(1,fly_num).speed_2hz(1)./12.5;
    trx(1,fly_num).speed_2hz_hold = [];
    
    for i = 1:1:length(trx(1,fly_num).x_mm)
        if(trx(1,fly_num).speed_2hz(i) ~=0)
            tmp_valsp = trx(1,fly_num).speed_2hz(i)./12.5;
        end
        trx(1,fly_num).speed_2hz_hold(i) = tmp_valsp;
    end
    
    %     trx(1,fly_num).speed_2hz = trx(1,fly_num).speed_2hz';
    %     trx(1,fly_num).speed_2hz_v1 = trx(1,fly_num).speed_2hz_v1';
    %     trx(1,fly_num).speed =  trx(1,fly_num).speed';
    %     trx(1,fly_num).speed_2hz_hold(i) = trx(1,fly_num).speed_2hz_hold(i)';
    
    
    disp(['done with csv ' num2str(fly_num)]);
end

% ------------------------------------------------------------------------
% PART 2: THIS PART OF THE CODE CREATES EGGS STRUCTURE.

disp('starting egg structure');

eggs.fly = [];
eggs.num = [];

for i =1:1:length(csv)
    if(~isempty(egg))
        [a, ~] = find(egg(:,i) > 0);
        eggs.fly = [eggs.fly, i.*ones(1,length(a))];
        eggs.num = [eggs.num, 1:1:length(a)];
    else
        eggs.fly = [];
        eggs.num = [];
    end
end
eggs.fly = transpose(eggs.fly);
eggs.num = transpose(eggs.num);

% total eggs
eggs.total = length(eggs.fly);

% time that egg was laid (comes from egg)
[tmp1 , ~] = find(egg(:)>0);
tmp2 = egg(:);
eggs.egg_time = tmp2(tmp1);


disp('computing explore');

% time at which exploration or run started/finished
for i = 1:1:eggs.total
    
    if(search_dur ~=0)
        if(i > 1 && (eggs.fly(i) == eggs.fly(i-1)))
            eggs.explore_start_time(i) = max([1, eggs.egg_time(i-1), eggs.egg_time(i)-search_dur*25]);
        else
            eggs.explore_start_time(i) = max([1, eggs.egg_time(i)-search_dur*25]);
        end
    end
    
    if(search_dur == 0)
        eggs.explore_start_time(i) = min(findbouts_25(trx(1,eggs.fly(i)).speed_2hz_hold(1:eggs.egg_time(i))), eggs.egg_time(i)-min_search*25);
        eggs.explore_start_time(i) = max(eggs.explore_start_time(i), eggs.egg_time(i)-max_search*25);
    end
    
    eggs.run_end_time(i) = 1+length(trx(1,eggs.fly(i)).speed_2hz_hold)- findruns_25(fliplr(trx(1,eggs.fly(i)).speed_2hz_hold((1+eggs.egg_time(i)):end)));
    eggs.explore_start_substrate(i) = trx(1,eggs.fly(i)).sucrose(eggs.explore_start_time(i));
end

disp('done computing explore');

% substrate that egg is laid on (options are 0, 2, and 5 for different sucrose concentrations)
if(eggs.total > 0)
    for i = 1:1:eggs.total
        eggs.substrate(i) = trx(1,eggs.fly(i)).sucrose(eggs.egg_time(i));
    end
    eggs.substrate = transpose(eggs.substrate);
    
    eggs.explore_start_time = transpose( eggs.explore_start_time);
    eggs.run_end_time = transpose(eggs.run_end_time);
    eggs.explore_start_substrate = transpose(eggs.explore_start_substrate);
    
else
    eggs.substrate = [];
    eggs.explore_start_time = [];
    eggs.run_end_time = [];
    eggs.explore_start_substrate = [];
end
end







