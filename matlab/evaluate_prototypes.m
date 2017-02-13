% Evaluates videos of prototypes.
% Files must be called 'top1.mp4', 'top2.mp4' etc.
video_folder = '../../Filmer/Prototypes/';

% Load geometry
load('../data/prototypes.mat')

% Calculate 
fps = 119; % Camera specific
startFrame = 1;
endFrame = Inf;
plotting = true; % Toggle plotting true/false

angular_freq = zeros(1,11);
freq_std = zeros(1,11);
for i=1:11
    if i~=6 % file 6 does not exist right now
        file = [video_folder, 'top', num2str(i), '.mp4'];
        [angular_freq(i),freq_std(i),~] = readvideo2(file,fps,startFrame,...
                                                 endFrame,plotting);
    end
end

