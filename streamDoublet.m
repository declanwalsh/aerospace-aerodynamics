% Function that calculates the stream function for a mesh in the case of
% doublet (coincident source and sink)
% AUTHOR: Declan Walsh

% ARGUMENTS
% kappa = strength of doublet
% x = x co-ordinates of all points in grid
% y = y co-ordinates of all points in grid

% OUTPUTS
% streamDoub = stream function at each grid point

function [ streamDoub ] = streamDoublet( kappa, x, y)

% map Cartesian to polar co-ordinates
r = (x.^2 + y.^2).^(0.5);
theta = atan(y./x);

streamDoub = -kappa/(2*pi)*sin(theta)./r;

end
