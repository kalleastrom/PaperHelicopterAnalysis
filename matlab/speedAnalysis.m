% This script can used to go through the frames of a video by hand. Olles
% results of the helicopter falling speeds are down below.

mov = VideoReader('Hel8.mp4') %Set peth to video file here.
frameTime = 1/mov.FrameRate

numFrames = mov.NumberOfFrames;
figure
k = 1;
w=0;
while true
    imshow(read(mov, k));
    title(['frame: '  num2str(k)])
    
    w = waitforbuttonpress;
    val=double(get(w,'CurrentCharacter')); 
    if val == 28
        if k > 1 
            k = k-1;
            w=0,
        end
    end
    if val == 29
        if k < numFrames
            k = k+1;
            w=0;
        end
        
    end
    w=0;
end

%% Olles results

frames = [26 28 27 30 21 30 28 27 35 29 30];
times = frames*0.0084;
speeds = 0.5./times
