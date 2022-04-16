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
m = 0.073;
% m = 0.043;
%% COMPUTATION
% [T,P,S,E,A,I,R,H,D,W,V,F]

results = vaccination_sim(beta,r,m);
T = results(:,1);
SandP = results(:,2) + results(:,3);
I = results(:,6);
R = results(:,7);
H = results(:,8);
D = results(:,9);
W = results(:,10);
F = results(:,12);

%% OUTPUT
figure(1); clf; hold on;
days = length(SandP)-1;
plot(T,SandP,'LineWidth',1.7)
plot(T,H,'LineWidth',1.7)
plot(T,I,'LineWidth',1.7)
plot(T,R,'LineWidth',1.7)
plot(T,D,'LineWidth',1.7)
plot(T,F,'LineWidth',1.7)
xlabel('days')
ylabel('people')
legend('SandP','H','I','R','D','F')

figure(2); clf; hold on;
days = length(SandP)-1;
plot(T,I,'LineWidth',1.7)
xlabel('days')
ylabel('people')
legend('I')

figure(3); clf; hold on;
days = length(SandP)-1;
plot(T,D,'LineWidth',1.7)
xlabel('days')
ylabel('people')
legend('D')