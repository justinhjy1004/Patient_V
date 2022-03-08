%% COVID-19 simulation plots

% Plots a covid19 simulation comparison of hospitalizations,
% deaths, and at risk percentage for multiple scenarios
%
% Uses covid19_sim.m, 2021/02/10 version
%
% User specifies a list of values for one of the key parameters:
%   delta is the fractional contact rate for social distancing 
%       (1 for normal, <1 for social distancing)
%   pc is the fraction of symptomatics who are tested
%   pca is the fraction of asymptomatics who are tested
%   t2 is the doubling time if no interventions
%   H0 is the number of initial hospitalized infectives per hundred thousand
%   V is the fraction of the population that is initially immune
%
% The program can be modified to experiment with other parameters.
% These require changes to covid19_sim.m
%
% The program is designed so that only a few lines need to be modified to
% make a new experiment (see '%%%' comments)
%     line 51 defines the list of independent variable values
%     line 79 links the independent variable name and values
%
% output figure:
%   left panel: hospitalizations per 100K 
%       (compare to average of 280 hospital beds per 100K)
%   center panel: thousands of US deaths (out of 325M)
%   right panel: at risk percentage
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

%%% xvals is the set of independent variable values
xvals = [1,.8,.6,.4];

%% INITIALIZATION

% uncomment next line if you have problems with a legend
%opengl hardwarebasic;

clf
for k=1:3
    subplot(1,3,k)
    hold on
% uncomment next line to improve aspect ratio in Octave
%    pbaspect([1 1.3])
end

N = length(xvals);
finalpctS = zeros(1,N);
finalpctD = zeros(1,N);
maxHp100K = zeros(1,N);
maxHtime = zeros(1,N);
days = zeros(1,N);

%% COMPUTATION and PLOTS

for n=1:N
    
    %%% The left side of this statement needs to be the independent
    %%% variable for the experiment.
    delta = xvals(n);

    [S,~,~,~,H,~,D,R0] = covid19_sim(delta,pc,pca,t2,H0,V);
    finalpctS(n) = 100*S(end);
    [maxHp100K(n),maxrow] = max(100000*H);
    maxHtime(n) = maxrow-1;
    finalpctD(n) = 100*D(end);
    days(n) = length(S)-1;

    subplot(1,3,1)
    plot(0:days(n),100000*H,'LineWidth',1.7)
    subplot(1,3,2)
    plot(0:days(n),325000*D,'LineWidth',1.7)
    subplot(1,3,3)
    plot(0:days(n),100*S,'LineWidth',1.7)
end

%% OUTPUT

for k=1:3
    subplot(1,3,k)
    xlabel('days')
end
subplot(1,3,1)
ylabel('hospitalizations (per 100K)')
subplot(1,3,2)
ylabel('US deaths (thousands)')
subplot(1,3,3)
ylabel('still at risk (percent)')

% final %S
finalpctS = finalpctS

% final %D
finalpctD = finalpctD

% US deaths (thousands)
USdeaths = 3250*finalpctD

% maximum hospitalizations per 100K
maxHp100K = maxHp100K

% day of maximum hospitalizations per 100K
maxHtime = maxHtime

% days to end condition
days = days
