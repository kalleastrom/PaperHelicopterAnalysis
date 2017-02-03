function [angular_freq] = readvideo(file,fps,startFrame,plotting)
%READVIDEO reads video of paper helicopter and calculates rotation
%
% INPUT
% file  (string)        :   Name and path to video file
% fps   (integer)       :   Number of frames per second in video
% startFrame (integer)  :   Cuts all frames up to this number
% plotting (true/false) :   Enable/disable plotting feature
%
% OUTPUT
% angular_freq          :   Calculated value of angular frequency
%
% Created 2017-02-03 by
% Olle Alvin, Jonathan Astermark, Julia H. Fovaeus, John Hellborg

v = VideoReader(file);

% startFrame = 50;
% fps = 119;
% 
% v = VideoReader('../data/test_microrum.mp4');

ctr = 1;
fprintf('Discarding first %d frames.\n',startFrame-1)
while hasFrame(v) && ctr < startFrame
    frame = readFrame(v);
    ctr = ctr+1;
end
time = 0;
timePerFrame = 1/fps;
while hasFrame(v)
    frame = readFrame(v);
    croppedframe = frame(200:520,300:980,:);
    grayimg = rgb2gray(croppedframe);
    T = (grayimg>180);
    [angle,c,vec] = angleCalc(T);
    % Save angle on first frame
    if ctr == startFrame
        startAngle = angle;
    end
    if plotting
        figure(1)
%     imshow(grayimg)
%     imagesc(grayimg)
        colormap(gray)
        imagesc(T)
        %%%%%%%%%%%
        hold on
        p1 = c;
        p2 = c + vec*100;
        p3 = c + vec*(-100);
        plot(p1(1),p1(2), '*r')
        line([p1(1) p2(1)], [p1(2) p2(2)])
        line([p1(1) p3(1)], [p1(2) p3(2)])
        %%%%%%%%
        title(['frame: ',num2str(ctr), ', t = ',...
               num2str(time),' s, angle: ',num2str(angle)])
%         fprintf('Paused, press any button for next frame.\n')
        pause(0.05)
    end
    % TODO: If full period completed, stop and calculate velocity
%     angle-startAngle
%     if angle <= startAngle && ctr ~= startFrame
%         elapsedTime = time;
%         angular_freq = 2*pi/elapsedTime;
%         return
%     end
    time = time + timePerFrame;
    ctr = ctr+1;
end

error(['Video ended before a value was calculated.\n',...
      ' Consider reducing value of startFrame.'])
end