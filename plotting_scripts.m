% % this is only for experiments with optogetnetic pulses
% trig = zeros(1,50*300);
% trig(2:2:end) = 4;
% 
% opto = [zeros(1,50*150),4.*ones(1,250),zeros(1,50*145)];
% 
% optor = repmat(opto,1,36);
% trigr = repmat(trig,1,36);
% 
% optor = optor(2:2:end);
% 
% pulse = {};
% pulse.fly = [];
% pulse.pulse_time = [];
% pulse.closest_egg_in_frames = [];
% 
% for i = 1:1:length(trx)
%     optor_self = optor(1:1:length(trx(1,i).x));
%     [a b] = find(diff(optor_self) > 0);
%     
%     trx(1,i).optostart = b;
%     trx(1,i).egg = zeros(1,length(trx(1,i).x));
%     [a1 b1] = find(eggs.fly == i);
%     if(~isempty(a1))
%         trx(1,i).egg(eggs.egg_time(a1)) = 1;
%     end
%     
%     pulse.fly = [pulse.fly; i.*ones(length(b),1)];
%     pulse.pulse_time = [pulse.pulse_time; b'];
%     
%     for j=1:1:length(b)
%         [a2 b2] = find(trx(1,i).egg(pulse.pulse_time(j):end) > 0,1,'first');
%         if(~isempty(b2))
%             pulse.closest_egg_in_frames = [pulse.closest_egg_in_frames b2'];
%         else
%             pulse.closest_egg_in_frames = [pulse.closest_egg_in_frames nan'];
%         end
%     end
% 
% 
% end
% 
% pulse.closest_egg_in_frames = pulse.closest_egg_in_frames';
% 
% for i = 1:1:length(trx)
%     trx(1,i).head_to_tip_median =     trx(1,i).head_to_tip ./ nanmedian(trx(1,i).head_to_tip,2);
% end
% 
% 
% %% Plot of speed/body around an optogenetic event
% % (eliminate boundary condition eggs)
% 
% %[a , ~] =find(pulse.closest_egg_in_frames <= 25*10); % plot body metrics for pulses that caused an egg
% %[a , ~] =find(pulse.closest_egg_in_frames > 25*10); % plot body metrics for pulses that caused an egg
% 
% [a , ~] =find(pulse.pulse_time > 0);
% 
% window_len = 360*25; % window_len on each side in frames
% c = [];
% for i = 1:1:length(a)
%     if(pulse.pulse_time(a(i)) > (window_len+1) && (pulse.pulse_time(a(i))+window_len) <= length(trx(1,pulse.fly(a(i))).x))
%         c = [c a(i)];
%     end
% end
% sp = [];
% head_to_prob = [];
% head_to_tip = [];
% tip_to_thorax = [];
% 
% pos = [];  th = []; sub = []; egg_pulse = [];rt = [];
% for i =1:1:length(c)
%     sp(i,:) = (trx(1,pulse.fly(c(i))).speed_2hz_hold((pulse.pulse_time(c(i))-window_len):pulse.pulse_time(c(i))+window_len));
%     head_to_prob(i,:) = (trx(1,pulse.fly(c(i))).head_to_prob((pulse.pulse_time(c(i))-window_len):pulse.pulse_time(c(i))+window_len));
%     head_to_tip(i,:) = (trx(1,pulse.fly(c(i))).head_to_tip((pulse.pulse_time(c(i))-window_len):pulse.pulse_time(c(i))+window_len));
%     tip_to_thorax(i,:) = (trx(1,pulse.fly(c(i))).tip_to_thorax((pulse.pulse_time(c(i))-window_len):pulse.pulse_time(c(i))+window_len));
%     egg_pulse(i,:) = (trx(1,pulse.fly(c(i))).egg((pulse.pulse_time(c(i))-window_len):pulse.pulse_time(c(i))+window_len));
% end
% %[~, b] = sort(et);
% b=1:1:length(c);
% figure; imagesc(sp(b,:)); hold on; %scatter(window_len-et(b).*2,1:1:length(et),8,[.5 .5 .5],'filled')
% box on; set(gca,'xlim',[0 window_len*2]); title(title_string); colormap(gca,'cool'); caxis([0 5]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
% xlabel('Time with respect to pulse event (minutes)'); ylabel('Speed (mm/sec), 2hz hold of individual pulse events'); colorbar;
% [aa bb] = find(egg_pulse > 0);
% scatter(bb,aa,5,'k','filled');
% 
% figure; imagesc(head_to_tip(b,:)); hold on; %scatter(window_len-et(b).*2,1:1:length(et),8,[.5 .5 .5],'filled')
% box on; set(gca,'xlim',[0 window_len*2]); title(title_string); colormap(gca,'cool'); caxis([2 2.5]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
% xlabel('Time with respect to pulse event (minutes)'); ylabel('head to tip length of individual pulse events'); colorbar;
% scatter(bb,aa,5,'k','filled');
% 
% % figure; imagesc(tip_to_thorax(b,:)); hold on; %scatter(window_len-et(b).*2,1:1:length(et),8,[.5 .5 .5],'filled')
% % box on; set(gca,'xlim',[0 window_len*2]); title(title_string); colormap(gca,'cool'); caxis([1 1.5]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
% % xlabel('Time with respect to pulse event (minutes)'); ylabel('thorax to tip length of individual pulse events'); colorbar;
% % scatter(bb,aa,5,'k','filled');
% 
% % figure; imagesc(head_to_prob(b,:)); hold on; %scatter(window_len-et(b).*2,1:1:length(et),8,[.5 .5 .5],'filled')
% % box on; set(gca,'xlim',[0 window_len*2]); title(title_string); colormap(gca,'cool'); caxis([2.5 3.5]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
% % xlabel('Time with respect to pulse event (minutes)'); ylabel('proboscis length  of individual pulse events'); colorbar;
% % scatter(bb,aa,5,'k','filled');
% 
% figure; imagesc(sp(b,:)); hold on; %scatter(window_len-et(b).*2,1:1:length(et),8,[.5 .5 .5],'filled')
% box on; set(gca,'xlim',[window_len-60*25 window_len+60*25]); title(title_string); colormap(gca,'cool'); caxis([0 5]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
% xlabel('Time with respect to pulse event (minutes)'); ylabel('Speed (mm/sec), 2hz hold of individual pulse events'); colorbar;
% scatter(bb,aa,5,'k','filled');
% 
% figure; imagesc(head_to_tip(b,:)); hold on; %scatter(window_len-et(b).*2,1:1:length(et),8,[.5 .5 .5],'filled')
% box on; set(gca,'xlim',[window_len-60*25 window_len+60*25]); title(title_string); colormap(gca,'cool'); caxis([2 2.5]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
% xlabel('Time with respect to pulse event (minutes)'); ylabel('head to tip length of individual pulse events'); colorbar;
% scatter(bb,aa,5,'k','filled');
%  
% % figure; imagesc(tip_to_thorax(b,:)); hold on; %scatter(window_len-et(b).*2,1:1:length(et),8,[.5 .5 .5],'filled')
% % box on; set(gca,'xlim',[window_len-60*25 window_len+60*25]); title(title_string); colormap(gca,'cool'); caxis([1 1.5]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
% % xlabel('Time with respect to pulse event (minutes)'); ylabel('thorax to tip length of individual pulse events'); colorbar;
% % 
% % 
% % figure; imagesc(head_to_prob(b,:)); hold on; %scatter(window_len-et(b).*2,1:1:length(et),8,[.5 .5 .5],'filled')
% % box on; set(gca,'xlim',[window_len-60*25 window_len+60*25]);  title(title_string); colormap(gca,'cool'); caxis([2.5 3.5]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
% % xlabel('Time with respect to pulse event (minutes)'); ylabel('proboscis length  of individual pulse events'); colorbar;
% % 
% 
% figure; hold on; box on; title(title_string);
% standard_error =nanstd(sp(b,:))./sqrt(length(b));
% mean_data = nanmean(sp(b,:));
% fill([(0:1:2*window_len),fliplr(0:1:2*window_len)],[mean_data+standard_error,fliplr(mean_data-standard_error)],[0 0 .9],'linestyle','none');
% plot((0:1:2*window_len),nanmean(sp),'k'); set(gca,'xtick',0:(25*30):window_len*2); set(gca,'xticklabel',(-1.*window_len/25):30:(window_len/25)); set(gca,'xlim',[0, window_len*2]);
% xlabel('Time with respect to pulse event (seconds)'); ylabel('Mean speed (mm/sec), 2hz hold of all individual pulse events with SEM');
% 
% figure; hold on; box on; title(title_string);
% standard_error =nanstd(sp(b,:))./sqrt(length(b));
% mean_data = nanmean(sp(b,:));
% fill([(0:1:2*window_len),fliplr(0:1:2*window_len)],[mean_data+standard_error,fliplr(mean_data-standard_error)],[0 0 .9],'linestyle','none');
% plot((0:1:2*window_len),nanmean(sp),'k'); set(gca,'xtick',0:(25*5):window_len*2); set(gca,'xticklabel',(-1.*window_len/25):5:(window_len/25)); set(gca,'xlim',[window_len-45*25, window_len+45*25]);
% xlabel('Time with respect to pulse event (seconds)'); ylabel('Mean speed (mm/sec), 2hz hold of individual pulse events with SEM');
% 
% % figure; hold on; box on; title(title_string);
% % standard_error =nanstd(head_to_prob(b,:))./sqrt(length(b));
% % mean_data = nanmean(head_to_prob(b,:));
% % fill([(0:1:2*window_len),fliplr(0:1:2*window_len)],[mean_data+standard_error,fliplr(mean_data-standard_error)],[0 0 .9],'linestyle','none');
% % plot((0:1:2*window_len),nanmean(head_to_prob),'k'); set(gca,'xtick',0:(25*5):window_len*2); set(gca,'xticklabel',(-1.*window_len/25):5:(window_len/25)); set(gca,'xlim',[window_len-45*25, window_len+45*25]);
% % xlabel('Time with respect to pulse event (seconds)'); ylabel('proboscis length of all individual pulse events with SEM');
% 
% figure; hold on; box on; title(title_string);
% standard_error =nanstd(head_to_tip(b,:))./sqrt(length(b));
% mean_data = nanmean(head_to_tip(b,:));
% fill([(0:1:2*window_len),fliplr(0:1:2*window_len)],[mean_data+standard_error,fliplr(mean_data-standard_error)],[0 0 .9],'linestyle','none');
% plot((0:1:2*window_len),nanmean(head_to_tip),'k'); set(gca,'xtick',0:(25*30):window_len*2); set(gca,'xticklabel',(-1.*window_len/25):30:(window_len/25)); set(gca,'xlim',[0, window_len*2]);
% xlabel('Time with respect to pulse event (seconds)'); ylabel('head to tip length of all individual pulse events with SEM');
% 
% figure; hold on; box on; title(title_string);
% standard_error =nanstd(head_to_tip(b,:))./sqrt(length(b));
% mean_data = nanmean(head_to_tip(b,:));
% fill([(0:1:2*window_len),fliplr(0:1:2*window_len)],[mean_data+standard_error,fliplr(mean_data-standard_error)],[0 0 .9],'linestyle','none');
% plot((0:1:2*window_len),nanmean(head_to_tip),'k'); set(gca,'xtick',0:(25*5):window_len*2); set(gca,'xticklabel',(-1.*window_len/25):5:(window_len/25)); set(gca,'xlim',[window_len-45*25, window_len+45*25]);
% xlabel('Time with respect to pulse event (seconds)'); ylabel('head to tip length of all individual pulse events with SEM');
% 
% % figure; hold on; box on; title(title_string);
% % standard_error =nanstd(tip_to_thorax(b,:))./sqrt(length(b));
% % mean_data = nanmean(tip_to_thorax(b,:));
% % fill([(0:1:2*window_len),fliplr(0:1:2*window_len)],[mean_data+standard_error,fliplr(mean_data-standard_error)],[0 0 .9],'linestyle','none');
% % plot((0:1:2*window_len),nanmean(tip_to_thorax),'k'); set(gca,'xtick',0:(25*5):window_len*2); set(gca,'xticklabel',(-1.*window_len/25):5:(window_len/25)); set(gca,'xlim',[window_len-45*25, window_len+45*25]);
% % xlabel('Time with respect to pulse event (seconds)'); ylabel('thorax to tip length of all individual pulse events with SEM');
% 
% %clearvars -except trx eggs title_string
% 
% 
% 
% 
% 
% 




%% plot stuff around egg

%% Plot the substrate heatmap around egg
[a , ~] =find(eggs.egg_time > 0);
window_len = 360*25; % window_len on each side in frames
c = [];
for i = 1:1:length(a)
    if(eggs.egg_time(a(i)) > (window_len+1) && (eggs.egg_time(a(i))+window_len) <= length(trx(1,eggs.fly(a(i))).x))
        c = [c a(i)];
    end
end
sp = []; pos = [];  th = []; sub = []; et = [];rt = []; eggt = [];
for i =1:1:length(c)
    sp(i,:) = (trx(1,eggs.fly(c(i))).speed_2hz_hold((eggs.egg_time(c(i))-window_len):eggs.egg_time(c(i))+window_len));
    pos(i,:) = trx(1,eggs.fly(c(i))).sucrose((eggs.egg_time(c(i))-window_len):eggs.egg_time(c(i))+window_len);
    %th(i,:) = ((trx(1,eggs.fly(c(i))).theta((eggs.egg_time(c(i))-window_len):eggs.egg_time(c(i))+window_len)));
    sub(i,:) = ((trx(1,eggs.fly(c(i))).sucrose((eggs.egg_time(c(i))-window_len):eggs.egg_time(c(i))+window_len)));
    %et(i) = (eggs.egg_time(c(i))-eggs.explore_start_time(c(i)))./2;
    %rt(i) = (eggs.run_end_time(c(i))-eggs.egg_time(c(i)))./2;
    eggt(i) = eggs.egg_time(c(i));
end
[~, b] = sort(eggt);


figure; hold on; subplot(5,5,[1,2,3,4,6,7,8,9,11,12,13,14,16,17,18,19,21,22,23,24]); imagesc(sub(b,:)); hold on;
box on; set(gca,'xlim',[0 window_len*2]); title(title_string); colormap(gca,[1 0 0; 0 1 0; 0 0 0]); caxis([0 4]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
xlabel('Time with respect to egg-laying event (minutes)'); ylabel({'Substrate of individual egg-laying events where fly encountered', 'best and second best option ordered by time in chamber'});

subplot(5,5,[5,10,15,20,25]); hold on;  title(title_string);
plot(eggt(b)./7200,1:1:length(eggt),'k'); set(gca,'ylim',[0 length(eggt)]); grid on; set(gca,'Ydir','reverse'); set(gca,'yticklabel',[]); set(gca,'xtick',0:2:20); set(gca,'xticklabel',{'0','','','6','','','12','','','18',''});
xlabel('Hour in chamber');

clearvars -except trx eggs title_string

%% Plot of speed around an egg laying event ordered by exploration duration
% (eliminate boundary condition eggs)

[a , ~] =find(eggs.egg_time > 0);
window_len = 360*25; % window_len on each side in frames
c = [];
for i = 1:1:length(a)
    if(eggs.egg_time(a(i)) > (window_len+1) && (eggs.egg_time(a(i))+window_len) <= length(trx(1,eggs.fly(a(i))).x))
        c = [c a(i)];
    end
end
sp = []; pos = [];  th = []; sub = []; et = [];rt = [];
for i =1:1:length(c)
    sp(i,:) = (trx(1,eggs.fly(c(i))).speed_2hz_hold((eggs.egg_time(c(i))-window_len):eggs.egg_time(c(i))+window_len));
    et(i) = (eggs.egg_time(c(i))-eggs.explore_start_time(c(i)))./2;
        ovt(i) = (eggs.egg_time(c(i))-ovu_end_array(c(i)))./2;

end
[~, b] = sort(et);
figure; imagesc(sp(b,:)); hold on; scatter(window_len-et(b).*2,1:1:length(et),8,[.5 .5 .5],'filled')
box on; set(gca,'xlim',[0 window_len*2]); title(title_string); colormap(gca,'cool'); caxis([0 5]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
xlabel('Time with respect to egg-laying event (minutes)'); ylabel('Speed (mm/sec), 2hz hold of individual egg-laying events'); colorbar;
hold on; scatter(window_len-ovt(b).*2,1:1:length(ovt),8,'k','filled')

figure; hold on; box on; title(title_string);
standard_error =nanstd(sp(b,:))./sqrt(length(b));
mean_data = nanmean(sp(b,:));
fill([(0:1:2*window_len),fliplr(0:1:2*window_len)],[mean_data+standard_error,fliplr(mean_data-standard_error)],[0 0 .9],'linestyle','none');
plot((0:1:2*window_len),nanmean(sp),'k'); set(gca,'xtick',0:(25*30):window_len*2); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
xlabel('Time with respect to egg-laying event (seconds)'); ylabel('Mean speed (mm/sec), 2hz hold of all individual egg-laying events with SEM');


figure; hold on; box on; title(title_string);
standard_error =nanstd(sp(b,:))./sqrt(length(b));
mean_data = nanmean(sp(b,:));
fill([(0:1:2*window_len),fliplr(0:1:2*window_len)],[mean_data+standard_error,fliplr(mean_data-standard_error)],[0 0 .9],'linestyle','none');
plot((0:1:2*window_len),nanmean(sp),'k'); set(gca,'xtick',0:(25*5):window_len*2); set(gca,'xticklabel',(-1.*window_len/25):5:(window_len/25)); set(gca,'xlim',[window_len-45*25, window_len+45*25]);
xlabel('Time with respect to egg-laying event (seconds)'); ylabel('Mean speed (mm/sec), 2hz hold of all individual egg-laying events with SEM');

clearvars -except trx eggs title_string





%% Plot various things around an egg laying event ordered by exploration duration
% (eliminate boundary condition eggs)

[a , ~] =find(eggs.egg_time > 0);
window_len = 480*25; % window_len on each side in frames
c = [];
f= [];
for i = 1:1:length(a)
    if(eggs.egg_time(a(i)) > (window_len+1) && (eggs.egg_time(a(i))+window_len) <= length(trx(1,eggs.fly(a(i))).x))
        c = [c a(i)];
        f = [f eggs.fly(a(i))];
    end
end
sp = []; pos = [];  th = []; sub = []; et = [];rt = []; egg_time = [];

for i =1:1:length(c)
    sp(i,:) = (trx(1,eggs.fly(c(i))).speed_2hz_hold((eggs.egg_time(c(i))-window_len):eggs.egg_time(c(i))+window_len));
    et(i) = (eggs.egg_time(c(i))-eggs.explore_start_time(c(i)))./2;
            ovt(i) = (eggs.egg_time(c(i))-ovu_end_array(c(i)))./2;
    et_time(i) = eggs.explore_start_time(c(i));

            ov_time(i) = ovu_end_array(c(i));
    egg_time(i) = eggs.egg_time(c(i));
    tip_to_thorax(i,:) = (trx(1,eggs.fly(c(i))).tip_to_thorax((eggs.egg_time(c(i))-window_len):eggs.egg_time(c(i))+window_len));
    tip_to_thorax_x(i,:) = (trx(1,eggs.fly(c(i))).tip_to_thorax_x((eggs.egg_time(c(i))-window_len):eggs.egg_time(c(i))+window_len));
    tip_to_thorax_y(i,:) = (trx(1,eggs.fly(c(i))).tip_to_thorax_y((eggs.egg_time(c(i))-window_len):eggs.egg_time(c(i))+window_len));
    
    thorax_to_head(i,:) = (trx(1,eggs.fly(c(i))).thorax_to_head((eggs.egg_time(c(i))-window_len):eggs.egg_time(c(i))+window_len));
    thorax_to_head_x(i,:) = (trx(1,eggs.fly(c(i))).thorax_to_head_x((eggs.egg_time(c(i))-window_len):eggs.egg_time(c(i))+window_len));
    thorax_to_head_y(i,:) = (trx(1,eggs.fly(c(i))).thorax_to_head_y((eggs.egg_time(c(i))-window_len):eggs.egg_time(c(i))+window_len));
    
    head_to_prob(i,:) = (trx(1,eggs.fly(c(i))).head_to_prob((eggs.egg_time(c(i))-window_len):eggs.egg_time(c(i))+window_len));
    head_to_prob_x(i,:) = (trx(1,eggs.fly(c(i))).head_to_prob_x((eggs.egg_time(c(i))-window_len):eggs.egg_time(c(i))+window_len));
    head_to_prob_y(i,:) = (trx(1,eggs.fly(c(i))).head_to_prob_y((eggs.egg_time(c(i))-window_len):eggs.egg_time(c(i))+window_len));
    
    thorax_to_prob(i,:) = (trx(1,eggs.fly(c(i))).thorax_to_prob((eggs.egg_time(c(i))-window_len):eggs.egg_time(c(i))+window_len));
    thorax_to_prob_x(i,:) = (trx(1,eggs.fly(c(i))).thorax_to_prob_x((eggs.egg_time(c(i))-window_len):eggs.egg_time(c(i))+window_len));
    thorax_to_prob_y(i,:) = (trx(1,eggs.fly(c(i))).thorax_to_prob_y((eggs.egg_time(c(i))-window_len):eggs.egg_time(c(i))+window_len));
    
    head_to_tip(i,:) = (trx(1,eggs.fly(c(i))).head_to_tip((eggs.egg_time(c(i))-window_len):eggs.egg_time(c(i))+window_len));
    head_to_tip_x(i,:) = (trx(1,eggs.fly(c(i))).head_to_tip_x((eggs.egg_time(c(i))-window_len):eggs.egg_time(c(i))+window_len));
    head_to_tip_y(i,:) = (trx(1,eggs.fly(c(i))).head_to_tip_y((eggs.egg_time(c(i))-window_len):eggs.egg_time(c(i))+window_len));
    
   head_to_tip_median(i,:) = (trx(1,eggs.fly(c(i))).head_to_tip_median((eggs.egg_time(c(i))-window_len):eggs.egg_time(c(i))+window_len));
    
    
end
% 
% %% plot an individual trace
i = 116;
i = 45;
figure; plot(smoothdata(sp(i,:),'movmean',125)); yyaxis right; plot(smoothdata(head_to_tip(i,:)','movmean',125))
%  figure; plot(smooth(sp(i,:),125)); yyaxis right; plot(smooth(head_to_tip(i,:),125))
q = egg_time - egg_time(i)+12000;
q2 = ov_time - egg_time(i)+12000;
q3 = et_time - egg_time(i)+12000;

for jj = (i-3):1:(i+3)
line([q(jj),q(jj)],[-10,10]);
line([q2(jj),q2(jj)],[-10,10],'color','k');
line([q3(jj),q3(jj)],[-10,10],'color','m');

end
% 
% 
% 
% %% Plot individual flies over time
% for i =1:1:length(trx(1,:))
%     [~, b] = find(f == i);
% 
%     figure; imagesc(sp(b,:)); hold on; scatter(window_len-et(b).*2,1:1:length(et(b)),8,[.5 .5 .5],'filled')
%     box on; set(gca,'xlim',[0 window_len*2]); title(title_string); colormap(gca,'cool'); caxis([0 5]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
%     xlabel('Time with respect to egg-laying event (minutes)'); ylabel('Speed (mm/sec) of individual egg-laying events'); colorbar;
%     
%     figure; imagesc(head_to_tip(b,:)); hold on; scatter(window_len-et(b).*2,1:1:length(et(b)),8,[.5 .5 .5],'filled')
%     box on; set(gca,'xlim',[0 window_len*2]); title(title_string); colormap(gca,'cool'); caxis([2.3 2.7]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
%     xlabel('Time with respect to egg-laying event (minutes)'); ylabel('Head to tip distance (mm) of individual egg-laying events'); colorbar;
%     
%     
% end
% 
% for i =1:1:length(trx(1,:))
%     [~, b] = sort(et);
%     et_b = et(b);
%     f_b = f(b);
%     sp_b = sp(b,:);
%     head_to_tip_b = head_to_tip(b,:);
%     [~, b] = find(f_b == i);
% 
%     figure; imagesc(sp_b(b,:)); hold on; scatter(window_len-et_b(b).*2,1:1:length(et_b(b)),8,[.5 .5 .5],'filled')
%     box on; set(gca,'xlim',[0 window_len*2]); title(title_string); colormap(gca,'cool'); caxis([0 5]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
%     xlabel('Time with respect to egg-laying event (minutes)'); ylabel('Speed (mm/sec) of individual egg-laying events'); colorbar;
%     
%     figure; imagesc(head_to_tip_b(b,:)); hold on; scatter(window_len-et_b(b).*2,1:1:length(et_b(b)),8,[.5 .5 .5],'filled')
%     box on; set(gca,'xlim',[0 window_len*2]); title(title_string); colormap(gca,'cool'); caxis([2.3 2.7]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
%     xlabel('Time with respect to egg-laying event (minutes)'); ylabel('Head to tip distance (mm) of individual egg-laying events'); colorbar;
% end
% 

%% Plot speed 2hz hold around an egg laying event ordered by exploration duration
[~, b] = sort(et);

figure; imagesc(sp(b,:)); hold on; scatter(window_len-et(b).*2,1:1:length(et),8,[.5 .5 .5],'filled')
box on; set(gca,'xlim',[0 window_len*2]); title(title_string); colormap(gca,'cool'); caxis([0 5]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
xlabel('Time with respect to egg-laying event (minutes)'); ylabel('Speed 2hz hold (mm/sec) of individual egg-laying events'); colorbar;
hold on; scatter(window_len-ovt(b).*2,1:1:length(ovt),8,'k','filled')
set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
box off
set(gca,'TickDir','out')



figure; hold on; box on; title(title_string);
standard_error =nanstd(sp(b,:))./sqrt(length(b));
mean_data = nanmean(sp(b,:));
fill([(0:1:2*window_len),fliplr(0:1:2*window_len)],[mean_data+standard_error,fliplr(mean_data-standard_error)],[0 0 .9],'linestyle','none');
plot((0:1:2*window_len),nanmean(sp),'k'); set(gca,'xtick',0:(25*60):window_len*2); set(gca,'xticklabel',(-1.*window_len/25):60:(window_len/25)); set(gca,'xlim',[0, window_len*2]);
xlabel('Time with respect to egg-laying event (seconds)'); ylabel('Mean speed 2hz hold (mm/sec) of all individual egg-laying events with SEM');
set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
box off
set(gca,'TickDir','out')

%% Plot head to tip distance around an egg laying event ordered by exploration duration

[~, b] = sort(et);
figure; imagesc(head_to_tip(b,:)); hold on; scatter(window_len-et(b).*2,1:1:length(et),8,[.5 .5 .5],'filled')
box on; set(gca,'xlim',[0 window_len*2]); title(title_string); colormap(gca,'cool'); caxis([2.3 2.7]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
xlabel('Time with respect to egg-laying event (minutes)'); ylabel('Head to tip distance (mm) of individual egg-laying events'); colorbar;
hold on; scatter(window_len-ovt(b).*2,1:1:length(et),8,'k','filled')
set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
box off
set(gca,'TickDir','out')


figure; hold on; box on; title(title_string);
standard_error =nanstd(head_to_tip(b,:))./sqrt(length(b));
mean_data = nanmean(head_to_tip(b,:));
fill([(0:1:2*window_len),fliplr(0:1:2*window_len)],[mean_data+standard_error,fliplr(mean_data-standard_error)],[0 0 .9],'linestyle','none');
plot((0:1:2*window_len),nanmean(head_to_tip),'k'); set(gca,'xtick',0:(25*60):window_len*2); set(gca,'xticklabel',(-1.*window_len/25):60:(window_len/25)); set(gca,'xlim',[0, window_len*2]);
xlabel('Time with respect to egg-laying event (seconds)'); ylabel('Head to tip distance (mm) of all individual egg-laying events with SEM');
set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
box off
set(gca,'TickDir','out')

figure; hold on; box on; title(title_string);
standard_error =nanstd(head_to_tip(b,:))./sqrt(length(b));
mean_data = nanmean(head_to_tip(b,:));
fill([(0:1:2*window_len),fliplr(0:1:2*window_len)],[mean_data+standard_error,fliplr(mean_data-standard_error)],[0 0 .9],'linestyle','none');
plot((0:1:2*window_len),nanmean(head_to_tip),'k'); set(gca,'xtick',0:(25*5):window_len*2); set(gca,'xticklabel',(-1.*window_len/25):5:(window_len/25)); set(gca,'xlim',[window_len-45*25, window_len+45*25]);
xlabel('Time with respect to egg-laying event (seconds)'); ylabel('Head to tip distance (mm) of all individual egg-laying events with SEM');

figure; hold on; box on; title(title_string);
standard_error =nanstd(head_to_tip_median(b,:))./sqrt(length(b));
mean_data = nanmean(head_to_tip_median(b,:));
fill([(0:1:2*window_len),fliplr(0:1:2*window_len)],[mean_data+standard_error,fliplr(mean_data-standard_error)],[0 0 .9],'linestyle','none');
plot((0:1:2*window_len),nanmean(head_to_tip_median),'k'); set(gca,'xtick',0:(25*5):window_len*2); set(gca,'xticklabel',(-1.*window_len/25):5:(window_len/25)); set(gca,'xlim',[window_len-45*25, window_len+45*25]);
xlabel('Time with respect to egg-laying event (seconds)'); ylabel('Head to tip distance (median normalized) (mm) of all individual egg-laying events with SEM');



%% Plot thorax to tip distance around an egg laying event ordered by exploration duration
% 
% [~, b] = sort(et);
% figure; imagesc(tip_to_thorax(b,:)); hold on; scatter(window_len-et(b).*2,1:1:length(et),8,[.5 .5 .5],'filled')
% box on; set(gca,'xlim',[0 window_len*2]); title(title_string); colormap(gca,'cool'); caxis([1 1.5]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
% xlabel('Time with respect to egg-laying event (minutes)'); ylabel('Thorax to tip distance (mm) of individual egg-laying events'); colorbar;
% 
% figure; hold on; box on; title(title_string);
% standard_error =nanstd(tip_to_thorax(b,:))./sqrt(length(b));
% mean_data = nanmean(tip_to_thorax(b,:));
% fill([(0:1:2*window_len),fliplr(0:1:2*window_len)],[mean_data+standard_error,fliplr(mean_data-standard_error)],[0 0 .9],'linestyle','none');
% plot((0:1:2*window_len),nanmean(tip_to_thorax),'k'); set(gca,'xtick',0:(25*30):window_len*2); set(gca,'xticklabel',(-1.*window_len/25):30:(window_len/25)); set(gca,'xlim',[0, window_len*2]);
% xlabel('Time with respect to egg-laying event (seconds)'); ylabel('Thorax to tip distance (mm) of all individual egg-laying events with SEM');
% 
% figure; hold on; box on; title(title_string);
% standard_error =nanstd(tip_to_thorax(b,:))./sqrt(length(b));
% mean_data = nanmean(tip_to_thorax(b,:));
% fill([(0:1:2*window_len),fliplr(0:1:2*window_len)],[mean_data+standard_error,fliplr(mean_data-standard_error)],[0 0 .9],'linestyle','none');
% plot((0:1:2*window_len),nanmean(tip_to_thorax),'k'); set(gca,'xtick',0:(25*5):window_len*2); set(gca,'xticklabel',(-1.*window_len/25):5:(window_len/25)); set(gca,'xlim',[window_len-45*25, window_len+45*25]);
% xlabel('Time with respect to egg-laying event (seconds)'); ylabel('Thorax to tip distance (mm) of all individual egg-laying events with SEM');

%% Plot head to prob distance around an egg laying event ordered by exploration duration

% [~, b] = sort(et);
% figure; imagesc(head_to_prob(b,:)); hold on; scatter(window_len-et(b).*2,1:1:length(et),8,[.5 .5 .5],'filled')
% box on; set(gca,'xlim',[0 window_len*2]); title(title_string); colormap(gca,'cool'); caxis([.25 .35]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
% xlabel('Time with respect to egg-laying event (minutes)'); ylabel('Head to prob distance (mm) of individual egg-laying events'); colorbar;
% 
% figure; hold on; box on; title(title_string);
% standard_error =nanstd(head_to_prob(b,:))./sqrt(length(b));
% mean_data = nanmean(head_to_prob(b,:));
% fill([(0:1:2*window_len),fliplr(0:1:2*window_len)],[mean_data+standard_error,fliplr(mean_data-standard_error)],[0 0 .9],'linestyle','none');
% plot((0:1:2*window_len),nanmean(head_to_prob),'k'); set(gca,'xtick',0:(25*30):window_len*2); set(gca,'xticklabel',(-1.*window_len/25):30:(window_len/25)); set(gca,'xlim',[0, window_len*2]);
% xlabel('Time with respect to egg-laying event (seconds)'); ylabel('Head to prob distance (mm) of all individual egg-laying events with SEM');
% 
% clearvars -except trx eggs title_string


%% Plot various things around an exp start event ordered by exploration duration
% (eliminate boundary condition eggs)

[a , ~] =find(eggs.egg_time > 0);
window_len = 360*25; % window_len on each side in frames
c = [];
f= [];

for i = 1:1:length(a)
    if(eggs.explore_start_time(a(i)) > (window_len+1) && (eggs.explore_start_time(a(i))+window_len) <= length(trx(1,eggs.fly(a(i))).x))
        c = [c a(i)];
                f = [f eggs.fly(a(i))];

    end
end


sp = []; pos = [];  th = []; sub = []; et = [];rt = [];
for i =1:1:length(c)
    sp(i,:) = (trx(1,eggs.fly(c(i))).speed_2hz_hold((eggs.explore_start_time(c(i))-window_len):eggs.explore_start_time(c(i))+window_len));
    et(i) = (eggs.egg_time(c(i))-eggs.explore_start_time(c(i)))./25;
                ovt(i) = (ovu_end_array(c(i))-eggs.explore_start_time(c(i)))./25;

    tip_to_thorax(i,:) = (trx(1,eggs.fly(c(i))).tip_to_thorax((eggs.explore_start_time(c(i))-window_len):eggs.explore_start_time(c(i))+window_len));
    tip_to_thorax_x(i,:) = (trx(1,eggs.fly(c(i))).tip_to_thorax_x((eggs.explore_start_time(c(i))-window_len):eggs.explore_start_time(c(i))+window_len));
    tip_to_thorax_y(i,:) = (trx(1,eggs.fly(c(i))).tip_to_thorax_y((eggs.explore_start_time(c(i))-window_len):eggs.explore_start_time(c(i))+window_len));
    
    thorax_to_head(i,:) = (trx(1,eggs.fly(c(i))).thorax_to_head((eggs.explore_start_time(c(i))-window_len):eggs.explore_start_time(c(i))+window_len));
    thorax_to_head_x(i,:) = (trx(1,eggs.fly(c(i))).thorax_to_head_x((eggs.explore_start_time(c(i))-window_len):eggs.explore_start_time(c(i))+window_len));
    thorax_to_head_y(i,:) = (trx(1,eggs.fly(c(i))).thorax_to_head_y((eggs.explore_start_time(c(i))-window_len):eggs.explore_start_time(c(i))+window_len));
    
    head_to_prob(i,:) = (trx(1,eggs.fly(c(i))).head_to_prob((eggs.explore_start_time(c(i))-window_len):eggs.explore_start_time(c(i))+window_len));
    head_to_prob_x(i,:) = (trx(1,eggs.fly(c(i))).head_to_prob_x((eggs.explore_start_time(c(i))-window_len):eggs.explore_start_time(c(i))+window_len));
    head_to_prob_y(i,:) = (trx(1,eggs.fly(c(i))).head_to_prob_y((eggs.explore_start_time(c(i))-window_len):eggs.explore_start_time(c(i))+window_len));
    
    thorax_to_prob(i,:) = (trx(1,eggs.fly(c(i))).thorax_to_prob((eggs.explore_start_time(c(i))-window_len):eggs.explore_start_time(c(i))+window_len));
    thorax_to_prob_x(i,:) = (trx(1,eggs.fly(c(i))).thorax_to_prob_x((eggs.explore_start_time(c(i))-window_len):eggs.explore_start_time(c(i))+window_len));
    thorax_to_prob_y(i,:) = (trx(1,eggs.fly(c(i))).thorax_to_prob_y((eggs.explore_start_time(c(i))-window_len):eggs.explore_start_time(c(i))+window_len));
    
    head_to_tip(i,:) = (trx(1,eggs.fly(c(i))).head_to_tip((eggs.explore_start_time(c(i))-window_len):eggs.explore_start_time(c(i))+window_len));
    head_to_tip_x(i,:) = (trx(1,eggs.fly(c(i))).head_to_tip_x((eggs.explore_start_time(c(i))-window_len):eggs.explore_start_time(c(i))+window_len));
    head_to_tip_y(i,:) = (trx(1,eggs.fly(c(i))).head_to_tip_y((eggs.explore_start_time(c(i))-window_len):eggs.explore_start_time(c(i))+window_len));
    
end






%% Plot speed 2hz hold things around an egg laying event ordered by exploration duration
[~, b] = sort(et);

figure; imagesc(sp(b,:)); hold on; scatter(1.*(window_len+et(b).*25),1:1:length(et),8,[.5 .5 .5],'filled')
box on; set(gca,'xlim',[0 window_len*2]); title(title_string); colormap(gca,'cool'); caxis([0 5]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
xlabel('Time with respect to explore start event (minutes)'); ylabel('Speed 2 hz hold (mm/sec) of individual egg-laying events'); colorbar;
hold on; scatter(window_len+ovt(b).*25,1:1:length(ovt),8,'k','filled')
set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
box off
set(gca,'TickDir','out')

figure; hold on; box on; title(title_string);
standard_error =nanstd(sp(b,:))./sqrt(length(b));
mean_data = nanmean(sp(b,:));
fill([(0:1:2*window_len),fliplr(0:1:2*window_len)],[mean_data+standard_error,fliplr(mean_data-standard_error)],[0 0 .9],'linestyle','none');
plot((0:1:2*window_len),nanmean(sp),'k'); set(gca,'xtick',0:(25*60):window_len*2); set(gca,'xticklabel',(-1.*window_len/25):60:(window_len/25)); set(gca,'xlim',[0, window_len*2]);
xlabel('Time with respect to explore start event (seconds)'); ylabel('Mean 2 hz hold speed (mm/sec) of all individual egg-laying events with SEM');
set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
box off
set(gca,'TickDir','out')

%% Plot head to tip distance around an egg laying event ordered by exploration duration

[~, b] = sort(et);
figure; imagesc(head_to_tip(b,:)); hold on; scatter(1.*(window_len+et(b).*2),1:1:length(et),8,[.5 .5 .5],'filled')
box on; set(gca,'xlim',[0 window_len*2]); title(title_string); colormap(gca,'cool'); caxis([2.3 2.7]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
xlabel('Time with respect to explore start event (minutes)'); ylabel('Head to tip distance (mm) of individual egg-laying events'); colorbar;
hold on; scatter(window_len+ovt(b).*2,1:1:length(ovt),8,'k','filled')
set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
box off
set(gca,'TickDir','out')

figure; hold on; box on; title(title_string);
standard_error =nanstd(head_to_tip(b,:))./sqrt(length(b));
mean_data = nanmean(head_to_tip(b,:));
fill([(0:1:2*window_len),fliplr(0:1:2*window_len)],[mean_data+standard_error,fliplr(mean_data-standard_error)],[0 0 .9],'linestyle','none');
plot((0:1:2*window_len),nanmean(head_to_tip),'k'); set(gca,'xtick',0:(25*60):window_len*2); set(gca,'xticklabel',(-1.*window_len/25):60:(window_len/25)); set(gca,'xlim',[0, window_len*2]);
xlabel('Time with respect to explore start event (seconds)'); ylabel('Head to tip distance (mm) of all individual egg-laying events with SEM');
set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
box off
set(gca,'TickDir','out')

%% Plot thorax to tip distance around an egg laying event ordered by exploration duration

% [~, b] = sort(et);
% figure; imagesc(tip_to_thorax(b,:)); hold on; scatter(1.*(window_len+et(b).*2),1:1:length(et),8,[.5 .5 .5],'filled')
% box on; set(gca,'xlim',[0 window_len*2]); title(title_string); colormap(gca,'cool'); caxis([1 1.5]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-4','-3','-2','-1','0','1','2','3','4'});
% xlabel('Time with respect to explore start event (minutes)'); ylabel('Thorax to tip distance (mm) of individual egg-laying events'); colorbar;
% 
% figure; hold on; box on; title(title_string);
% standard_error =nanstd(tip_to_thorax(b,:))./sqrt(length(b));
% mean_data = nanmean(tip_to_thorax(b,:));
% fill([(0:1:2*window_len),fliplr(0:1:2*window_len)],[mean_data+standard_error,fliplr(mean_data-standard_error)],[0 0 .9],'linestyle','none');
% plot((0:1:2*window_len),nanmean(tip_to_thorax),'k'); set(gca,'xtick',0:(25*30):window_len*2); set(gca,'xticklabel',(-1.*window_len/25):30:(window_len/25)); set(gca,'xlim',[0, window_len*2]);
% xlabel('Time with respect to explore start event (seconds)'); ylabel('Thorax to tip distance (mm) of all individual egg-laying events with SEM');

%% Plot head to prob distance around an egg laying event ordered by exploration duration

% [~, b] = sort(et);
% figure; imagesc(head_to_prob(b,:)); hold on; scatter(1.*(window_len+et(b).*2),1:1:length(et),8,[.5 .5 .5],'filled')
% box on; set(gca,'xlim',[0 window_len*2]); title(title_string); colormap(gca,'cool'); caxis([.25 .35]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-4','-3','-2','-1','0','1','2','3','4'});
% xlabel('Time with respect to explore start event (minutes)'); ylabel('Head to prob distance (mm) of individual egg-laying events'); colorbar;
% 
% figure; hold on; box on; title(title_string);
% standard_error =nanstd(head_to_prob(b,:))./sqrt(length(b));
% mean_data = nanmean(head_to_prob(b,:));
% fill([(0:1:2*window_len),fliplr(0:1:2*window_len)],[mean_data+standard_error,fliplr(mean_data-standard_error)],[0 0 .9],'linestyle','none');
% plot((0:1:2*window_len),nanmean(head_to_prob),'k'); set(gca,'xtick',0:(25*30):window_len*2); set(gca,'xticklabel',(-1.*window_len/25):30:(window_len/25)); set(gca,'xlim',[0, window_len*2]);
% xlabel('Time with respect to explore start event (seconds)'); ylabel('Head to prob distance (mm) of all individual egg-laying events with SEM');

clearvars -except trx eggs title_string

%% aligning to ovulation end
[a , ~] =find(eggs.egg_time > 0);
window_len = 360*25; % window_len on each side in frames
c = [];
f= [];

for i = 1:1:length(a)
    if(ovu_end_array(a(i)) > (window_len+1) && (ovu_end_array(a(i))+window_len) <= length(trx(1,eggs.fly(a(i))).x))
        c = [c a(i)];
                f = [f eggs.fly(a(i))];

    end
end


sp = []; pos = [];  th = []; sub = []; et = [];rt = [];
for i =1:1:length(c)
    sp(i,:) = (trx(1,eggs.fly(c(i))).speed_2hz_hold((ovu_end_array(c(i))-window_len):ovu_end_array(c(i))+window_len));
    et(i) = (eggs.egg_time(c(i))-eggs.explore_start_time(c(i)))./2;
                ovt(i) = (eggs.egg_time(c(i))-ovu_end_array(c(i)))./2;
    et2(i) = (eggs.explore_start_time(c(i))-ovu_end_array(c(i)))./2;

    tip_to_thorax(i,:) = (trx(1,eggs.fly(c(i))).tip_to_thorax((ovu_end_array(c(i))-window_len):ovu_end_array(c(i))+window_len));
    tip_to_thorax_x(i,:) = (trx(1,eggs.fly(c(i))).tip_to_thorax_x((ovu_end_array(c(i))-window_len):ovu_end_array(c(i))+window_len));
    tip_to_thorax_y(i,:) = (trx(1,eggs.fly(c(i))).tip_to_thorax_y((ovu_end_array(c(i))-window_len):ovu_end_array(c(i))+window_len));
    
    thorax_to_head(i,:) = (trx(1,eggs.fly(c(i))).thorax_to_head((ovu_end_array(c(i))-window_len):ovu_end_array(c(i))+window_len));
    thorax_to_head_x(i,:) = (trx(1,eggs.fly(c(i))).thorax_to_head_x((ovu_end_array(c(i))-window_len):ovu_end_array(c(i))+window_len));
    thorax_to_head_y(i,:) = (trx(1,eggs.fly(c(i))).thorax_to_head_y((ovu_end_array(c(i))-window_len):ovu_end_array(c(i))+window_len));
    
    head_to_prob(i,:) = (trx(1,eggs.fly(c(i))).head_to_prob((ovu_end_array(c(i))-window_len):ovu_end_array(c(i))+window_len));
    head_to_prob_x(i,:) = (trx(1,eggs.fly(c(i))).head_to_prob_x((ovu_end_array(c(i))-window_len):ovu_end_array(c(i))+window_len));
    head_to_prob_y(i,:) = (trx(1,eggs.fly(c(i))).head_to_prob_y((ovu_end_array(c(i))-window_len):ovu_end_array(c(i))+window_len));
    
    thorax_to_prob(i,:) = (trx(1,eggs.fly(c(i))).thorax_to_prob((ovu_end_array(c(i))-window_len):ovu_end_array(c(i))+window_len));
    thorax_to_prob_x(i,:) = (trx(1,eggs.fly(c(i))).thorax_to_prob_x((ovu_end_array(c(i))-window_len):ovu_end_array(c(i))+window_len));
    thorax_to_prob_y(i,:) = (trx(1,eggs.fly(c(i))).thorax_to_prob_y((ovu_end_array(c(i))-window_len):ovu_end_array(c(i))+window_len));
    
    head_to_tip(i,:) = (trx(1,eggs.fly(c(i))).head_to_tip((ovu_end_array(c(i))-window_len):ovu_end_array(c(i))+window_len));
    head_to_tip_x(i,:) = (trx(1,eggs.fly(c(i))).head_to_tip_x((ovu_end_array(c(i))-window_len):ovu_end_array(c(i))+window_len));
    head_to_tip_y(i,:) = (trx(1,eggs.fly(c(i))).head_to_tip_y((ovu_end_array(c(i))-window_len):ovu_end_array(c(i))+window_len));
    
end




%% Plot speed 2hz  things around an egg laying event ordered by exploration duration
[~, b] = sort(ovt);

figure; imagesc(sp(b,:)); hold on; scatter(1.*(window_len+et2(b).*2),1:1:length(et),8,[.5 .5 .5],'filled')
box on; set(gca,'xlim',[0 window_len*2]); title(title_string); colormap(gca,'cool'); caxis([0 5]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
xlabel('Time with respect to ovulation end  event (minutes)'); ylabel('Speed 2hz hold (mm/sec) of individual egg-laying events'); colorbar;
hold on; scatter(window_len+ovt(b).*2,1:1:length(ovt),8,'k','filled')

figure; hold on; box on; title(title_string);
standard_error =nanstd(sp(b,:))./sqrt(length(b));
mean_data = nanmean(sp(b,:));
fill([(0:1:2*window_len),fliplr(0:1:2*window_len)],[mean_data+standard_error,fliplr(mean_data-standard_error)],[0 0 .9],'linestyle','none');
plot((0:1:2*window_len),nanmean(sp),'k'); set(gca,'xtick',0:(25*60):window_len*2); set(gca,'xticklabel',(-1.*window_len/25):60:(window_len/25)); set(gca,'xlim',[0, window_len*2]);
xlabel('Time with respect to ovulation end event (seconds)'); ylabel('Mean speed 2hz hld (mm/sec) of all individual egg-laying events with SEM');
set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
box off
set(gca,'TickDir','out')

%% Plot head to tip distance around an egg laying event ordered by exploration duration

[~, b] = sort(ovt);
figure; imagesc(head_to_tip(b,:)); hold on; scatter(1.*(window_len+et2(b).*2),1:1:length(et),8,[.5 .5 .5],'filled')
box on; set(gca,'xlim',[0 window_len*2]); title(title_string); colormap(gca,'cool'); caxis([2.3 2.7]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xtick',[0:(60*25):window_len*2]); set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
xlabel('Time with respect to ovulation end  event (minutes)'); ylabel('Head to tip distance (mm) of individual egg-laying events'); colorbar;
hold on; scatter(window_len+ovt(b).*2,1:1:length(ovt),8,'k','filled')

figure; hold on; box on; title(title_string);
standard_error =nanstd(head_to_tip(b,:))./sqrt(length(b));
mean_data = nanmean(head_to_tip(b,:));
fill([(0:1:2*window_len),fliplr(0:1:2*window_len)],[mean_data+standard_error,fliplr(mean_data-standard_error)],[0 0 .9],'linestyle','none');
plot((0:1:2*window_len),nanmean(head_to_tip),'k'); set(gca,'xtick',0:(25*60):window_len*2); set(gca,'xticklabel',(-1.*window_len/25):60:(window_len/25)); set(gca,'xlim',[0, window_len*2]);
xlabel('Time with respect to ovulation end event (seconds)'); ylabel('Head to tip distance (mm) of all individual egg-laying events with SEM');
set(gca,'xticklabel',{'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'});
box off
set(gca,'TickDir','out')