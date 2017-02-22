% Evaluates videos of prototypes. Uncut videos
% Files must be called 'Helicopter1Top.mp4' etc.

% Toggle whether to save .eps
saveplot = true;

% Specify folder for videos
video_folder = '../../Filmer/';

% Load geometry
load('../data/prototypes.mat')

% Global parameters 
fps = 119; % Camera specific
plotting = true; % Toggle plotting true/false

% Preallocate arrays
angular_freq = zeros(1,11);
freq_std = zeros(1,11);

for i=6:11
    
    % Default parameters
    startFrame = 1;
    endFrame = Inf;
    cropx = 200:550;
    cropy = 400:800;
    
    % If neccessary, change video-specific parameters
    switch i
        case 1
            endFrame = 140;
        case 2
            endFrame = 150;
        case 3
            startFrame = 40;
            endFrame = 170;
        case 4
            startFrame = 120;
            endFrame = 290;
        case 5 
            startFrame = 100;
            endFrame = 240;
        case 6
            startFrame = 150;
            endFrame = 340;
        case 7
            startFrame = 150;
            endFrame = 310;
        case 8
            startFrame = 120;
            endFrame = 280;
        case 9
            startFrame = 130;
            endFrame = 310;
        case 10
            startFrame = 200;
            endFrame = 360;
            cropy = 400:900;
        case 11
            startFrame = 80;
            endFrame = 270;
    end
    
    fprintf(['Reading video ' num2str(i) '\n'])
    file = [video_folder, 'Helicopter', num2str(i), 'Top.mp4'];
    [angular_freq(i),freq_std(i),~] = readvideo2(file,fps,startFrame,...
                                            endFrame,plotting,cropx,cropy);
end

