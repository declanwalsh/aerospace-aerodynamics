% Function that calculates the pressure ratio over a normal shock
% Author: Declan Walsh
% Last Modified: 7/11/2016

% used in pitotComparisions.m

% ARGUMENTS
% M = Mach number upstream of shock
% GAMMA = ratio of specific heats (1.4 for calorifically perfect air)

% RETURNS
% pRatio = ratio of total pressure behind shock to static pressure before shock p02/p1 
function [ pRatio ] = supersonicPressureRatio( M, GAMMA )

    c1 = ((GAMMA+1)^2*M^2)/(4*GAMMA*M^2-2*(GAMMA-1)); % isentropic relation (behind shock) p02/p2
    c2 = (1-GAMMA+2*GAMMA*M^2)/(GAMMA+1); % shock relation (across shock) p2/p1
    
    pRatio = c1^(GAMMA/(GAMMA-1))*c2;

end

