clear
%% Load and Define Constants
constants
constants_part1

%% Calculate Fin Efficiency
m = sqrt((2 * h) / (k * t));         %constant for calculating efficiency
L_c = L + t / 2;                     %corrected fin length, meters
eta_fin = tanh(m * L_c) / (m * L_c) %single fin efficiency

%% Calculate Areas
A_b = w * t;                         %area of single fin base, meters^2
A_fin = 2 * w * L_c;                 %area of single fin, meters^2
A_fins = N * A_fin;                  %area of all of the fins, meters^2
A_nofins = L_SIDE * L_DUCT * 4;      %area with fins removed, meters^2
A_unfin = A_nofins - N * A_b;        %area of fin bank with no fins, meters^2
A_tot = A_fins + A_unfin;            %total area of fin bank, meters^2
%eta_tot = 1 - ((A_fins) / (A_tot)) * (1 - eta_fin); %unused total efficiency

%% Calculate Fin Convection Resistance
%R_tot = 1 / (h * A_tot * eta_tot) 
R_fins = 1 / (h * A_fins * eta_fin) %fins convection thermal resistance, K/W
R_unfin = 1 / (h * A_unfin)         %unfin convection thermal resistance, K/W
R_tot = 1/(1/R_fins+1/R_unfin)      %total resistance - parallel resistors, K/W

%% a) Determine Maximum allowable power dissipation per transistor
Q_dot_tot = (T_b-T_inf)/R_tot       %heat transfer rate, W
Q_dot_tran = Q_dot_tot/N_CPU         %allowed power per transistor

%% b) Determine Required Volume Flow Rate of Air
%assume perfectly caloric
m_dot_air = Q_dot_tot/(c_p*dT_air)   %minimum volume flow rate, kg/s