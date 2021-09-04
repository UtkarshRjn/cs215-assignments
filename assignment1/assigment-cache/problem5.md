# Problem 5

## How to run code

* My submissions are live-scripts of matlab
* They are in zip format, don't unzip them
* Open matlab go to the folder of that zip and open the *.mlx files from matlab
* They would appear as jupyter notebook with markdown, codeblock and outputs.
* Press ctrl + enter to run each code block 

## Part 1

* Data has been generated using rand() function of Matlab.
* Empirical average has been simply calculated.
* Since all these distribution are uniform~(0,1) true mean is simply 0.5

![boxplot_uniform](/home/utkarsh/Documents/iitb/cs215/assignment-1/results/problem5/boxplot_uniform.png)

## Part 2

* Data has been generated using randn() function of Matlab.
* Empirical average has been simply calculated.
* Since all these distribution are gaussian~(0,1) true mean is simply 0.

![boxplot_gaussian](/home/utkarsh/Documents/iitb/cs215/assignment-1/results/problem5/boxplot_gaussian.png)

## Part 3

The mean and variance of the distribution of error decrease as N increases. This is in accordance to the law of large numbers. We see an uncanny similarity between the error plots for uniform and gaussian distribution. This is because both are in fact gaussian curves as stated by the Central Limit Theorem.

## Part 4

[Code]