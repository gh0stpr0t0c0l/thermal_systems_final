function [diff, Re_D] = tinf(P_CPU, h, h_c, t_DUCT, A_c, D_h, T_mi, T_me, c_p, k_air, k_duct, A_c_walls, A_c_CPUs, N, t, L, L_SIDE, L_DUCT, w)
    Q_dot_tot = P_CPU;
    
    %% Calculate Air Density (Assume temperature, pressure??)
    rho = 1.145;                         %kg/m^3, based on a temperature of T_bulk, FROM TABLE
    nu = 1.655e-5;                       %m^2/s assumed based on a temperature of T_bulk, FROM TABLE
    Pr = 0.7268;                         %Prandtl number, assumed based on a temperature of T_bulk, FROM TABLE
    
    %% Calculate Reynolds Number
    %Nusselt Number Eqn:
    Re_D = ((h*D_h)/(k_air*0.023*Pr^0.4))^(1/0.8); %Reynolds number for the duct
    
    %% Calculate Mean Velocity
    %assume conservation of mass to use:
    %Reynolds number for surrogate duct:
    u_m = Re_D * nu / D_h;
    
    %% Calculate mass flow rate
    %given T_me = T_mi + Q_dot/(m_dot * c_p)
    m_dot_air = rho * A_c * u_m;             %kg/s %Q_dot_tot/(c_p*(T_me-T_mi)) %commented out is the necessary m_dot - requires iterative solution
    
    T_inf_air = (Q_dot_tot/(m_dot_air*c_p) + 2 * T_mi)/2;
    
    %% Calculate Thermal Resistances
    R_paste = 1/(h_c * A_c_CPUs);            
    R_cond = t_DUCT/(k_duct * A_c_walls);
    
    %% Calculate Fin Efficiency
    m = sqrt((2 * h) / (k_duct * t));    %constant for calculating efficiency
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
    
    T_inf_fin = 90 - Q_dot_tot * (R_paste + R_cond + R_tot);
    
    diff = T_inf_air - T_inf_fin;
end


%P_fan = 1000;                            %Fan Power, W, VARIABLE
%P_tot = P_CPU + P_fan;
%Q_fan = (100000*(P_fan/10000)^(1/3))/(1000*60)   %Fan Flowrate, m^3/s
