function [P,S,E,A,I,R,H,D,W,V] = vaccination_sim(beta, r)
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


%% Parameters of Model
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
K = 0.25;
V_1 = 0.03*S_P_0;

%% Initialization
S_P_0 = 1000; % Total susceptibles
S_0 = r*s_P_0;
P_0 = S_P_0 - S_0;
E_0 = 0;
A_0 = 0;
I_0 = 1;
H_0 = 0;
R_0 = 0;
D_0 = 0;

% output results is a matrix with columns [t P S E A I R H D W V]
Tmax = 1000;
T0 = 0;
target = 0.001;
dt = 0.1;
N_Iter = ceil((Tmax-T0)/dt);
dt = (Tmax-T0)/N_Iter;
results = zeros(N_Iter+1,11);
results(1,:) = [T0,S0,E0,I0];
results(:,1) = [T0:dt:Tmax]';


%% Derived parameters
W_0 = 1-r; % Initial number of those wanting to get vaccinated
eta = 1/te;
alpha = 1/ta;
sigma = 1/ti;
gamma = 1/th;


%% COMPUTATION
for i=1:N_Iter
    % y is a column vector [t P S E A I R H D W V]_OLD
    y = results(i,2:11)'; E_old = y(2); I_old = y(3);
    t = results(i,1);
    y = RK4(t,dt,y);
    results(i+1,2:4) = y';
    if y(2)/N < target
        % pandemic ends or is stable
        results = results(1:(i+1),:);
        break;
    end
end

%% FUNCTION FOR 4th order Runge-Kutta

    function y=RK4(t,dt,y0)
        % y0 is a column vector of initial conditions at t
        % y is a column vector of values at t+dt
        k1 = yprime(t,y0);
        k2 = yprime(t+0.5*dt,y0+0.5*dt*k1);
        k3 = yprime(t+0.5*dt,y0+0.5*dt*k2);
        k4 = yprime(t+dt,y0+dt*k3);
        y = y0+dt*(k1+2*k2+2*k3+k4)/6;
    end
end


%% FUNCTION FOR THE DIFFERENTIAL EQUATION

    function yp=yprime(t,y)
    % split out components
        S = y(1);
        E = y(2);
        I = y(3);
    % compute derivatives
        Sp = -beta*S*I;
        Ep = -Sp-eta*E;
        Ip = eta*E-alpha*I;
    % assemble derivative
        yp = [Sp;Ep;Ip];
    end


