clear
%% Load and Define Constants
constants
constants_part2
P_CPU = 53.2*36;                         %CPU Power, W, VARIABLE
CPU_perf = 39000*(1-exp(-.02*P_CPU));    %CPU Performance Score

%asssume T_bulk = 35C
[h, Re_D] = findh2(P_CPU, h_c, t_DUCT, A_c, D_h, T_mi, c_p, k_air, k_duct, A_c_walls, A_c_CPUs, N, t, L, L_SIDE, L_DUCT, w, rho, nu, Pr)

%% Calculate Mean Velocity
%assume conservation of mass to use:
%Reynolds number for surrogate duct:
u_m = Re_D * nu / D_h

%% Calculate mass flow rate
%given T_me = T_mi + Q_dot/(m_dot * c_p)
m_dot_air = rho * A_c * u_m;             %kg/s %Q_dot_tot/(c_p*(T_me-T_mi)) %commented out is the necessary m_dot - requires iterative solution

%Q_fan conversion
Q_fan = (m_dot_air / rho) * 60 * 1000; %In L/min

P_fan = ((Q_fan/100000)^3)*10000