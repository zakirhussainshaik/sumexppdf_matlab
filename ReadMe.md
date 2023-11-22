# SumExpPDF MATLAB Helper Function

This code package contains a helper function `sumexppdf()` designed to generate Probability Density Functions (PDF) and Cumulative Distribution Functions (CDF) for the sum of independent exponential random variables.

**Functionality:**

The function computes the sum:
$$ Y = X_1 + X_2 + X_3 + \ldots + X_n $$

When provided with weights as the third input argument, it calculates a weighted sum:
$$ Y = a_1 \cdot X_1 + a_2 \cdot X_2 + \ldots + a_n \cdot X_n $$
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

Function Version: 1.0
License: This code is licensed under the GPLv2 license.
Compatibility: MATLAB (tested on 2023a)
Additional Information:
This file is accompanied by example scripts and an illustration on obtaining the PDF of the norm square of a complex Gaussian vector.

For theoretical expressions and further discussions, refer to the accompanying blog article: https://www.zakirtechblog.com/post/sumexppdf/