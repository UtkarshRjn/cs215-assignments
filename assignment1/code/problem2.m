%% Problem 2 (15 points)
% Consider two independent Poisson random variables X and Y , with parameters 
% $\lambda_X$ := 3 and $\lambda_Y$ := 4 .

lmdx = 3.0; % lambda of poisson distribution x
lmdy = 4.0; % lambda of poisson distribution y
rng(1);
% Part 1 [5 points: 3 + 1 + 1]
% Define a random variable Z := X + Y , having a probability mass function (PMF) 
% P (Z). 
% 
% (i) Empirically obtain an estimate $\hat P(Z)$ of the PMF P(Z) , by drawing 
% N := $10^6$ instances (sample points) of X and Y both. You may use the poissrnd(.) 
% function in Matlab. Report the values of $\hat P(Z = k)$ for k = 0, 1, 2, · 
% · · , 25 .
% 
% (ii) What will the PMF P(Z) be theoretically/analytically ?
% 
% (iii) Show and compare the values for $\hat P(Z = k)$ and $P(Z = k)$ for k 
% = 0, 1, 2, · · · , 25 .

rng(1);
N = 10^6;
X = poissrnd(lmdx,[1 N]);
Y = poissrnd(lmdy,[1 N]);
Z = X + Y;

[count,edges] = histcounts(Z);
count = count./N; %counts normalized because the sum of elements in count must be 1 for it to represent pmf
empirical_pmf = @(z) generatePMF(z,count,edges); % THIS IS OUR EMPIRICAL ESTIMATE \hat P(Z)
empirical_pmf_k = empirical_pmf([0:25]) %empirical pmf for k = 1,2,...,25 as a 1 x 25 matrix

true_pmf = @(z) exp(-(lmdx+lmdy)).*(lmdy+lmdx).^z./factorial(z); %found using the theoritical result
true_pmf_k = true_pmf([0:25]) %true pmf for k = 1,2,...,25 as a 1 x 25 matrix

% save('pmf(X+Y)','true_pmf_k','empirical_pmf_k')
% Part 2 [10 points: 6 + 2 + 2]
% Implement a Poisson thinning process (as discussed in class) on the random 
% variable Y , where the thinning process uses probability parameter 0.8 . Let 
% the thinned random variable be Z .
% 
% (i) Empirically obtain an estimate $\hat P$(Z) of the PMF P (Z) , by drawing 
% N := $10^5$ instances (sample points) from Y . You may use the poissrnd(.) and 
% binornd(.) functions in Matlab. Report the values of $\hat P$ (Z = k) for k 
% = 0, 1, 2, · · · , 25 .

rng(1);
N = 10^5;
p = 0.8;
Y = poissrnd(lmdy,[1 N]);

[count,edges] = histcounts(Y);
count = count./N; %counts normalized because the sum of elements in count must be 1 for it to represent pmf
empirical_pmf = @(z) generatePMFthin(z,count,edges,p,N); % THIS IS OUR EMPIRICAL ESTIMATE \hat P(Z)
empirical_pmf_k = empirical_pmf([0:25]) %empirical pmf for k = 1,2,...,25 as a 1 x 25 matrix

true_pmf = @(z) exp(-(lmdy*p)).*(lmdy*p).^z./factorial(z); % found using the theoritical result
true_pmf_k = true_pmf([0:25]) %true pmf for k = 1,2,...,25 as a 1 x 25 matrix

% save('pmf(thinning)',"true_pmf_k","empirical_pmf_k")
%% 
% generatePMFthin :=

function y = generatePMFthin(k,count,edges,p,N)
% This function takes count and edges from histcount, binomial probability
% p and N as input and returns pmf
    for i = 1:length(count)
        sum = 0;
        for j = i:length(count)
            Z = binornd((edges(j)+edges(j+1))/2,p,1,N); % generation of binomial random variablems to find binomial pmf
            [count_bin,edges_bin] = histcounts(Z); % count and edges output of histcount 
            count_bin = count_bin./N; % normalization so that sum of pmf is 1
            binomial_pmf = @(z) generatePMF(z,count_bin,edges_bin); % generates pmf
            % this pmf is used to find the sum as it was given in the slide
            % of poisson thinning
            sum = sum + binomial_pmf(k(k>=edges(i) & k<edges(i+1)))*count(j); 
        end
        y(k>=edges(i) & k<edges(i+1)) = sum;
        y(k<edges(1) | k>=edges(length(count)+1)) = 0;
    end
end
%% 
% generatePMF :=

function y = generatePMF(k,count,edges)  
% This function takes count and edges from histcount and returns pmf   
    for i = 1:length(count)
      y(k>=edges(i) & k<edges(i+1)) = count(i);
      y(k<edges(1) | k>=edges(length(count)+1)) = 0;
    end
end