% This script provides an example to demonstrate usage of the function
% MATLAB (tested with 2023a)
% Author: Zakir Hussain Shaik


clc;
clear;
close all;

% Exponential parameters
lmd = [1,1,2,3,4,4];

% Weights of random variables
w = [2,3,4,1,2,5];

% Theoretical expression of PDF
t = 0:0.01:20;
[f,F] = sumexppdf(t,lmd,w);

% Generating emperical samples (N number of samples)
N  = 1e7;

% Weighted sum of exponential random variables
X = 0;
for  i = 1:length(lmd)
    X  = X + w(i)*exprnd(1/lmd(i),N,1);
end


%% Plots
figure;
subplot(2,1,1);
histogram(X,'Normalization','pdf','DisplayStyle','stairs');hold on;
plot(t,f,'*r','MarkerIndices',1:100:length(f));
legend('Emperical','Theoretical','Location','best');
xlabel('$t$','Interpreter','latex');
ylabel('$f_X(t)$','Interpreter','latex');
title('PDF of Sum of Exponentials','Interpreter','latex');
grid on;
xlim([min(t),max(t)]);

subplot(2,1,2);
ecdf(X);hold on;
plot(t,F,'*r','MarkerIndices',1:100:length(f));
legend('Emperical','Theoretical','Location','best');
xlabel('$t$','Interpreter','latex');
ylabel('$F_X(t)$','Interpreter','latex');
title('CDF of Sum of Exponentials','Interpreter','latex');
grid on;
xlim([min(t),max(t)]);

