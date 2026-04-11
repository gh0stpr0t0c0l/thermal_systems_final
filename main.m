N = 24*4                             %total number of fins, VARIABLE
t = 0.002                            %fin thickness, meters, VARIABLE
L = 0.025                            %fin length, meters, VARIABLE
h = 50                               %convection heat transfer coefficient, PART 2
k = 178                              %thermal conductivity, CHOSEN MATERIAL
w = 0.15                             %fin width, meters
INNER_SIDE_L = 0.15;                 %meters

m = sqrt((2 * h) / (k * t))         %constant
L_c = L + t / 2                     %corrected fin length
A_b = w * t                         %Area of single fin base
A_fins = N * (2 * w * L_c)          %area of all of the fins
A_nofins = 0.15 * 0.15 * 4
A_unfin = A_nofins - N * A_b        %area of fin bank with no fins
A_tot = A_fins + A_unfin            %total area of fin bank
eta_fin = tanh(m * L_c) / (m * L_c) %single fin efficiency
eta_tot = 1 - ((A_fins) / (A_tot)) * (1 - eta_fin)
%R_tot = 1 / (h * A_tot * eta_tot)

%% Simulate