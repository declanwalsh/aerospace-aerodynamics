% Script to demonstrate flow over a non-lifting cylinder using potential
% and stream function methods
% AUTHOR: Declan Walsh

close all
clear all

MIN = -3;
MAX = 3;
INCREMENT = 0.1;

VELOCITY = 5;
CIRCULATION = 1;
KAPPA = 5;

[x, y] = meshgrid(MIN:INCREMENT:MAX, MIN:INCREMENT:MAX); % create x, y system

% CALCULATE THE POTENTIAL FUNCTION
psiCylinder = potUniform(VELOCITY, x, y) + potDoublet(KAPPA, x, y);
figure;
contour(x, y, psiCylinder)
title('Stream Potential about Cylinder');

% CALCULATE THE STREAM FUNCTION
phiCylinder = streamUniform(VELOCITY, x, y) + streamDoublet(KAPPA, x, y);
figure;
contour(x, y, phiCylinder)
title('Stream Function about Cylinder');