%% Problem 2

rng(0);
N = [5,10,20,40,60,80,100,500,1000,10000];
M = 200;
lambda = 5;

alpha = 5.5;
beta = 1;

ml = [];
map = [];
for i=1:10
    emp_lambda_ml = zeros(M,1);
    emp_lambda_map = zeros(M,1);
    for j=1:M
        X = rand(N(i),1);
        Y = (-1/lambda).*log(X);
        
        lambda1 = N(i)/sum(Y); % lambda_ML
        lambda2 = (N(i)+alpha)/(sum(Y) + beta); % lambda_posterior_mean
        
        emp_lambda_ml(j) = abs(lambda1 - lambda)/lambda;
        emp_lambda_map(j) = abs(lambda2 - lambda)/lambda;
    end
    ml = [ml emp_lambda_ml];
    map = [map emp_lambda_map]; 
end

figure;
hold on;
delta = linspace(-.3,.3,10); %// define offsets to distinguish plots
legendEntries = ["Relative Error for $\hat{\lambda}^{ML}$" "Relative Error for $\hat{\lambda}^{PosteriorMean}$"];
title("Relative Error for Two Estimates");
xlabel("N");
ylabel("Relative Error");

boxplot(ml,'Colors',"b" , 'boxstyle','filled','position',(1:10) + delta(1),'labels',N);
plot(NaN,1,'color',"b");

boxplot(map,'Colors',"m" , 'boxstyle','filled','position',(1:10) + delta(6),'labels',N);
plot(NaN,1,'color',"m");

legend(legendEntries,"Interpreter","latex","FontSize",10);
saveas(gcf,"boxplot2.png");
%% 
% Gamma PDF := 

function y = gammaPDF(x,alpha,beta)
    y = (beta^alpha/gamma(alpha)) * x^(alpha-1) * e^(-beta*x);
end