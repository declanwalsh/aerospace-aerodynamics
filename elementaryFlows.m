% Script that uses potential and stream function methods to plot the four
% elementary flow field cases
% AUTHOR: Declan Walsh

close all
clear all

MIN = -2;
MAX = 2;
INCREMENT = 0.11;

NUM_LINES = 10;

VELOCITY = 1; % strength of uniform flow
GAMMA = 1; % strength of source
KAPPA = 1; % strength of doublet
CIRCULATION = 1; % strength of circulation

[x, y] = meshgrid(MIN:INCREMENT:MAX, MIN:INCREMENT:MAX); % create x, y system

%% UNIFORM FLOW
potUni = potUniform(VELOCITY, x, y);
streamUni = streamUniform(VELOCITY, x, y);

subplot(4, 2, 1)
contour(x, y, potUni, NUM_LINES)
title('Uniform Potential');

subplot(4, 2, 2)
contour(x, y, streamUni, NUM_LINES)
title('Uniform Streamline');

%% SOURCE FLOW
potS = potSource(GAMMA, x, y);
streamS = streamSource(GAMMA, x, y);

subplot(4, 2, 3)
contour(x, y, potS, NUM_LINES)
title('Source Potential');

subplot(4, 2, 4)
contour(x, y, streamS, NUM_LINES)
title('Source Streamline');

%% DOUBLET FLOW
potDoub = potDoublet(KAPPA, x, y);
streamDoub = streamDoublet(KAPPA, x, y);

subplot(4, 2, 5)
contour(x, y, potDoub, NUM_LINES)
title('Doublet Potential');

subplot(4, 2, 6)
contour(x, y, streamDoub, NUM_LINES)
title('Doublet Streamline');

%% VORTEX FLOW
potVor = potVortex(CIRCULATION, x, y);
streamVor = streamVortex(CIRCULATION, x, y);

subplot(4, 2, 7)
contour(x, y, potVor, NUM_LINES)
title('Vortex Potential');

subplot(4, 2, 8)
contour(x, y, streamVor, NUM_LINES)
title('Vortex Streamline');
