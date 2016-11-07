% Script that compares the different pitot velocity relations
% Author: Declan Walsh
% Last Modified: 7/11/2016

clear all
close all

% Changelog:
% 1) Added relations for all 3 cases and plotted them over range of pressure ratios

% To Do:
% Move pitot equation into function (input pressure difference and return
% the type of flow and flow mach number)

%%
% SETUP

NUM_POINTS = 500; % number of points to graph

AIR_DENS = 1.222; % standard SL air density (kg.m^-3)
AIR_TEMP = 293; % standard SL air temperature (K) 
GAMMA = 1.4; % ratio of specific heats (gamma = Cp/Cv)
R = 287; % specific gas constant for air

a_freestream = sqrt(GAMMA*R*AIR_TEMP); % speed of sound for specified conditions

P_MAX_RATIO = 5;

pS = 1.01e5; % standard SL static pressure (kPa)
pRatio = linspace(1,P_MAX_RATIO,NUM_POINTS); % p02/p1
p0 = pRatio.*pS; % stagnation pressure
pDiff = p0-pS; % dynamic pressure (difference between total and static)

%%
% VELOCITY CALCULATIONS

% incompressible uses Bernoulli's equation
v_incomp = sqrt(2*pDiff/AIR_DENS);
M_incomp = v_incomp/a_freestream;

% compressible uses the isentropic relationships
M_comp = sqrt((2/(GAMMA-1))*(((pRatio).^((GAMMA-1)/GAMMA)-1)));
v_comp = M_comp*a_freestream;

% the stagnation ratio for M = 1 (supersonic)
pCritRatioSuper = (1+(GAMMA-1)/2)^(GAMMA/(GAMMA-1))
xCritSuper = pCritRatioSuper.*ones(1,10);
yCritVSuper = linspace(0, 1.5*max(v_incomp), 10);
yCritMSuper = linspace(0, 1.5*max(M_incomp), 10);

% the stagnation ratio for M = 0.3 (compressiblity effects)
pCritRatioComp = (1+(0.3^2)*(GAMMA-1)/2)^(GAMMA/(GAMMA-1))
xCritComp = pCritRatioComp.*ones(1,10);
yCritVComp = linspace(0, 1.5*max(v_incomp), 10);
yCritMComp = linspace(0, 1.5*max(M_incomp), 10);

% implicit function for the stagnation pressure to static pressure ratio across a shock wave
M_shock = linspace(0, max(M_incomp), NUM_POINTS);
v_shock = M_shock * a_freestream;
pRatioShock = zeros(size(M_shock));

for i = 1:length(M_shock)
    if(M_shock(i) < 1)
        continue % only solve equation if M > 1 (else sqrt fails - due to entropy decrease)
    end
    shockFun = @(pRatioAnswer)supersonicPressureRatio(M_shock(i), GAMMA)-pRatioAnswer;   
    pRatioShock(i) = fzero(shockFun, pRatio(i));
end

idxShock = find(pRatioShock == 0, 1, 'last');

pRatioShock(1:idxShock) = [];
v_shock(1:idxShock) = [];
M_shock(1:idxShock) = [];

%%
% COMBINE RESULTS

idxIncomp = find(M_incomp < 0.3, 1, 'last');
idxComp = find(M_comp < 1, 1, 'last');
% shock already tidied up

% extract pressure where relation valid
pRatio_incompReduced = pRatio(1:idxIncomp);
pRatio_compReduced = pRatio(idxIncomp+1:idxComp);

% extract Mach number where relation valid
M_incompReduced = M_incomp(1:idxIncomp);
M_compReduced = M_comp(idxIncomp+1:idxComp);

% combine each relation for their valid regions to get the total relation
M_complete = horzcat(M_incompReduced, M_compReduced, M_shock);
P_complete = horzcat(pRatio_incompReduced, pRatio_compReduced, pRatioShock);

xCritComplete = linspace(0, 1.5*max(P_complete), 10);
yCritCompComplete = 0.3*ones(size(xCritComplete));
yCritShockComplete = 1*ones(size(xCritComplete));

%%
% PLOT RESULTS

figure
plot(pRatio, v_incomp, pRatio, v_comp, pRatioShock, v_shock, xCritSuper, yCritVSuper, '--', xCritComp, yCritVComp, '--');
legend('Incompressible', 'Compressible (subsonic)', 'Shock (supersonic)', 'Shock Limit', 'Incompressiblity Limit');
title('Comparision of Different Pitot Relations - EAS');
xlabel('Pressure Ratio (p02/p1)');
ylabel('EAS (m/s)')
ylim([0, 1.2*max(v_incomp)]);
xlim([1, max(pRatio)]);

figure
plot(pRatio, M_incomp, pRatio, M_comp, pRatioShock, M_shock, xCritSuper, yCritMSuper, '--', xCritComp, yCritMComp, '--');
legend('Incompressible', 'Compressible (subsonic)', 'Shock (supersonic)', 'Shock Limit', 'Incompressiblity Limit');
title('Comparision of Different Pitot Relations - Mach Number');
xlabel('Pressure Ratio (p02/p1)');
ylabel('Mach Number')
ylim([0, 1.2*max(M_incomp)]);
xlim([1, max(pRatio)]);

figure
plot(P_complete, M_complete, xCritComplete, yCritCompComplete, '--', xCritComplete, yCritShockComplete, '--');
title('Complete Pressure Ratio to Mach Number Relationship');
xlabel('Pressure Ratio (p02/p1)');
ylabel('Mach Number');
legend('Relationship', 'Compressibility Limit', 'Shock Limit');
xlim([1, 1.2*max(P_complete)]);
ylim([0, 1.2*max(M_complete)]);