clear; close all; clc;

M = 2.0;

[t,y] = patient_zero_fx(M);

S = y(:,1);
E1 = y(:,2);
E2 = y(:,3);
A1 = y(:,4);
A2 = y(:,5);
I1 = y(:,6);
I2 = y(:,7);
H1 = y(:,8);
H2 = y(:,9);
D1 = y(:,10);
D2 = y(:,11);
R = y(:,12);

Ms = [2:0.01:10];
Is = [1:length(Ms)];
Hs = [1:length(Ms)];
Ds = [1:length(Ms)];
Ts = [1:length(Ms)];

for i = 1:length(Ms)
    
    [t,y] = patient_zero_fx(Ms(i));
    
    S = y(:,1);
    E1 = y(:,2);
    E2 = y(:,3);
    A1 = y(:,4);
    A2 = y(:,5);
    I1 = y(:,6);
    I2 = y(:,7);
    H1 = y(:,8);
    H2 = y(:,9);
    D1 = y(:,10);
    D2 = y(:,11);
    R = y(:,12);

    I_max = max(I1 + I2);
    H_max = max(H1 + H2);
    D_tot = max(D1 + D2);
    End_Day = find((I1 + I2) <= 3);

    Is(i) = I_max;
    Hs(i) = H_max;
    Ds(i) = D_tot;
    Ts(i) = End_Day(1);

    %X = ['Multiplier', Ms(i), 'Length', length(R), 'I_max', I_max, 'H_max', H_max, 'D_tot', D_tot];
    X =  sprintf('Multiplier %f Time %d I_max %f H_max %f D_tot %f',Ms(i), length(t), I_max, H_max, D_tot);
    disp(X);
    
end

figure(1)
plot(Ms, Is,'linewidth', 1);
title('Maximum Infected at a Given Time','FontSize', 12)
xlabel('Vaccine Multiplier','FontSize',12);
ylabel('People (millions)','FontSize',12);

figure(2)
plot(Ms, Hs,'linewidth', 1);
title('Maximum Hospitalized at a Given Time','FontSize', 12)
xlabel('Vaccine Multiplier','FontSize',12);
ylabel('People (millions)','FontSize',12);

figure(3)
plot(Ms, Ds,'linewidth', 1);
title('Total Death','FontSize', 12)
xlabel('Vaccine Multiplier','FontSize',12);
ylabel('People (millions)','FontSize',12);

figure(4)
plot(Ms, Ts,'linewidth', 1);
title('Infected at <1%','FontSize', 12)
xlabel('Vaccine Multiplier','FontSize',12);
ylabel('Days','FontSize',12);