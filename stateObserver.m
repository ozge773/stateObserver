clear all 
close all
clc
format compact

A = [-0.4 -1;1 0]
B = [1;0]
C = [0 1]
D = 0 
x0 = [-0.1;0.5] % inital condition 

%Compute gain L of the observer 
%Checking the observability


Mo = obsv(A,C)
rho_Mo= rank(Mo)
%placing the igenvalues in non oscillative fashion
lambda_obs_des = [-0.5 -0.5]
L = acker(A', C', lambda_obs_des)' %L has to be column don't forget to transpose!!


%define state equation of the observer with the relevant matrices
                % A ,     B,     C,    D
sys_obsv = ss(A - L*C, [B L], eye(2), 0)
sys_x = ss(A,B,eye(2),0)
t_sim=50

%observer is a dyn system x_hat so we should have an initital estimated
%...state. Since we dont know it we set x_hat to 0
x0_hat = [0;0];% initial estimated state
rho = 0
out= sim("ex1lesson26.slx");


figure
plot(out.x.time, out.x.data(:,1), 'b', 'linewidth',  1.5) ; hold on;
grid on;
plot(out.x_hat.time, out.x_hat.data(:,1), 'r', 'linewidth',  1.5) ; grid on;

figure
plot(out.x.time, out.x.data(:,2), 'b', 'linewidth',  1.5) ; hold on;
grid on;
plot(out.x_hat.time, out.x_hat.data(:,2), 'r', 'linewidth',  1.5) ; grid on;
return
%there are two inputs of the observer u and y


