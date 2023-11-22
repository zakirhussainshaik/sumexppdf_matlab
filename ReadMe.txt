% This code package contains a helper function sumexppdf() that generates PDF/CDF for sum of independent
% exponential random variables
% Y = X1 + X2 + X3 + ... + Xn

% When provided with weights as third input argument, it computes
% Y = a1.X1 + a2.X2 + ... + an.Xn
% Only positive weights are supported

% Author: Zakir Hussain Shaik
% Contact: zakir.b2a@gmail.com

% This function accepts minimum one and maximum four inputs where three inputs are
% optional.
% First input  : t -- Value at which PDF/CDF is evaluated (Mandtory Input)
% Second input : lambdas -- Parameters of Exponential Random Variables (Mandtory Input)
% Third input  : weights-- Weights of Random Variables (this input is optional)

% First output  : f --  PDF evaluated at t
% Second output : F -- CDF evaluated at t

% Examples of using the function
% f = sumexppdf(t,lmd); or [f,F] = sumexppdf(t,lmd);
% f = sumexppdf(t,lmd,w); or [f,F] = sumexppdf(t,lmd,w);

% Author: Zakir Hussain Shaik
% This function version 1.0
% License: This code is licensed under the GPLv2 license.
% MATLAB (tested on 2023a)

% This file is accompanied with example scripts and an example to obtain PDF of norm square of complex Gaussian vector.
% Refer the blog article for theoretical expressions and further discussion: https://www.zakirtechblog.com/post/sumexppdf/

