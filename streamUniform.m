% Function that calculates the stream function for a mesh in the case of
% uniform flow
% AUTHOR: Declan Walsh

% ARGUMENTS
% velocity = freestream velocity
% x = x co-ordinates of all points in grid
% y = y co-ordinates of all points in grid

% OUTPUTS
% streamUni = stream function at each grid point

function [ streamUni ] = streamUniform( velocity, x, y)

streamUni = velocity*y;

end

