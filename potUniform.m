% Function that calculates the stream potential for a mesh in the case of
% uniform flow
% AUTHOR: Declan Walsh

% ARGUMENTS
% velocity = freestream velocity
% x = x co-ordinates of all points in grid
% y = y co-ordinates of all points in grid

% OUTPUTS
% potUni = stream potential at each grid point

function [ potUni ] = potUniform( velocity, x, y)

potUni = velocity*x;

end

