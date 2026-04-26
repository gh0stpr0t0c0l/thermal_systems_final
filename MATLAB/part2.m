clear
%% Load and Define Constants
constants
constants_part2_3
P_CPU = 1000;                            %CPU Power, W, VARIABLE
P_fan = 1000;                            %Fan Power, W, VARIABLE
P_tot = P_CPU + P_fan;
CPU_perf = 39000*(1-exp(-.02*P_CPU))     %CPU Performance Score
Q_fan = (100000*(P_fan/10000)^(1/3))/(1000*60)   %Fan Flowrate, m^3/s

%% Calculate Thermal Resistances
R_paste = 1/(h_c * A_c_CPUs);            
R_cond = t_DUCT/(k * A_c_wall);

%% Calculate Air Density (Assume temperature, pressure??)
T_bulk = (T_me + T_mi)/2 - 273.15    %celcius
rho = 1.145 * 1000;                  %g/m^3, based on a temperature of T_bulk, FROM TABLE
nu = 1.655 * 10e-5;                  %m^2/s assumed based on a temperature of T_bulk, FROM TABLE
Pr = 0.7268;                         %Prandtl number, assumed based on a temperature of T_bulk, FROM TABLE

%% Calculate mass flow rate
%given T_me = T_mi + Q_dot/(m_dot * c_p)
m_dot_air = Q_fan * rho;             %g/s %Q_dot_tot/(c_p*(T_me-T_mi)) %commented out is the necessary m_dot - requires iterative solution

%% Calculate Mean Velocity
%assume conservation of mass to use:
u_m = m_dot_air/(rho*A_c)

%% Calculate Surrogate Duct Reynolds Number
Re_D = (u_m * D_h) / nu;             %Reynolds number for the duct

%% Calculate Convection Heat Transfer Coefficient
%assume turbulent
Nu = 0.023*Re_D^0.8*Pr^0.4;
h = Nu*k/(D_h)                       %convection heat transfer coefficient, W/(m*K) CHECK UNITS

%% Calculate Fin Efficiency
m = sqrt((2 * h) / (k * t));         %constant for calculating efficiency
L_c = L + t / 2;                     %corrected fin length, meters
eta_fin = tanh(m * L_c) / (m * L_c); %single fin efficiency

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
R_fins = 1 / (h * A_fins * eta_fin); %fins convection thermal resistance, K/W
R_unfin = 1 / (h * A_unfin);         %unfin convection thermal resistance, K/W
R_tot = 1/(1/R_fins+1/R_unfin);      %total resistance - parallel fin and unfin resistors, K/W

%% Find Surface Temperatures
%from resistor eqn, equating current:
T_inf = T_bulk; %celcius IS THIS A GOOD ASSUMPTION???
T_b = (90*R_tot+T_inf*(R_paste+R_cond))/(R_tot+R_paste+R_cond) %Q_dot_tot*(R_paste+R_cond) + 90; %celcius, commented out is old work - equated around Q_dot_tot

%% a) Determine Maximum allowable power dissipation per transistor
Q_dot_tot = (T_b-T_inf)/R_tot       %heat transfer rate, W
Q_dot_tran = Q_dot_tot/N_CPU         %allowed power per transistor, W

%% b) Determine Required Volume Flow Rate of Air
%assume perfectly caloric
%m_dot_air = Q_dot_tot/(c_p*dT_air)   %minimum volume flow rate, kg/s

%% Simulate

% calculate mass flow rate from fan flow rate and air density at input
% temperature...