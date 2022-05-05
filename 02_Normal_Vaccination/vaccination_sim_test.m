%% Vaccination process main script
%
% Plots a comparison of susceptible, infected, vaccinated and dead populations 
%
% Uses vaccination_sim.m, 2020/06/21 version
%
% User specifies values for 3 parameters:
%  beta - transmission rate
%  r - refusal rate
%  m - death rate 
%
% by Justin Ho
%
% direct comments to jho@huskers.unl.edu

clear all; close all; clc;
%% SCENARIO DATA INITIALIZATION

% parameter values
% beta = 0.25;
beta = 0.005;
r = 0.7;
m = 0.176;
c = 0.011;
% m = 0.043;
%% COMPUTATION
% [T,P,S,E,A,I,R,H,D,W,V,F]

results = vaccination_sim(beta,r,m,c);
T = results(:,1);
SandP = results(:,2) + results(:,3);
E = results(:,4);
A = results(:,5);
I = results(:,6);
R = results(:,7);
H = results(:,8);
D = results(:,9);
F = results(:,12);

%% OUTPUT
figure(1); clf; hold on;
days = length(SandP)-1;
plot(T,SandP,'LineWidth',1.7)
plot(T,E,'LineWidth',1.7)
plot(T,A,'LineWidth',1.7)
plot(T,I,'LineWidth',1.7)
plot(T,H,'LineWidth',1.7)
plot(T,D,'LineWidth',1.7)
plot(T,R,'LineWidth',1.7)
title('Spread of Existing Strain','FontSize', 12)
xlabel('days')
ylabel('people')
legend('S(t)+P(t)','E(t)','A(t)','I(t)','H(t)','D(t)','R(t)')

figure(2); clf; hold on;
days = length(SandP)-1;
plot(T,F,'-r','LineWidth',1.7)
xlabel('days')
ylabel('people')
title('Cumulative Vaccination','FontSize', 12)
legend('F')

figure(3); clf; hold on;
days = length(SandP)-1;
plot(T,D,'LineWidth',1.7)
xlabel('days')
title('Cumulative Death','FontSize', 12)
ylabel('people')
legend('D')

figure(4); clf; hold on;
days = length(SandP)-1;
plot(T,H,'LineWidth',1.7)
xlabel('days')
title('Hospitalization','FontSize', 12)
ylabel('people')
legend('H')