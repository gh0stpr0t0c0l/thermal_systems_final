function [h, Re_D] = findh2(P_CPU, h_c, t_DUCT, A_c, D_h, T_mi, c_p, k_air, k_duct, A_c_walls, A_c_CPUs, N, t, L, L_SIDE, L_DUCT, w, rho, nu, Pr) %convection heat transfer coefficient, W/(m^2*K) CHECK UNITS
    it = 1;
    precision = 0.00001;
    h = 1;
    while it >= precision
        [new, Re_D] = tinf(P_CPU, h, h_c, t_DUCT, A_c, D_h, T_mi, c_p, k_air, k_duct, A_c_walls, A_c_CPUs, N, t, L, L_SIDE, L_DUCT, w, rho, nu, Pr);
        while new >= 0
            [new, Re_D] = tinf(P_CPU, h, h_c, t_DUCT, A_c, D_h, T_mi, c_p, k_air, k_duct, A_c_walls, A_c_CPUs, N, t, L, L_SIDE, L_DUCT, w, rho, nu, Pr);
            h = h + it;
        end
        h = h - 2 * it;
        it = it/10;
    end
end