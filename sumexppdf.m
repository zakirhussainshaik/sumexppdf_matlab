function [f,F] = sumexppdf(t,lamdas,varargin)
% This is a function that generates PDF/CDF for sum of independent
% exponential random variables
% Y = X1 + X2 + X3 + ... + Xn

% When provided with weights as third input argument, it computes
% Y = a1.X1 + a2.X2 + ... + an.Xn
% Only positive weights are supported

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

% Refer the blog article for theoretical expressions: https://www.zakirtechblog.com/post/sumexppdf/

%% Checking input arguments and default inputs
parsVar = inputParser;

assert(isreal(t) & all(t>=0),'Input -t- must be real valued and nonnegative');
assert(all(lamdas > 0),'Value must be greater than 0');

defaultWeights = ones(size(lamdas));
errorMsgWeights = 'Function Supported for Positive Weights'; 
validateWeights= @(x) assert(all(x > 0),errorMsgWeights);
addOptional(parsVar,'weights',defaultWeights,validateWeights);

parse(parsVar, varargin{:});

%% Inputs
weights = parsVar.Results.weights;

% Get the dimension of t
dimOft_row = isrow(t);

% Convert to row
t = t(:).';
lamdas = lamdas(:).';
weights = weights(:).';

% New Lamdas as per weights
lamdasModified = lamdas./weights;

% Number of variables
r = length(lamdasModified);

% Unique exponential paremeters
[lmdu,~,idx] = unique(lamdasModified);

% Number of unique exponential paremeters
n = length(lmdu);

% Number of times unique values repeated in lmdu
k = accumarray(idx,1);

% If all Xi's are i.i.d
if n==1
    f = (power(lmdu,k)*power(t,k-1)/factorial(k-1)).*exp(-t*lmdu);
    F = gammainc(lmdu*t,k);

% If all Xi's are independent and non-identical
elseif n==r

    prodLamdas = prod(lmdu);
    prodLamdasAll = prod(lmdu - lmdu' + eye(r),2);

    f = prodLamdas*sum(exp(-t.*lmdu')./(prodLamdasAll));

    prodLamdas2 = prodLamdas./lmdu;
    F =  sum( ((1 - exp(-t.*lmdu'))./(prodLamdasAll)).*(prodLamdas2') );

% If all Xi's are independent
else

    term4 = 0;
    term4_cdf = 0;
    for i = 1:n

        ki = k(i);

        term4tmp = power(lmdu(i),ki)*exp(-t*lmdu(i));
        term4tmp_cdf = power(lmdu(i),ki);

        term3 = 0;
        term3_cdf = 0;
        for j = 1:ki

            term3tmp = ( power(-1,ki-j)/factorial(j-1) )*power(t,j-1);
            term3tmp_cdf = ( power(-1,ki-j)/power(lmdu(i),j) )*gammainc(lmdu(i)*t,j);

            % Find all combinations
            allM0 = nsumk(n-1,ki-j);
            allM = [allM0(:,1:i-1), zeros(size(allM0,1),1), allM0(:,i:end)];

            term2 = 0;
            for idx_sumMs = 1:size(allM,1)
                m = allM(idx_sumMs,:);
                term1 = 1;
                for l = 1:n
                    if l ~= i
                        kl = k(l);
                        ml = m(l);

                        term1 = term1*nchoosek(kl + ml - 1,ml)*(power(lmdu(l),kl)/power(lmdu(l)-lmdu(i),kl+ml));
                    end
                end
                term2 = term2 + term1;

            end

            term3 = term3 + term3tmp*term2;

            term3_cdf = term3_cdf + term3tmp_cdf*term2;
        end

        term4 = term4 + term4tmp.*term3;

        term4_cdf = term4_cdf + term4tmp_cdf.*term3_cdf;

    end
    f = term4;
    F = term4_cdf;
end


% Convert the dimension as per input dimension of 't'
if dimOft_row==0
    f = f(:);
    F = F(:);
end

    function A = nsumk(n,k)
     % This helper function is taken from:
     % Peter Cotton (2023). nsumk (https://www.mathworks.com/matlabcentral/fileexchange/28340-nsumk), MATLAB Central File Exchange. Retrieved November 21, 2023.
        b = nchoosek(k+n-1,n-1);
        dividers = [zeros(b,1),nchoosek((1:(k+n-1))',n-1),ones(b,1)*(k+n)];
        A = diff(dividers,1,2)-1;
    end


end