% Function that calculates the stream potential for a mesh in the case of
% source or sink
% AUTHOR: Declan Walsh

% ARGUMENTS
% gamma = strength of source (+) or sink (-)
% x = x co-ordinates of all points in grid
% y = y co-ordinates of all points in grid

% OUTPUTS
% potS = stream potential at each grid point

function [ potS ] = potSource( gamma, x, y)

% map Cartesian to polar co-ordinates
r = (x.^2 + y.^2).^(0.5);
theta = atan(y./x);

potS = gamma/(2*pi)*log(r);
potS = potS.*(r~=0); % removes the infinite error with log(r = 0)

end