% Function that calculates the stream potential for a mesh in the case of
% vortex
% AUTHOR: Declan Walsh

% ARGUMENTS
% circulation = strength of vortex
% x = x co-ordinates of all points in grid
% y = y co-ordinates of all points in grid

% OUTPUTS
% potVor = stream potential at each grid point

function [ potVor ] = potVortex( circulation, x, y)

% map Cartesian to polar co-ordinates
r = (x.^2 + y.^2).^(0.5);
theta = atan(y./x);

potVor = -circulation/(2*pi)*theta;

end
