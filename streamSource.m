% Function that calculates the stream function for a mesh in the case of
% source or sink
% AUTHOR: Declan Walsh

% ARGUMENTS
% gamma = strength of source (+) or sink (-)
% x = x co-ordinates of all points in grid
% y = y co-ordinates of all points in grid

% OUTPUTS
% potDoub = stream function at each grid point

function [ streamS ] = streamSource(gamma, x, y)

% map Cartesian to polar co-ordinates
r = (x.^2 + y.^2).^(0.5);
theta = atan(y./x); % theta is in radians

streamS = gamma/(2*pi)*theta;

end
