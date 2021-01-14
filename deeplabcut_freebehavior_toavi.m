% sample call
% [out] = deeplabcut_freebehavior_toavi('fly8_ALL_ffmpeg', 46000, 58000, 'fly8_ALL_ffmpegDeepCut_resnet50_GPU_07232019Jul23shuffle1_1030000.csv', zeros(1,100000),smoothdata(trx(1,3).speed_2hz_hold(46000:1:58000),'movmean',125),smoothdata(trx(1,3).head_to_tip(46000:1:58000),'movmean',125))
% [out] = deeplabcut_freebehavior_toavi('fly8_ALL_ffmpeg', 49604-480*25+9000, 49604-480*25+21000, 'fly8_ALL_ffmpegDeepCut_resnet50_GPU_07232019Jul23shuffle1_1030000.csv', zeros(1,100000),smoothdata(trx(1,3).speed_2hz_hold((49604-480*25+9000):1:(49604-480*25+21000)),'movmean',125),smoothdata(trx(1,3).head_to_tip((49604-480*25+9000):1:(49604-480*25+21000)),'movmean',125))
function [out] = deeplabcut_freebehavior_toavi(moviename, start_frame, end_frame, csv, chrimson, trace1, trace2)

% where the first frame is frame 0
show_progress = 1;

% add wait bar
if show_progress
    bar_handle = waitbar(0,'writing');
end


vid = VideoReader([moviename '.avi']);
vid_fr = vid.FrameRate;

vid_out = VideoWriter([moviename '_DLC_full_iteration8_46604_58604_filt_unfilled.avi']);
vid_out.FrameRate = vid_fr;

open(vid_out);


[bodypart]= importDeepLabCutfile_VV(csv, 4, inf);
bodypart = bodypart(2:61,:);

for i = 2:1:(length(bodypart(19,:)))
    if(bodypart(21,i) < .95 || abs(bodypart(19,i)-bodypart(19,i-1)) > 10)
        bodypart(19,i) = NaN;
        bodypart(20,i) = NaN;
    end
    if(bodypart(21,i) < .95 || abs(bodypart(20,i)-bodypart(20,i-1)) > 10)
        bodypart(19,i) = NaN;
        bodypart(20,i) = NaN;
    end
    
    if(bodypart(24,i) < .95 || abs(bodypart(22,i)-bodypart(22,i-1)) > 10)
        bodypart(22,i) = NaN;
        bodypart(23,i) = NaN;
    end
    if(bodypart(24,i) < .95 || abs(bodypart(23,i)-bodypart(23,i-1)) > 10)
        bodypart(22,i) = NaN;
        bodypart(23,i) = NaN;
    end
    
    if(bodypart(27,i) < .95 || abs(bodypart(25,i)-bodypart(25,i-1)) > 10)
        bodypart(25,i) = NaN;
        bodypart(26,i) = NaN;
    end
    if(bodypart(27,i) < .95 || abs(bodypart(26,i)-bodypart(26,i-1)) > 10)
        bodypart(25,i) = NaN;
        bodypart(26,i) = NaN;
    end
    
    if(bodypart(30,i) < .1 || abs(bodypart(28,i)-bodypart(28,i-1)) > 50)
        bodypart(29,i) = NaN;
        bodypart(28,i) = NaN;
    end
    if(bodypart(30,i) < .1 || abs(bodypart(29,i)-bodypart(29,i-1)) > 50)
        bodypart(29,i) = NaN;
        bodypart(28,i) = NaN;
    end
end



%clrz = linspecer(4);
clrz = [255,0,255; 255,0,102]./255;

figure('Renderer', 'painters', 'Position', [10 10 500 600]); hold on; subplot(10,1,1:8);

current_time = start_frame./vid_fr - 1./vid_fr;
vid.CurrentTime = current_time;

for frames = start_frame:1:end_frame
    
    
    subplot(10,1,1:8); hold on;  axes(gca); hold on; %cla('reset'); hold on;
    axesHandlesToChildObjects = findobj(gca, 'Type', 'image');
    if ~isempty(axesHandlesToChildObjects)
        delete(axesHandlesToChildObjects);
    end
    
    axesHandlesToChildObjects = findobj(gca, 'Type', 'scatter');
    if ~isempty(axesHandlesToChildObjects)
        delete(axesHandlesToChildObjects);
    end
    
    if show_progress
        waitbar((frames-start_frame)/(end_frame-start_frame), bar_handle, sprintf('writing %d/%d',(frames-start_frame),(end_frame-start_frame)))
    end
    

    
    vidFrame = readFrame(vid);
    subplot(10,1,1:8); hold on; 
    imshow(vidFrame); hold on;
    %    imshow(vidFrame,[0, 255],'Colormap',gray(1000)); hold on;
    %
    axis tight;
    set(gca,'xtick',[]);
    set(gca,'ytick',[]);
    
    
    cnt = 0;
    % for i =1:3:28
    %for i =19:3:28
    cnt = cnt+1;
    i=19;
    %                 if(bodypart(i+2,frames) >= .95)
    %                     scatter(bodypart(i,frames),bodypart(i+1,frames),5,clrz(cnt,:),'filled');
    %                 end
    %%scatter(bodypart(i,frames),bodypart(i+1,frames),5,clrz(cnt,:));
    %scatter(bodypart(i,frames),bodypart(i+1,frames),5,clrz(cnt,:),'filled');
    cnt = cnt+1;
    
    i=25;
    %%scatter(bodypart(i,frames),bodypart(i+1,frames),5,clrz(cnt,:));
    
    if(chrimson(frames) > 0)
        scatter(100,100,75,'r','filled');
    end
    
    %  end
    
    
        ovu = [44268;47931;52172;54916;58681];
    egg = [45720;49604;52790;56229;[60021]];
    
    
    time_base = (start_frame:1:end_frame)./25;
    hold on; subplot(10,1,9); hold on;
    set(gca,'TickDir','out');
    if(frames == start_frame)
        plot((start_frame:1:end_frame)./25, trace1,'color',[.5 .5 .5]);
        for qqqq = 1:1:length(ovu)
            line([ovu(qqqq)./25 ovu(qqqq)./25], [-100,100],'color','k');
            line([egg(qqqq)./25 egg(qqqq)./25], [-100,100],'color','r');
        end
           set(gca, 'xlim',[time_base(1), time_base(end)]);
    set(gca,'xtick',[])
    set(gca, 'ylim',[0 3]);
    end
    
    if(frames ~= start_frame)
        children = get( gca, 'children');
        delete(children(1));
    end
    
    
    line([frames./25 frames./25], [-100,100],'color','m');
    
 
    

    hold on; subplot(10,1,10); hold on;
    set(gca,'TickDir','out');
    
    if(frames == start_frame)
        plot((start_frame:1:end_frame)./25, trace2,'color',[.5 0 .5]);
        for qqqq = 1:1:length(ovu)
            line([ovu(qqqq)./25 ovu(qqqq)./25], [-100,100],'color','k');
            line([egg(qqqq)./25 egg(qqqq)./25], [-100,100],'color','r');
                set(gca, 'xlim',[time_base(1), time_base(end)]);    
    set(gca, 'ylim',[2.1 2.9]);
        end
        
    end
    
    if(frames ~= start_frame)
        children = get( gca, 'children');
        delete(children(1));
    end
    
        line([frames./25 frames./25], [-100,100],'color','m');


        drawnow; 

    frame_out = getframe(gcf);
    writeVideo(vid_out,frame_out);
    
    
    
end

%close(vid);
close(vid_out);



if show_progress
    close(bar_handle)
end

out =1;
