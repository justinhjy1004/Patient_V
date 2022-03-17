function [P,S,E,A,I,R,H,D,V] = vaccination_sim(beta, r)
% VACCINATION_SIM simulates the distribution of vaccination using 
% a model derived from Dr. Glenn Ledder
%
% P: Prevaccination
% S: Vaccination Refuser
% E: exposed
% A: asymptomatic
% I: infective (symptomatic)
% H: hospitalized
% R: recovered
% D: deceased
% V: Vaccinated

%% Input Parameters
% beta: transmission rate
% r: vaccine refusal fraction of population


%% Initial parameters
p = 0.4; % percentage that becomes infective
c = 0.016; % percentage that becomes hospitalized
m = 0.25; % percentage that dies
fa = 0.75; % infectivity of A
fc = 0.1; % infectivity of I
fh = 0.05; % infectivity of H
te = 5; % time spent in E
ta = 8; % time spent in A
ti = 10; % time spent in I
th = 10; % time spent in H

maxdays = 1000;

%% Derived parameters
W_0 = 1-r; % Initial number of those wanting to get vaccinated
eta = 1/te;
alpha = 1/ta;
sigma = 1/ti;
gamma = 1/th;

end

