startFrame = 50;
fps = 119;

v = VideoReader('../data/test_microrum.mp4');
ctr = 0;
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
    ctr = ctr+1;
    title(['frame: ',num2str(ctr), ', t = ', num2str(time),' s, angle: ',num2str(angle)])
    time = time + timePerFrame;
    pause
end
error(['Video ended before a value was calculated.\n',...
      ' Consider reducing value of startFrame.'])