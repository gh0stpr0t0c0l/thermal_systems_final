function perf_out = perf(CPU_perf, P_CPUs, h_c, t_DUCT, T_mi, c_p, k_air, k_duct, A_c_walls, A_c_CPUs, N, t, L, L_SIDE, L_DUCT, w, rho, nu, Pr)
    s = (L_SIDE-L-N/4*t)/(N/4+1);        %Spacing between fins, meters
    A_c = L_SIDE^2 - L*t*N;              %Cross sectional area, meters^2
    D_h = (2*L*s)/(L+s);                 %Hydraulic diameter of surragate duct, meters
    [h, Re_D, T_me] = findh2(P_CPUs, h_c, t_DUCT, A_c, D_h, T_mi, c_p, k_air, k_duct, A_c_walls, A_c_CPUs, N, t, L, L_SIDE, L_DUCT, w, rho, nu, Pr)

    %% Calculate Mean Velocity
    %assume conservation of mass to use:
    %Reynolds number for surrogate duct:
    u_m = Re_D * nu / D_h
    
    %% Calculate mass flow rate
    %given T_me = T_mi + Q_dot/(m_dot * c_p)
    m_dot_air = rho * A_c * u_m;         %kg/s %Q_dot_tot/(c_p*(T_me-T_mi)) %commented out is the necessary m_dot - requires iterative solution
    
    %Q_fan conversion
    Q_fan = (m_dot_air / rho) * 60 * 1000;   %In L/min
    
    P_fan = ((Q_fan/100000)^3)*10000;

    perf_out = CPU_perf/(P_CPUs+P_fan);
end
