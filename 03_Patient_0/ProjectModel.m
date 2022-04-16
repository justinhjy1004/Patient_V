function ProjectModel
clear
close all
clc

% Declare rates
beta1 = .005; %Rate of exposure
beta2 = beta1 * 3;
alpha1 = .125; %Rate of recovery
alpha2 = .125;
eta1 = .5; %Rate of infection
eta2 = .5;
sigma1 = .0746; %Rate of recovery/hospitalization from I class
sigma2 = .0746;
gamma1 = .1163; % Rate of death
gamma2 = .1163;

% Declare proportions
p1 = .65;
p2 = .65;
m1 = .07;
m2 = m1 / 3;
c1 = .0323;
c2 = c1 / 3;

% Declare initial size of classes
S = 315;
E1 = .680;
E2 = 0;
I1 = 3.12;
I2 = 10000/1000000;
A1 = 1.79;
A2 = 0;
H1 = .104;
H2 = 0;
D1 = .313;
D2 = 0;
R = 11;

% Delare time
T = 120;

% Define the model
function dy = SEIAHDR(~, y, beta1, beta2, eta1, eta2, sigma1, sigma2, gamma1, gamma2, alpha1, alpha2, p1, p2, m1, m2, c1, c2)
    dy = zeros(12, 1); % Store the derivatives
    x1 = 0.1 * (0.4 * y(4) + 0.8 * y(6)) + 0.2 * ((0.6) *(0.6) * y(4) + (0.2) * y(6));
    x2 = x1;
    
    dy(1) = (-beta1 * y(1) * x1) + (-beta2 * y(1) * x2);
    dy(2)  = (beta1 * x1 * y(1)) - (eta1 * y(2)); % E1 term
    dy(3) = (beta2 * x2 * y(1)) - (eta2 * y(3)); % E2 term
    
    
    %dy(1) = (-beta1 * y(1) * y(6)) + (-beta2 * y(1) * y(7)); 
    %dy(2)  = (beta1 * y(6) * y(1)) - (eta1 * y(2)); % E1 term
    %dy(3) = (beta2 * y(7) * y(1)) - (eta2 * y(3)); % E2 term
    dy(4) = (eta1 * (1 - p1) * y(2)) - (alpha1 * y(4)); % A1 term
    dy(5) = (eta2 * (1 - p2) * y(3)) - (alpha2 * y(5)); % A2 term
    dy(6) = (p1 * eta1 * y(2)) - (sigma1 * y(6)); % I1 term
    dy(7) = (p2 * eta2 * y(3)) - (sigma2 * y(7)); % I2 term
    dy(8) = (c1 * sigma1 * y(6)) - (gamma1 * y(8)); % H1 term
    dy(9) = (c2 * sigma2 * y(7)) - (gamma2 * y(9)); % H2 term
    dy(10) = m1 * gamma1 * y(8); % D1 term
    dy(11) = m2 * gamma2 * y(9); % D2 term
    dy(12) = ((1 - m1) * gamma1 * y(8)) + ((1 - c1) * sigma1 * y(6)) + (alpha1 * y(4)) + ((1 - m2) * gamma2 * y(9)) + ((1 - c2) * sigma2 * y(7)) + (alpha2 * y(5)); % R term

end

% Use Matlab function to calculate the solutions
[sim_t, sim_y] = ode45(@(t,y)(SEIAHDR(t,y,beta1, beta2, eta1, eta2, sigma1, sigma2, gamma1, gamma2, alpha1, alpha2, p1, p2, m1, m2, c1, c2)), + ...
    [0 T],[S;E1;E2;A1;A2;I1;I2;H1;H2;D1;D2;R]);
sim_S = sim_y(:,1);
sim_E1 = sim_y(:,2);
sim_E2 = sim_y(:,3);
sim_A1 = sim_y(:,4);
sim_A2 = sim_y(:,5);
sim_I1 = sim_y(:,6);
sim_I2 = sim_y(:,7);
sim_H1 = sim_y(:,8);
sim_H2 = sim_y(:,9);
sim_D1 = sim_y(:,10);
sim_D2 = sim_y(:,11);
sim_R = sim_y(:,12);

% Plot and label
figure; hold on;

figure(1)
plot(sim_t, sim_S, 'linewidth',1);
plot(sim_t, sim_E1, 'linewidth',1);
plot(sim_t, sim_A1, 'linewidth',1);
plot(sim_t, sim_I1, 'linewidth',1);
plot(sim_t, sim_H1, 'linewidth',1);
plot(sim_t, sim_D1, 'linewidth',1);
plot(sim_t, sim_R, 'linewidth', 1);
legend({'S','E_1','A_1','I_1','H_1','D_1','R'},'FontSize',8)
title('Spread of Existing Strain','FontSize', 12)
xlabel('Time (days)','FontSize',12);
ylabel('People (millions)','FontSize',12);

figure(2)
plot(sim_t, sim_S, 'linewidth',1);
hold on
plot(sim_t, sim_E2, 'linewidth',1);
plot(sim_t, sim_A2, 'linewidth',1);
plot(sim_t, sim_I2, 'linewidth',1);
plot(sim_t, sim_H2, 'linewidth',1);
plot(sim_t, sim_D2, 'linewidth',1);
plot(sim_t, sim_R, 'linewidth',1);
legend({'S','E_2','A_2','I_2','H_2','D_2','R'},'FontSize',8)
title('Spread of "Patient 0" Strain','FontSize', 12)
xlabel('Time (days)','FontSize',12);
ylabel('People (millions)','FontSize',12);

figure(3)
plot(sim_t, sim_D1,'linewidth', 1);
hold on
plot(sim_t, sim_D2,'linewidth', 1);
plot(sim_t, sim_D1 + sim_D2, 'linewidth', 1);
legend({'Existing Strain','"Patient 0" Strain','Total Deaths'},'FontSize',8)
title('Cumulative Death Comparison','FontSize', 12)
xlabel('Time (days)','FontSize',12);
ylabel('People (millions)','FontSize',12);
end

