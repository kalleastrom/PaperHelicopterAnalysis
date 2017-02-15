function [angularFreq,stdAngFreq,angFreqs] ...
                     = readvideo2(file,fps,startFrame,endFrame,plotting,...
                                  cropx,cropy)
%READVIDEO reads video of paper helicopter and calculates rotation
% This version calculates angular frequency as the mean value betweeen
% startFrame and endFrame
%
% INPUT
% file  (string)        :   Name and path to video file
% fps   (integer)       :   Number of frames per second in video
% startFrame (integer)  :   Cuts all frames up to this number
%                           (Set '1' to start on the first frame)
% endFrame (integer)    :   Cuts all frames after this number
%                           (Set 'inf' to go through all frames)
% plotting (true/false) :   Enable/disable plotting feature
% ------------  The following input arguments are optional  ---------------
% cropx (double array)  :   Cropping of the video, given on the format
%                           [firstpixel:lastpixel]
% cropy (double array)  :   Cropping of the video, given on the format
%                           [firstpixel:lastpixel]
%
% OUTPUT
% angular_freq          :   Calculated value of angular frequency
%
% Created 2017-02-03 by
% Olle Alvin, Jonathan Astermark, Julia H. Fovaeus, John Hellborg

if nargin == 5
    cropping = false;
elseif nargin == 7
    cropping = true;
else
    error('Invalid number of input arguments in readvideo')
end

% Read video file
v = VideoReader(file);
ctr = 1;

% Discard all frames up to 'startFrame'
fprintf('Discarding first %d frames...\n',startFrame-1)
while hasFrame(v) && ctr < startFrame
    frame = readFrame(v);
    clear frame
    ctr = ctr+1;
end

% If plotting is enabled, prepare figure
if plotting
   figure(1)
   clf
end

% If possible, preallocate the array 'relAngles'
if isfinite(endFrame)
    relAngles = zeros(1,endFrame-startFrame+1);
end

timePerFrame = 1/fps;
while hasFrame(v) && ctr <= endFrame
    frame = readFrame(v);
    if cropping
        frame = frame(cropx,cropy,:);
    end
    frame = rgb2gray(frame);
    T = (frame>180);
    if ~max(max(T)) % All pixels zero, i.e. no helicopter found at all
        warning('Terminating video because helicopter was not found.')
        break       % Step out of loop
    end
    clear frame
    [angle,c,vec] = angleCalc(T);
    
    % Save angle on first frame, otherwise calculate relative angle
    if ctr == startFrame
        startAngle = angle;
        relAngle = 0;
        time = 0;
    else
        relAngle = angle-startAngle;
    end
    % Half period completed when the relative angle crosses zero, but not
    % by a fold-around
%     if ((relAngle > 0 && relAnglePrev < 0) ...
%              || (relAngle < 0 && relAnglePrev > 0)) ...
%             && abs(relAngle - relAnglePrev) < pi/4 ... % fold-around
%             % Alternative: add && ~found to only look for first value
% %         ctr
% 
%             % Start new measurement
%             startAngle = angle;
%             relAngle = 0;
%     end
    if plotting
%     imshow(grayimg)
%     imagesc(grayimg)
        figure(1)
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
        title(['Helicopter number ', num2str(i), '\n',...
               'frame: ',num2str(ctr), ', t = ',...
               num2str(time),' s, relAngle: ',num2str(relAngle)])
        pause(0.01)
%         pause
    end
    relAngles(ctr-startFrame+1) = relAngle;
%     angleVec(ctr) = angle;
    time = time + timePerFrame;
%     timeSinceReset = timeSinceReset + timePerFrame;
    ctr = ctr+1;
end
clear v frame T 
angFreqs = normangle2(diff(relAngles))/timePerFrame;

if false
    figure(2)
    clf
    plot(relAngles)
    title('Sampled angle per frame, relative starting angle')
    ylabel('Angle relative start poistion [rad]')
end
figure(3)
clf
plot((startFrame+1):(ctr-1),angFreqs,'*')
% ylim([30 60])
title('Angular frequency per frame')
ylabel('Angular frequency [rad/s]')
xlabel('Frame')
axis manual % freeze axis

print -depsc plots/ang_freq.eps

% Let the user pick the interval in which to calculate mean
fprintf(['Set starting point for mean calculation by clicking in the ',...
         'plot.\n'])
startMeanIndex = -Inf;
endMeanIndex = -Inf;
while startMeanIndex < 0
    [startMeanVal,~] = ginput(1);
    startMeanIndex = ceil(startMeanVal-(startFrame-1))
end
line([startMeanVal startMeanVal],ylim,'Color','k')
fprintf('Set end point for mean calculation by clicking in the plot.\n')
while endMeanIndex < startMeanIndex
    [endMeanVal,~] = ginput(1);
    endMeanIndex = floor(endMeanVal-(startFrame-1))
end
line([endMeanVal endMeanVal],ylim,'Color','k')

fprintf('Averaging over %d frames.\n',endMeanIndex-startMeanIndex+1)
angularFreq = mean(angFreqs(startMeanIndex:endMeanIndex));
stdAngFreq = std(angFreqs(startMeanIndex:endMeanIndex));

if ~isfinite(angularFreq)
    error('No finite angular frequency could be calculated.')
end

end
