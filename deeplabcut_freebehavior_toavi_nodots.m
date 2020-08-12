function [out] = deeplabcut_freebehavior_toavi_nodots(moviename, allframes)



vid = VideoReader([moviename '.avi']);
vid_fr = vid.FrameRate;

vid_out = VideoWriter([moviename '_DLC_round6.avi']);
vid_out.FrameRate = vid_fr;

open(vid_out);






for frames = 1:1:length(allframes)
    
    current_time = allframes(frames)./vid_fr-1./vid_fr;
    vid.CurrentTime = current_time;
    
    
    vidFrame = readFrame(vid);
    writeVideo(vid_out,vidFrame);

end


close(vid_out);

out =1;

end

%close(vid);


