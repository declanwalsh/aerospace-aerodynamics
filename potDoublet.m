% Function that calculates the stream potential for a mesh in the case of
% doublet (coincident source and sink)
% AUTHOR: Declan Walsh

% ARGUMENTS
% kappa = strength of doublet
% x = x co-ordinates of all points in grid
% y = y co-ordinates of all points in grid

% OUTPUTS
% potDoub = stream potential at each grid point

function [ potDoub ] = potDoublet( kappa, x, y)

% map Cartesian to polar co-ordinates
r = (x.^2 + y.^2).^(0.5);
theta = atan(y./x);

potDoub = kappa/(2*pi)*cos(theta)./r;

end