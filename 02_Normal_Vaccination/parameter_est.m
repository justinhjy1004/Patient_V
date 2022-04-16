clear all; close all; clc;

%% Read data from file
filename = './Parameter_Estimation/cases_clean.csv';
M = csvread(filename,1);

cases = M(:,1)/1000000;
deaths = M(:,2)/1000000;

r = 0.7;
m = 0.073;

%% Estimating BETA comparing actual cases

% Betas to be Tested
betas = [0.001:0.001:0.01];

% List of Errors
error = [1:length(betas)];

% Test for each beta and calculate the squared errors
for beta = 1:length(betas)
    results = vaccination_sim(betas(beta),r,m);
    I = results(:,6);
    % Max Iterations
    iterations = min(floor(length(I)/10),length(cases));
    for i = 1:iterations
        error(beta) = error(beta) + (cases(i) - I(i*10))^2;
    end
end

[c,i] = min(error);
beta = betas(i);

% m to be Tested
ms = [0.01:0.01:0.1];

% List of Errors
error = [1:length(ms)]; 

% Calculate m and test against absolute errors
for m = 1:length(ms)
    results = vaccination_sim(beta,r,ms(m));
    D = results(:,9);
    % Max Iterations
    iterations = min(floor(length(D)/10),length(deaths));
    for i = 1:iterations
        error(m) = error(m) + abs(deaths(i) - D(i*10));
    end
end

[c,i] = min(error);
m = ms(i);

