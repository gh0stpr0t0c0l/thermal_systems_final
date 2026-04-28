clear
figure
%% Load and Define Constants
constants
constants_part3
CPU_perf = 30000;                                               %CPU Performance Score, single CPU
P_CPUs = -(log(1-CPU_perf/39000))/(0.02)*N_CPU;                  %total CPU Power, W

%% Vary L

n = 1
x = 0:0.0001:0.08
for L = x
y(n) = perf(CPU_perf, P_CPUs, h_c, t_DUCT, T_mi, c_p, k_air, k_duct, A_c_walls, A_c_CPUs, N, t, L, L_SIDE, L_DUCT, w, rho, nu, Pr);
n = n + 1;
end
plot(x,y)
title('Performance vs Fin Length')
xlabel('Fin Length L (m)')
ylabel('PassMark Benchmark Score (All CPUs)')


clear
figure
%% Load and Define Constants
constants
constants_part3
CPU_perf = 30000;                                               %CPU Performance Score, single CPU
P_CPUs = -(log(1-CPU_perf/39000))/(0.02)*N_CPU;                  %total CPU Power, W

%% Vary N

n = 1
x = 0:1:250
for N = x
y(n) = perf(CPU_perf, P_CPUs, h_c, t_DUCT, T_mi, c_p, k_air, k_duct, A_c_walls, A_c_CPUs, N, t, L, L_SIDE, L_DUCT, w, rho, nu, Pr);
n = n + 1;
end
plot(x,y)
title('Performance vs Fin Count')
xlabel('Fin Count N')
ylabel('PassMark Benchmark Score (All CPUs)')


clear
figure
%% Load and Define Constants
constants
constants_part3
CPU_perf = 30000;                                               %CPU Performance Score, single CPU
P_CPUs = -(log(1-CPU_perf/39000))/(0.02)*N_CPU;                  %total CPU Power, W

%% Vary t

n = 1
x = 0.00001:0.00001:0.005
for t = x
    y(n) = perf(CPU_perf, P_CPUs, h_c, t_DUCT, T_mi, c_p, k_air, k_duct, A_c_walls, A_c_CPUs, N, t, L, L_SIDE, L_DUCT, w, rho, nu, Pr);
    n = n + 1;
end
plot(x,y)
title('Performance vs Fin Thickness')
xlabel('Fin Thickness t (m)')
ylabel('PassMark Benchmark Score (All CPUs)')

clear
figure
%% Load and Define Constants
constants
constants_part3
CPU_perf = 30000;                                               %CPU Performance Score, single CPU
P_CPUs = -(log(1-CPU_perf/39000))/(0.02)*N_CPU;                  %total CPU Power, W

%% Vary Material

n = 1
x = 16:1:1000
for k_duct = x
    y(n) = perf(CPU_perf, P_CPUs, h_c, t_DUCT, T_mi, c_p, k_air, k_duct, A_c_walls, A_c_CPUs, N, t, L, L_SIDE, L_DUCT, w, rho, nu, Pr);
    n = n + 1;
end
plot(x,y)
title('Performance vs Fin Material (Conductivity)')
xlabel('Fin Thermal Conductivity (W/(m*K))')
ylabel('PassMark Benchmark Score (All CPUs)')

clear
figure
%% Load and Define Constants
constants
constants_part3
[N, P_CPU] = meshgrid(1:250, 10:190);
P_CPUs = P_CPU*36;
CPU_perf = 39000*(1-exp(-.02*P_CPU));    %CPU Performance Score
performance = zeros(size(CPU_perf));
for i = 1:size(CPU_perf, 1)
    for j = 1:size(CPU_perf, 2)
        performance(i,j) = perf(CPU_perf(i,j), P_CPUs(i,j), h_c, t_DUCT, T_mi, c_p, k_air, k_duct, A_c_walls, A_c_CPUs, N(i,j), t, L, L_SIDE, L_DUCT, w, rho, nu, Pr);
    end
end
surf(N, P_CPU, performance)
title(['Performance over P_{CPU} and N'])
xlabel('Fin Count N')
ylabel('Single CPU Power P_{CPU} (W)')
zlabel('PassMark Benchmark Score (All CPUs)')