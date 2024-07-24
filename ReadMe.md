# sumexppdf.m MATLAB Helper Function

This code package contains a helper function `sumexppdf()` designed to generate Probability Density Functions (PDF) and Cumulative Distribution Functions (CDF) for the sum of independent exponential random variables.

**Functionality:**

The function computes the PDF of the sum of independent exponential random variables: Y = X_1 + X_2 + X_3 + ... + X_n. 

When provided with weights as the third input argument, it computes the PDF of the weighted sum of independent exponential random variables: Y = a_1.X_1 + a_2.X_2 + ... + a_n.X_n

*Note: Only positive weights are supported.*

**Author:** Zakir Hussain Shaik
**Contact:** zakir.b2a@gmail.com

**Function Inputs:**
- `t` (Mandatory): Value at which PDF/CDF is evaluated
- `lambdas` (Mandatory): Parameters of Exponential Random Variables
- `weights` (Optional): Weights of Random Variables

**Function Outputs:**
- `f`: PDF evaluated at `t`
- `F`: CDF evaluated at `t`

**Usage Examples:**
```matlab
f = sumexppdf(t, lambdas); % or [f, F] = sumexppdf(t, lambdas);
f = sumexppdf(t, lambdas, weights); % or [f, F] = sumexppdf(t, lambdas, weights);
```

Function Details:

Function Version: 2.0
License: This code is licensed under the GPLv2 license.
Compatibility: MATLAB (tested on 2024a)
Additional Information:
This file is accompanied by example scripts and an illustration on obtaining the PDF of the norm square of a complex Gaussian vector.

**Issues fixed from version 1.0:**
1. Fixed some issues with nsumk function
2. Matlab produces power(0,0) = 1, but in this code it should be 0
3. Now this works for examples like: lmd = [10,10,3], without issues.

I would like to thank Prof. Axel Larsen, University of Copenhagen, who was generous enough to point out the example lmd = [10,10,3], for which version 1 had some issues.


For theoretical expressions and further discussions, refer to the accompanying blog article: https://www.zakirtechblog.com/post/sumexppdf/