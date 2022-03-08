%% COVID-19 parameter studies

% Runs a covid19 experiment to determine how maximum hospitalizations,
% total deaths, and final at risk percentage depend on a parameter value
%
% Uses covid19_sim.m, 2021/02/10 version
%
% User specifies a range for one of the key parameters:
%   delta is the fractional contact rate for social distancing 
%       (1 for normal, <1 for social distancing)
%   pc is the fraction of symptomatics who are tested
%   pca is the fraction of asymptomatics who are tested
%   t2 is the doubling time if no interventions
%   H0 is the number of initial hospitalized infectives per hundred thousand
%   V is the fraction of the population that is initially immune
%
% The program can be modified to experiment with other parameters.
% These require changes to covid19sim.m
%
% The program is designed so that only a few lines need to be modified to
% make a new experiment (see '%%%' comments)
%   lines 54-56 define the independent variable values
%   line 59 identifies the x axis label for the graph
%   line 90 links the independent variable name and values
%
% Output figure:
%   top left panel: max hospitalizations (per 100K)
%       (compare to average of 280 hospital beds per 100K)
%   top right panel: thousands of US deaths (out of 325M)
%   bottom left panel: final susceptibles (percent)
%   bottom right panel: days for max new infections and A+I+H<target
%
% by Glenn Ledder
% written 2020/03/30
% revised 2021/02/11
%
% direct comments to gledder@unl.edu

%% DEFAULT SCENARIO DATA

delta = 0.3;
pc = 0.1;
pca = 0;
t2 = 3.1;
H0 = 1;
V = 0;

%% INDEPENDENT VARIABLE DATA

%%% This section needs to be modified for each experiment.

%%% first and last are the min and max values for the independent variable
%%% N is the number of points (not subdivisions)
first = 0;
last = 1;
N = 101;

%%% xname is the name for the x axis label
xname = 'delta';

%% INITIALIZATION

% uncomment next line if you have problems with a legend
%opengl hardwarebasic;

clf
for k=1:4
    subplot(2,2,k)
    hold on
    xlabel(xname)
end
colors = get(gca,'colororder');

% xvals holds whatever values are being used for the independent variable
xvals = linspace(first,last,N);

finalpctS = zeros(1,N);
maxHp100K = zeros(1,N);
USdeaths = zeros(1,N);
maxHtime = zeros(1,N);
maxnewtime = zeros(1,N);
endtime = zeros(1,N);

%% COMPUTATION

for n=1:N
    
    %%% The left side of this statement needs to be the independent
    %%% variable for the experiment.
    delta = xvals(n);

    [S,~,~,~,H,~,D,~] = covid19_sim(delta,pc,pca,t2,H0,V);

    [maxHp100K(n),maxrow] = max(100000*H);
    maxHtime(n) = maxrow-1;

    dS = S(1:(end-1))-S(2:end);
    [~,maxnewtime(n)] = max(dS);

    USdeaths(n) = 325000*D(end);
    finalpctS(n) = 100*S(end);

    endtime(n) = length(S)-1;
end

%% OUTPUT

subplot(2,2,1)
plot(xvals,maxHp100K,'Color',colors(2,:),'LineWidth',1.7)
subplot(2,2,2)
plot(xvals,USdeaths,'r','LineWidth',1.7)
subplot(2,2,3)
plot(xvals,finalpctS,'Color',colors(1,:),'LineWidth',1.7)
subplot(2,2,4)
plot(xvals,maxnewtime,'Color',colors(3,:),'LineWidth',1.7)
plot(xvals,maxHtime,'Color',colors(2,:),'LineWidth',1.7)
plot(xvals,endtime,'Color',colors(1,:),'LineWidth',1.7)
legend('max new cases','max hospitalized','end condition')

subplot(2,2,1)
ylabel('max hospitalized (per 100K)')
subplot(2,2,2)
ylabel('deaths (1000s out of 325M)')
subplot(2,2,3)
ylim([0,100])
ylabel('percent S at end')
subplot(2,2,4)
ylabel('days')
