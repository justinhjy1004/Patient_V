function [results] = vaccination_sim(beta, r, m)
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
% m = 0.25; % percentage that dies
fa = 0.75; % infectivity of A
fc = 0.1; % infectivity of I
fh = 0.05; % infectivity of H
te = 5; % time spent in E
ta = 8; % time spent in A
ti = 10; % time spent in I
th = 10; % time spent in H
K = 0.25;

%% Initialization
N = 1000;
S_P_0 = 1000; % Total susceptibles
S_0 = r*S_P_0;
P_0 = S_P_0 - S_0;
E_0 = 0;
A_0 = 0;
I_0 = 1;
H_0 = 0;
R_0 = 0;
D_0 = 0;
W_0 = 1-r; % Initial number of those wanting to get vaccinated
V_0 = 0;
V_1 = 2*P_0;

% output results is a matrix with columns [t P S E A I R H D W V]
Tmax = 1000;
T0 = 0;
target = 0.0001;
dt = 0.1;
N_Iter = ceil((Tmax-T0)/dt);
i_t = ceil(N_Iter/2); % midpoint for max distribution
dt = (Tmax-T0)/N_Iter;
results = zeros(N_Iter+1,11);
results(1,:) = [T0,P_0,S_0,E_0,A_0,I_0,R_0,H_0,D_0,W_0,V_0];
results(:,1) = [T0:dt:Tmax]';


%% Derived parameters
eta = 1/te;
alpha = 1/ta;
sigma = 1/ti;
gamma = 1/th;

%% COMPUTATION
for i=1:N_Iter
    % y is a column vector [t P S E A I R H D W V]_OLD
    y = results(i,2:11)';
    P_old = y(1); 
    S_old = y(2);
    E_old = y(3);
    A_old = y(4);
    I_old = y(5);
    R_old = y(6);
    H_old = y(7);
    D_old = y(8);
    W_old = y(9);
    % Vaccination
    y(10) = min((V_1*i)/i_t,V_1);
    V_old = y(10);
    t = results(i,1);
    y = RK4(t,dt,y);
    disp(size(y));
    results(i+1,2:11) = y';
    if y(5)/N < target
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


%% FUNCTION FOR THE DIFFERENTIAL EQUATION

   function yp=yprime(t,y)
       disp(size(y));
    % split out components
        P = y(1); 
        S = y(2);
        E = y(3);
        A = y(4);
        I = y(5);
        R = y(6);
        H = y(7);
        D = y(8);
        W = y(9);
        V = y(10);
        X = (A+I);
        phi = (V*K)/(K+W);
    % compute derivatives
        Pp = -beta*X*P - phi*P;
        Sp = -beta*X*S;
        Ep = beta*X*(P+S) - eta*E;
        Ap = (1-p)*eta*E - alpha*A;
        Ip = p*eta*E - sigma*I;
        Hp = c*sigma*I - gamma*H;
        Dp = m*gamma*H;
        Rp = phi*P + alpha*A + (1-c)*sigma*I + (1-m)*gamma*H;
        Wp = phi*W;
        Vp = 0;
    % assemble derivative
        yp = [Pp;Sp;Ep;Ap;Ip;Rp;Hp;Dp;Wp;Vp];
        disp(size(yp));
   end 
end
