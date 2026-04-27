function h = findh2(P_CPU, h_c, t_DUCT, A_c, D_h, T_mi, T_me, c_p, k_air, k_duct, A_c_walls, A_c_CPUs, N, t, L, L_SIDE, L_DUCT, w) %convection heat transfer coefficient, W/(m^2*K) CHECK UNITS
    x = 0.1:0.1:1000;
    y = zeros(1,length(x));
    n = 1;
    for h = x
        new = tinf(P_CPU, h, h_c, t_DUCT, A_c, D_h, T_mi, T_me, c_p, k_air, k_duct, A_c_walls, A_c_CPUs, N, t, L, L_SIDE, L_DUCT, w);
        if new < 0
            plot(x,y)
            return;
        end
        y(n) = new;
        n = n+1;
    end
end