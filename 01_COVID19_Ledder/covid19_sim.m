function [S,E,A,I,H,R,D,R0]=covid19_sim(delta,pc,pca,t2,H0,V)
%
% function [S,E,A,I,H,R,D,R0]=covid19_sim(delta,pc,pca,t2,H0,V)
%
% runs a simulation of an SEAIHDR model
%
% S: susceptible
% E: exposed
% A: asymptomatic
% I: infective (symptomatic)
% H: hospitalized
% R: recovered
% D: deceased
%
% delta is the fractional contact rate for social distancing
% pa is the fraction of infectives who are asymptomatic
% pc is the fraction of symptomatics who are tested
% pca is the fraction of asymptomatics who are tested
% ph is the fraction of infectives who require hospitalization
% mh is the fraction of hospitalized patients who die
% fa, fc, fh are the infectivities of A, C, and H, relative to that of I
% t2 is the doubling time if no interventions
% te, ta, ti, tc, th are the expected durations of classes E, A, I1, I2, H
% H0 is the number of initial hospitalized infectives per hundred thousand
% V is the fraction of the population that is initially immune
% target is the value of A+I+H per hundred thousand defined as the end condition
%
% R0 is the basic reproductive number with no detection or intervention
% results is a matrix: columns are SEAI1I2HRD, rows are 0:days
% 
% by Glenn Ledder
% written 2020/03/31
% revised 2021/02/10
%
% direct comments to gledder@unl.edu

%% DATA

% suggested default values

 %delta = 1;
 %pc = 0.1;
 %pca = 0;
 %t2 = 3.1;
 %H0 = 1;
 %V = 0;

%% COMMON DATA

pa = 0.4;
ph = 0.016;
mh = 0.25;
fa = 0.75;
fc = 0.1;
fh = 0.05;
te = 5;
ta = 8;
ti = 10;
tc = 3;
th = 10;
target = 100;

maxdays = 1000;

%% INITIALIZATION

% set derived parameters

H0 = H0/100000;
target = target/100000;

eta = 1/te;
alpha = 1/ta;
gamma = 1/ti;
nu = 1/th;
sigma = 1/tc;

% set more derived parameters

lambda = log(2)/t2;
i20 = tc*(lambda+nu);
K = (lambda+sigma)*i20/ph;
e0 = te*K;
i10 = (1-pa-ph)*K/(lambda+gamma);
a0 = pa*K/(lambda+alpha);
i0 = i10+i20;
beta = (lambda+eta)*e0/(i0+fa*a0);
R0 = beta*(fa*pa*ta+(1-pa)*ta);

% set up results data structure with Y=[S,E,A,I1,I2,H,R,D]

results = zeros(maxdays+1,8);
Y = [0,e0*H0,a0*H0,i10*H0,i20*H0,H0,V,0];
Y(1) = 1-sum(Y);
results(1,:) = Y;

y = Y';
summ = (1+e0+a0+i0)*H0;   % summ is used to help determine the end condition

%% COMPUTATION

for t=1:maxdays
    % y is a column vector, Y^T
    y = rk4(1,y);
    Y = y';
    results(t+1,:) = Y;
    if sum(Y(2:6))>min(target,summ)
        summ = sum(Y(2:6));
    else
        results = results(1:(t+1),:);
        break;
    end
end

S = results(:,1);
E = results(:,2);
A = results(:,3);
I = results(:,4)+results(:,5);
H = results(:,6);
R = results(:,7);
D = results(:,8);

%% FUNCTION FOR rk4

    function y=rk4(dt,y0)
        % y0 is a column vector of initial conditions at t
        % y is a column vector of values at t+dt
        k1 = yprime(y0);
        k2 = yprime(y0+0.5*dt*k1);
        k3 = yprime(y0+0.5*dt*k2);
        k4 = yprime(y0+dt*k3);
        y = y0+dt*(k1+2*k2+2*k3+k4)/6;
    end
        
%% FUNCTION FOR THE DIFFERENTIAL EQUATION

    function yp=yprime(y)
    % split out components
        S = y(1);
        E = y(2);
        A = y(3);
        I1 = y(4);
        I2 = y(5);
        I = I1+I2;
        H = y(6);
        X = delta*(fa*(1-pca)*A+(1-pc)*I)+fc*(pca*A+pc*I)+fh*H;
    % compute derivatives
        Sp = -beta*X*S;
        Ep = -Sp-eta*E;
        Ap = pa*eta*E-alpha*A;
        I1p = (1-pa-ph)*eta*E-gamma*I1;
        I2p = ph*eta*E-sigma*I2;
        Hp = sigma*I2-nu*H;
        Rp = alpha*A+gamma*I1+(1-mh)*nu*H;
        Dp = mh*nu*H;
    % assemble derivative
        yp = [Sp;Ep;Ap;I1p;I2p;Hp;Rp;Dp];
    end

%% END

end
