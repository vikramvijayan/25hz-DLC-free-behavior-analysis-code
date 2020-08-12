function [out] = deeplabcut_freebehavior_toavi(moviename, start_frame, end_frame, csv, chrimson)

% where the first frame is frame 0
show_progress = 1;

% add wait bar
if show_progress
    bar_handle = waitbar(0,'writing');
end


vid = VideoReader([moviename '.avi']);
vid_fr = vid.FrameRate;

vid_out = VideoWriter([moviename '_DLC_full_46568_56762.avi']);
vid_out.FrameRate = vid_fr;

open(vid_out);


[bodypart]= importDeepLabCutfile_VV(csv, 4, inf);
bodypart = bodypart(2:61,:);

%clrz = linspecer(4);
clrz = [255,0,255; 255,0,102]./255;

figure; hold on;

current_time = start_frame./vid_fr - 1./vid_fr;
vid.CurrentTime = current_time;

for frames = start_frame:1:end_frame
    
    
    axes(gca); hold on; %cla('reset'); hold on;
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
        scatter(bodypart(i,frames),bodypart(i+1,frames),5,clrz(cnt,:),'filled');
        %scatter(bodypart(i,frames),bodypart(i+1,frames),5,clrz(cnt,:),'filled');
                cnt = cnt+1;

                i=25;
        scatter(bodypart(i,frames),bodypart(i+1,frames),5,clrz(cnt,:),'filled');

        if(chrimson(frames) > 0)
            scatter(100,100,75,'r','filled');
        end
        
  %  end
    
    frame_out = getframe(gcf);
    writeVideo(vid_out,frame_out);
    
    
    
end

%close(vid);
close(vid_out);



if show_progress
    close(bar_handle)
end

out =1;
