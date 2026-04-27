function diff = qdot(h, h_c, t_DUCT, A_c, D_h, T_mi, T_me, c_p, k_air, k_duct, A_c_walls, A_c_CPUs, N, t, L, L_SIDE, L_DUCT, w)

    %% Calculate Thermal Resistances
    R_paste = 1/(h_c * A_c_CPUs);            
    R_cond = t_DUCT/(k_duct * A_c_walls);
    
    %% Calculate Air Density (Assume temperature, pressure??)
    T_bulk = (T_me + T_mi)/2;    %celcius
    rho = 1.145;                  %kg/m^3, based on a temperature of T_bulk, FROM TABLE
    nu = 1.655e-5;                  %m^2/s assumed based on a temperature of T_bulk, FROM TABLE
    Pr = 0.7268;                         %Prandtl number, assumed based on a temperature of T_bulk, FROM TABLE
    
    %% Find Surface Temperatures
    T_inf = T_bulk; %celcius IS THIS A GOOD ASSUMPTION???
    
    %% Calculate Fin Efficiency
    m = sqrt((2 * h) / (k_duct * t));         %constant for calculating efficiency
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
    
    %% Get Q_dot in terms of h
    %Nusselt Number Eqn:
    Re_D = ((h*D_h)/(k_air*0.023*Pr^0.4))^(1/0.8)
    %Reynolds number for surrogate duct:
    u_m = Re_D*nu/D_h;
    %Conservation of mass:
    m_dot = rho*A_c*u_m;
    %Conservation of Energy:
    Q_dot_air = m_dot*c_p*(T_me-T_mi);
    
    Q_dot_fin = (90-T_inf)/(R_paste+R_cond+R_tot);
    
    
    diff = Q_dot_fin - Q_dot_air;
    
    
    %% a) Determine Maximum allowable power dissipation per transistor
    %Q_dot_tot = (T_b-T_inf)/R_tot       %heat transfer rate, W
    %Q_dot_tran = Q_dot_tot/N_CPU         %allowed power per transistor, W
    
    %% b) Determine Required Volume Flow Rate of Air
    %assume perfectly caloric
    %m_dot_air = Q_dot_tot/(c_p*dT_air)   %minimum volume flow rate, kg/s
    
    %% Simulate
    
    % calculate mass flow rate from fan flow rate and air density at input
    % temperature...
end