%% Problem 1

rng(0);
true_mean = 10;
true_sigma = 4;

%(i) A gaussian prior
prior_mean = 10.5;
prior_sigma = 1;

%(ii) Uniform prior
a = 9.5;
b = 11.5; 
p = 1/(b-a);

N = [5,10,20,40,60,80,100,500,1000,10000];
M = 200;

ml = [];
map1 = [];
map2 = [];
for i=1:10    
    emp_mean_ml = zeros(M,1);
    emp_mean_map1 = zeros(M,1);
    emp_mean_map2 = zeros(M,1);
    for j=1:M
        X = true_sigma.*randn(N(i),1) + true_mean;
        
        mean1 = sum(X)/N(i);
        mean2 = (mean1*prior_sigma^2 + prior_mean*true_sigma^2/N(i))/(prior_sigma^2 + true_sigma^2/N(i));
        mean3 = sum(X)/N(i);        
        if(mean3 > b) mean3 = b;
        elseif(mean3 < a) mean3 = a;    
        end
        
        emp_mean_ml(j) = abs(mean1-true_mean)/true_mean;
        emp_mean_map1(j) = abs(mean2-true_mean)/true_mean;
        emp_mean_map2(j) = abs(mean3-true_mean)/true_mean;
    end
    
    ml = [ml emp_mean_ml];
    map1 = [map1 emp_mean_map1];
    map2 = [map2 emp_mean_map2];   
end

fg = figure;
hold on;
delta = linspace(-.3,.3,15); %// define offsets to distinguish plots
legendEntries = ["Relative Error for $\hat{\mu}^{ML}$" "Relative Error for $\hat{\mu}^{MAP1}$" "Relative Error for $\hat{\mu}^{MAP2}$"];
title("Relative Error for Three Estimates");
xlabel("N");
ylabel("Relative Error");

boxplot(ml,'Colors',"b" , 'boxstyle','filled','position',(1:10) + delta(1),'labels',N);
plot(NaN,1,'color',"b");

boxplot(map1,'Colors',"m" , 'boxstyle','filled','position',(1:10) + delta(5),'labels',N);
plot(NaN,1,'color',"m");

boxplot(map2,'Colors',"r" , 'boxstyle','filled','position',(1:10) + delta(10),'labels',N);
plot(NaN,1,'color',"r");

legend(legendEntries,"Interpreter","latex","FontSize",10);
saveas(gcf,sprintf("boxplot1.png"));
%% 
%