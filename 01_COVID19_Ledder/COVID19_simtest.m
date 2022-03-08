%% COVID19_simtest
%
% Plots a comparison of population classes
%
% Uses covid19_sim.m, 2021/02/10 version
%
% User specifies values for 6 parameters:
%   delta is the fractional contact rate for social distancing
%   pc is the fraction of symptomatics who are tested
%   pca is the fraction of asymptomatics who are tested
%   t2 is the doubling time if no interventions
%   H0 is the number of initial hospitalized infectives per hundred thousand
%   V is the fraction of the population that is initially immune
%
% by Glenn Ledder
% written 2020/09/19
% revised 2021/02/11
%
% direct comments to gledder@unl.edu

beds = 280;

%% SCENARIO DATA

delta = 1;
pc = 0.1;
pca = 0;
t2 = 3.1;
H0 = 1;
V = 0;

%% INITIALIZATION

% uncomment next line if you have problems with a legend
%opengl hardwarebasic;

clf
for k=1:4
    subplot(2,2,k)
    hold on
    xlabel('days')
end
colors = get(gca,'colororder');

%% COMPUTATION

[S,E,A,I,H,R,D,R0] = covid19_sim(delta,pc,pca,t2,H0,V);
days = length(I)-1;
new = S(1:days)-S(2:length(S));
new = [0;new];

%% OUTPUT

times = 0:days;

subplot(2,2,1)
plot(times,S,'Color',colors(1,:),'LineWidth',2)
plot(times,E,'Color',colors(3,:),'LineWidth',2)
plot(times,A+I+H,'Color',colors(2,:),'LineWidth',2)
plot(times,R+D,'Color',colors(4,:),'LineWidth',2)
ylabel('population fraction')
legend('S','E','A+I+H','R+D','Location','East')

subplot(2,2,3)
plot(times,325000*D,'r','LineWidth',2)
ylabel('US deaths (thousands)')

subplot(2,2,2)
plot(times,100000*new,'Color',colors(3,:),'LineWidth',2)
ylabel('new cases per 100K')

subplot(2,2,4)
plot(times,100000*H,'Color',colors(2,:),'LineWidth',2)
plot([0,days],[beds,beds],'k--')
ylabel('hospitalizations per 100K')

results = [times',S,E,A,I,H,R,D,new]

% final %S
finalpctS = 100*S(end)

% final %D
finalpctD = 100*D(end)

% US deaths (thousands)
USdeaths = 325000*D(end)

% maximum hospitalizations per 100K
maxHp100K = 100000*max(H)

% maximum new infections per 100K
maxnewp100K = 100000*max(new)

% R0
R0

