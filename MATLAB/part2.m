clear
%% Load and Define Constants
constants
constants_part2_3
P_CPU = 53.2*36;                         %CPU Power, W, VARIABLE
CPU_perf = 39000*(1-exp(-.02*P_CPU));    %CPU Performance Score

%asssume T_bulk = 35C
[h, Re_D] = findh2(P_CPU, h_c, t_DUCT, A_c, D_h, T_mi, 0, c_p, k_air, k_duct, A_c_walls, A_c_CPUs, N, t, L, L_SIDE, L_DUCT, w)

