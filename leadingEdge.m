% Script that uses potential and stream function methods to plot the flow
% field about the leading edge
% AUTHOR: Declan Walsh

close all
clear all

MIN = -3;
MAX = 3;
INCREMENT = 0.1;

VELOCITY = 4;
CIRCULATION = 2;

[x, y] = meshgrid(MIN:INCREMENT:MAX, MIN:INCREMENT:MAX); % create x, y system

% CALCULATE THE POTENTIAL FUNCTION
potLE = potUniform(VELOCITY, x, y) + potSource(CIRCULATION, x, y);
figure;
contour(x, y, potLE)
title('Stream Potential about Leading Edge');

% CALCULATE THE STREAM FUNCTION
streamLE = streamUniform(VELOCITY, x, y) + streamSource(CIRCULATION, x, y);
figure;
contour(x, y, streamLE)
title('Stream Function about Leading Edge');