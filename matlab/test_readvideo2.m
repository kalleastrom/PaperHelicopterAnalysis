% Testing script for readvideo2.m
% Created 2017-02-11
%

clear all

file = '../data/top9.mp4'; % Videos should be in '../data/'

fps = 119; % Camera specific
startFrame = 1;
endFrame = Inf;
%cropx = 300:520; % optional cropping
%cropy = 300:980; % optional cropping

plotting = true; % Toggle plotting true/false
% pauseTime = 0.05; % Set how many seconds to display each frame

[angular_freq,std,angleVec]=readvideo2(file,fps,startFrame,endFrame,...
                                       plotting);

fprintf('Average angular frequency: %f rad/s\n',angular_freq)
fprintf('Standard deviation: %f rad/s\n',std)

% angleVec = angleVec.';
% angDiff = angleVec - circshift(angleVec,1); 
% figure(2)
% plot(angleVec)
% figure(3)
% rotSpeeds = normangle2(angDiff)*119;
% plot(rotSpeeds, '*')

