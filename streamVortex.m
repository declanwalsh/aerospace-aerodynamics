% Function that calculates the stream function for a mesh in the case of
% vortex
% AUTHOR: Declan Walsh

% ARGUMENTS
% circulation = strength of vortex
% x = x co-ordinates of all points in grid
% y = y co-ordinates of all points in grid

% OUTPUTS
% streamVor = stream function at each grid point

function [ streamVor ] = streamVortex( circulation, x, y)

% map Cartesian to polar co-ordinates
r = (x.^2 + y.^2).^(0.5);
theta = atan(y./x);

streamVor = circulation/(2*pi)*log(r);
streamVor = streamVor.*(r~=0); % removes error with log(r=0)

end
