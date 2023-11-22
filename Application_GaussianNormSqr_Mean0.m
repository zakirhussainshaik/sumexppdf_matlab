% This script provides an appplication to demonstrate usage of the function
% This script computes PDF of Norm Square (also just norm) of Complex Gaussian Random Vector
% with Zero mean and Positive definite Covariance Matrix
% MATLAB (tested on 2023a)

% Author: Zakir Hussain Shaik

% Note: for non-zero mean, refer the blog article: https://www.zakirtechblog.com/post/sumexppdf/


clc;
clear;
close all;

% Random seed for repeatability
rng(1)

% Dimension of the vector
N = 4;

% Defining a positive definite covariance matrix 
h = crandn(N,N);
R = (h*h' + eye(N));

% Computing eigen values
w = eig(R);

% Theoretical expression of PDF for norm square
t = 0:0.01:120;
lmd = ones(N,1);
f = sumexppdf(t,lmd,w);

% Theoretical expression of PDF for norm
t2 = sqrt(t);
g = 2*sqrt(t).*f;

% random samples through montecarlo
MC = 1e6;
y_normSqr = zeros(MC,1);
y_norm = zeros(MC,1);
for i = 1:MC

    z = sqrtm(R/2)*(randn(N,1) + 1j*randn(N,1));

    y_normSqr(i,1) = norm(z)^2;
    y_norm(i,1) = norm(z);
end



%%
figure;
subplot(2,1,1);
histogram(y_normSqr,'Normalization','pdf','DisplayStyle','stairs','EdgeColor', 'k');hold on;
plot(t,f,'*r','MarkerIndices',1:100:length(f));
legend('Histogram','Theoretical','Location','best');
xlabel('$y$','Interpreter','latex');
ylabel('$f_Y(y)$','Interpreter','latex');
grid on;
title('PDF of $y = \Vert \mathbf{z} \Vert ^2$, $\mathbf{z} \sim \mathcal{CN}(\mathbf{0},\mathbf{R})$','Interpreter','latex');

subplot(2,1,2);
histogram(y_norm,'Normalization','pdf','DisplayStyle','stairs','EdgeColor', 'k');hold on;
plot(t2,g,'*r','MarkerIndices',1:100:length(g));
legend('Histogram','Theoretical','Location','best');
xlabel('$y$','Interpreter','latex');
ylabel('$f_Y(y)$','Interpreter','latex');
grid on;
title('PDF of $y = \Vert \mathbf{z} \Vert$, $\mathbf{z} \sim \mathcal{CN}(\mathbf{0},\mathbf{R})$','Interpreter','latex');