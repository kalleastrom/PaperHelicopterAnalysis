% Evaluates videos of prototypes.

% Toggle whether to save .eps
saveplot = true;

% Files must be called 'top1.mp4', 'top2.mp4' etc.
video_folder = '../../Filmer/Prototypes/';

% Load geometry
load('../data/prototypes.mat')

% Calculate 
fps = 119; % Camera specific
startFrame = 1;
endFrame = Inf;
plotting = true; % Toggle plotting true/false

% Preallocate arrays
angular_freq = zeros(1,11);
freq_std = zeros(1,11);

% if saveplot
%     figure(4)
% end
for i=2:2
    if i~=6 % file 6 does not exist right now
        file = [video_folder, 'top', num2str(i), '.mp4'];
        [angular_freq(i),freq_std(i),~] = readvideo2(file,fps,startFrame,...
                                                 endFrame,plotting);
%         if saveplot
%             figure(4)
%             plot(startFrame:(startFrame-1)+length(angFreqs),angFreqs,'*')
%             title('Angular frequency per frame')
%             ylabel('Angular frequency [rad/s]')
%             xlabel('Frame')
%             plotname = ['plots/ang_freq_heli_' num2str(i) '.eps'];
%             eval(['print -depsc ' plotname]);
%         end
    end
end

