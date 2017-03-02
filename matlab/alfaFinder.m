% This script can used to go through the frames of a video by hand. Olles
% results of the helicopter falling speeds are down below.

mov = VideoReader('\..\data\Hel5tag2.mp4') %Set path to video file here.
frameTime = 1/mov.FrameRate

numFrames = mov.NumberOfFrames;
figure(1)
k = 1;
w=0;
while true
    imshow(read(mov, k));
    tmp = k;
    title(['frame: '  num2str(k)]);
   
    w = waitforbuttonpress;
    figure(1)
    try
        val=double(get(w,'CurrentCharacter')); 
    catch
        val=0;
    end
 
    if val == 28
        if k > 1 
            k = k-1;
            w=0;
        end
    end
    if val == 29
        if k < numFrames
            k = k+1;
            w=0;
        end
        
    end
    if val == 31
        k=tmp;
        break
    end
end
    figure(1)
    imshow(read(mov, k));

    hold on
    title('set body reference line')
    [firstX,firstY] = ginput(1);
    plot(firstX,firstY,'*');
    [secondX,secondY] = ginput(1);
    plot([firstX secondX], [firstY secondY]);
    v1 = [firstX-secondX firstY-secondY];
    
    title('set wing line')
   [firstX,firstY] = ginput(1);
    plot(firstX,firstY,'*');
    [secondX,secondY] = ginput(1);
    plot([firstX secondX], [firstY secondY]);
    v2 = [firstX-secondX firstY-secondY];
    theta = acos(dot(v1,v2)/(norm(v1)*norm(v2)));
    theta = theta - pi/2
    alfa = 180/pi * theta

    
%% Olles results

%frames = [26 28 27 30 21 30 28 27 35 29 30];
%times = frames*0.0084;
%speeds = 0.5./times
