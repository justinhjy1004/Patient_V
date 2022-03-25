function ProjectModel
clear all
close all
clc

% Declare rates
beta1 = 0;
beta2 = 0;
alpha1 = 0;
alpha2 = 0;
eta1 = 0;
eta2 = 0;
sigma1 = 0;
sigma2 = 0;
gamma1 = 0;
gamme2 = 0;
x1 = 0;
x2 = 0;

% Declare proportions
p1 = 0;
p2 = 0;
m1 = 0;
m2 = 0;
c1 = 0;
c2 = 0;

% Declare initial size of classes
S = 0;
E1 = 0;
E2 = 0;
I1 = 0
I2 = 0;
A1 = 0;
A2 = 0;
H1 = 0;
H2 = 0;
D1 = 0;
D2 = 0;
R = 0;
T = 0;

% Define the model
function dy = SEIAHDR(y, beta1, beta2, eta1, eta2, sigma1, sigma2, gamma1, gamma2, alpha1, alpha2, x1, x2)
    dy = zeros(12, 1); % Store the derivatives
    dy(1) = -beta1 * x1 * y(1) - beta2 * x2; % S term
    dy(2)  = beta1 * x1 * y(1) - eta1 * y(2); % E1 term
    dy(3) = beta2 * x2 * y(1) - eta2 * y(3); % E2 term
    dy(4) = eta1(1 - p1) * y(2) - alpha1 * y(4); % A1 term
    dy(5); % A2 term
    dy(6); % I1 term
    dy(7); % I2 term
    dy(8); % H1 term
    dy(9); % H2 term
    dy(10); % D1 term
    dy(11); % D2 term
    dy(12); % R term

end

