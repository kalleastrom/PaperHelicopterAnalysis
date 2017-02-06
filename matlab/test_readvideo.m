% Testing script for readvideo.m
% Created 2017-02-03
% Serves the same purpose as readvideo did before 2017-02-03
% but now uses the fact that readvideo is a function
%
clear all

file = '../data/test_microrum.mp4'; % Videos should be in '../data/'
fps = 119; % Camera specific
startFrame = 50;
cropx = 300:520;
cropy = 300:980;

plotting = true; % Toggle plotting
stop = false;     % Toggle whether the script terminates immediately after
                 % an angular frequency is found

angular_freq = readvideo(file,fps,startFrame,plotting,stop,cropx,cropy);
fprintf('Highest angular frequency: %f rad/s\n',angular_freq)