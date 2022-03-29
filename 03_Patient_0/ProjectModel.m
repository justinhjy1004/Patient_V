function ProjectModel
clear all
close all
clc

% Declare rates
beta1 = .5;
beta2 = .2;
alpha1 = .3;
alpha2 = .4;
eta1 = .5;
eta2 = .1;
sigma1 = .2;
sigma2 = .3;
gamma1 = .4;
gamma2 = .5;

% Declare proportions
p1 = .25;
p2 = .4;
m1 = .3;
m2 = .7;
c1 = .9;
c2 = .1;

% Declare initial size of classes
S = 100;
E1 = 0;
E2 = 0;
I1 = 0;
I2 = 0;
A1 = 0;
A2 = 0;
H1 = 0;
H2 = 0;
D1 = 0;
D2 = 0;
R = 0;
T = 60;

% Define the model
function dy = SEIAHDR(t, y, beta1, beta2, eta1, eta2, sigma1, sigma2, gamma1, gamma2, alpha1, alpha2, p1, p2, m1, m2, c1, c2)
    dy = zeros(14, 1); % Store the derivatives
    x1 = .5; % x1 term
    x2 = .5; % x2 term
    dy(1) = -beta1 * x1 * y(1) - beta2 * x2; % S term
    dy(2)  = beta1 * x1 * y(1) - eta1 * y(2); % E1 term
    dy(3) = beta2 * x2 * y(1) - eta2 * y(3); % E2 term
    dy(4) = eta1 * (1 - p1) * y(2) - alpha1 * y(4); % A1 term
    dy(5) = eta2 * (1 - p2) * y(3) - alpha2 * y(5); % A2 term
    dy(6) = p1 * eta1 * y(2) - sigma1 * y(6); % I1 term
    dy(7) = p2 * eta2 * y(3) - sigma2 * y(7); % I2 term
    dy(8) = c1 * sigma1 - gamma1 * y(8); % H1 term
    dy(9) = c2 * sigma2 - gamma2 * y(9); % H2 term
    dy(10) = m1 * gamma1 * y(10); % D1 term
    dy(11) = m2 * gamma2 * y(11); % D2 term
    dy(12) = (1 - m1) * gamma1 * y(8) + (1 - c1) * sigma1 * y(6) + sigma1 * y(4) + (1 - m2) * gamma2 * y(9) + (1 - c2) * sigma2 * y(7) + sigma2 * y(5); % R term

end

% use Matlab built-in function to calculate the solutions
[sim_t, sim_y] = ode45(@(t,y)(SEIAHDR(t,y,beta1, beta2, eta1, eta2, sigma1, sigma2, gamma1, gamma2, alpha1, alpha2, p1, p2, m1, m2, c1, c2)),[0 T],[S;E1;E2;A1;A2;I1;I2;H1;H2;D1;D2;R;0;0]);
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

figure; hold on;
plot(sim_t, sim_S, 'linewidth',.5);
plot(sim_t, sim_E1, 'linewidth',.5);
plot(sim_t, sim_E2, 'linewidth',.5);
plot(sim_t, sim_A1, 'linewidth',.5);
plot(sim_t, sim_A2, 'linewidth',.5);
plot(sim_t, sim_I1, 'linewidth',.5);
plot(sim_t, sim_I2, 'linewidth',.5);
plot(sim_t, sim_H1, 'linewidth',.5);
plot(sim_t, sim_H2, 'linewidth',.5);
plot(sim_t, sim_D1, 'linewidth',.5);
plot(sim_t, sim_D2, 'linewidth',.5);
plot(sim_t, sim_R, 'linewidth',.5);
% legend({'simulation S(t)','simulation E(t)','simulation I(t)','simulation R(t)'},'FontSize',12)
xlabel('Time(days)','FontSize',12);
ylabel('People','FontSize',12);
end

