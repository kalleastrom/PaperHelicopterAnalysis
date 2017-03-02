%%

file = '../../Filmer/Helicopter1Top.mp4';

v = VideoReader(file);
ctr = 1;
frame = readFrame(v);
figure(1)
imagesc(frame)
print -depsc plots/filming_top.eps

%%

file = '../../Filmer/Hel1.mp4';
startFrame = 50;

v = VideoReader(file);
ctr = 1;
while hasFrame(v) && ctr < startFrame
    frame = readFrame(v);
    clear frame
    ctr = ctr+1;
end

frame = readFrame(v);
figure(1)
% imagesc(frame)
imagesc(frame)
print -depsc plots/filming_side.eps