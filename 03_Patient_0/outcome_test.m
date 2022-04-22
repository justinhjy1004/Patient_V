clear all; close all; clc;

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

Ms = [1:0.5:10];

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

    %X = ['Multiplier', Ms(i), 'Length', length(R), 'I_max', I_max, 'H_max', H_max, 'D_tot', D_tot];
    X =  sprintf('Multiplier %f Time %d I_max %f H_max %f D_tot %f',Ms(i), length(R), I_max, H_max, D_tot);
    disp(X);
    
end