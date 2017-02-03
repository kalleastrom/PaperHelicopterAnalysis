% Testing script for readvideo.m
% Created 2017-02-03
% Serves the same purpose as readvideo did before 2017-02-03
% but now uses the fact that readvideo is a function
%


file = '../data/test_microrum.mp4';
fps = 119;
startFrame = 50;
plotting = true;

angular_freq = readvideo(file,fps,startFrame,plotting)