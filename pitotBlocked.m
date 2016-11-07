% Script that highlights the effect of a blocked pitot on airspeed measurements
% Aircraft assumed to be flying at a constant EAS
% Author: Declan Walsh
% Last Modified: 7/11/2016

% Changelog:
% 1) Basic (incompressible) relations and plots added

% To Do:
% 1) Need to account for compressiblity effects in velocity measurement
% 2) Tidy up code

clear all
close all

%%
% Setup

FT_TO_M = 0.3048; % feet per metre
KT_TO_MS = 0.51444; % knots per m/s
NUM_POINTS = 100;

AIR_DENS_SL = 1.225; % kg.m^-3

% pitot port frozen at 15,000ft (https://en.wikipedia.org/wiki/Austral_L%C3%ADneas_A%C3%A9reas_Flight_2553)
HEIGHT_ICING_IMPERIAL = 15000; % in feet
HEIGHT_ICING = HEIGHT_ICING_IMPERIAL*FT_TO_M; % in m

CRUISING_ALITITUDE_IMPERIAL = 25000;
CRUISING_ALTITUDE = CRUISING_ALITITUDE_IMPERIAL*FT_TO_M;

[~, ~, ~, AIR_DENS_CRUISE] = atmosisa(CRUISING_ALTITUDE);

CRUISE_SPEED = 490; % knots
EAS_KT = CRUISE_SPEED*sqrt(AIR_DENS_CRUISE/AIR_DENS_SL) % cruise speed knots converted to EAS
EAS = EAS_KT * KT_TO_MS; % metre per second

%%
% Pressures
% ALL PRESSURE MEASUREMENTS ASSUME INCOMPRESSIBLE FLOW

height = [0:100:CRUISING_ALTITUDE];

[~, ~, PstaticIced, ~] = atmosisa(HEIGHT_ICING); % static pressure at height of icing
[~, ~, Pstatic, ~] = atmosisa(height); % array of static pressures over climb

% normal flight
p_total_normal = 0.5*AIR_DENS_SL*EAS^2 + Pstatic;
P_dynamic_normal = p_total_normal - Pstatic;
v_indicated_normal = sqrt(P_dynamic_normal*2/AIR_DENS_SL);
v_indicated_normal_KT = v_indicated_normal/KT_TO_MS;

% static port iced
P_dynamic_staticIce = p_total_normal - PstaticIced;
v_indicated_iced = sqrt(P_dynamic_staticIce*2/AIR_DENS_SL);
v_indicated_iced_KT = v_indicated_iced/KT_TO_MS;

% pitot port iced
idxPitotIce = find(height<=HEIGHT_ICING,1 , 'last');
PTotalPitotIced = p_total_normal(idxPitotIce);
P_dynamic_pitotIce = PTotalPitotIced - Pstatic;
v_indicated_pitot_iced = sqrt(2*P_dynamic_pitotIce/AIR_DENS_SL);
v_indicated_pitot_iced_KT = v_indicated_pitot_iced/KT_TO_MS;

%%
% PLOTS

H_PLOT = height/(1000*FT_TO_M);

figure
plot(H_PLOT, v_indicated_normal_KT, H_PLOT, v_indicated_iced_KT, H_PLOT, v_indicated_pitot_iced_KT)
title('Effect of Icing on Pitot Measurements')
xlabel('Height (000s of feet)');
ylabel('IAS (kt)');
legend('No Icing (Actual)', 'Static Icing (Airframe Icing)', 'Pitot Icing (No Heaters)');