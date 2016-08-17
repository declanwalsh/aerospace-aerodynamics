% Script that uses potential and stream function methods to plot the flow
% field about a rankine circle
% AUTHOR: Declan Walsh

close all
clear all

MIN = -10;
MAX = 10;
INCREMENT = 0.1;

NUM_LINES = 10;

VELOCITY = 4;
CIRCULATION = 2;
SEPARATION = 2;

[x, y] = meshgrid(MIN:INCREMENT:MAX, MIN:INCREMENT:MAX); % create x, y system

% CALCULATE THE POTENTIAL FUNCTION
potRankine = potUniform(VELOCITY, x, y) + potSource(CIRCULATION, x-SEPARATION/2, y) + potSource(-CIRCULATION, x + SEPARATION/2, y);
figure;
contour(x, y, potRankine, NUM_LINES)
title('Stream Potential about Rankine Oval');

% CALCULATE THE STREAM FUNCTION
streamRankine = streamUniform(VELOCITY, x, y) + streamSource(CIRCULATION, x-SEPARATION/2, y) + streamSource(-CIRCULATION, x+SEPARATION/2, y);
figure;
contour(x, y, streamRankine, NUM_LINES)
title('Stream Function about Rankine Oval');