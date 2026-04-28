t_DUCT = 0.01;                       %Duct thickness, meters
s = (L_SIDE-L-N/4*t)/(N/4+1);        %Spacing between fins, meters
A_c = L_SIDE^2 - L*t*N;              %Cross sectional area, meters^2
D_h = (2*L*s)/(L+s) %Hydraulic diameter of surragate duct, meters
T_mi = 20;                  %mean inlet temperature, degC
%T_me = 30;                  %maximum mean duct exit temperature, degC
%Specific heat of air between 15 and 70 deg C, J/(kg*K) FROM TABLE
c_p = 1007;
k_duct = 392 %thermal conductivity, CHOSEN MATERIAL @T_bulk??
k_air = 0.02625 %W/(m*K), based on a temperature of T_bulk, FROM TABLE
%Cross sectional area of duct side for conduction, m^2 IGNORES CORNER AREA
A_c_walls = L_DUCT * L_SIDE * 4;
%total cross sectional area of CPUs for contact resistance, m^2
A_c_CPUs = 0.0014 * N_CPU;
%thermal paste thermal contact coefficient, W/(m^2*K) PICK AN ACTUAL PASTE
h_c = 30000
rho = 1.145; %kg/m^3, based on a temperature of T_bulk, FROM TABLE
nu = 1.655e-5; %m^2/s assumed based on a temperature of T_bulk, FROM TABLE
%Prandtl number, assumed based on a temperature of T_bulk, FROM TABLE
Pr = 0.7268;
