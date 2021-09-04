# Problem 3

## How to run code

* My submissions are live-scripts of matlab
* They are in zip format, don't unzip them
* Open matlab go to the folder of that zip and open the *.mlx files from matlab
* They would appear as jupyter notebook with markdown, codeblock and outputs.
* Press ctrl + enter to run each code block 

## Problem 3.1

### Part 1

* We have N = $10^4$ random walkers.
* Further suppose within each timeframe $\Delta t$, walkers take either a $\Delta z = 10^{-3}$ step right with probability p (say 0.5 for simplicity), OR a $\Delta z$ step left with probability q := 1 - p ( = 0.5 )
* If in an event a walker took 'x' steps right and 'n-x' steps left
  then random walker's final location is at z = $\Delta z (2x -n)$ 
* Where variable $x$ can be obtained using binornd() in matlab for various random walkers $N_i \in N$, because x is the result of repeated Bernoulli trial (Number of success(here taking right step) in n trials with success probability p) and hence has a binomial distribution.
* Now we can find final location and plot the histogram

<img src="/home/utkarsh/Documents/iitb/cs215/assignment-1/report/histogram_random_walker.png" alt="histogram_random_walker" style="zoom:200%;" />

### Part 2

* A 2D matrix is made to contain location of each random walker after each step 1,2,3....n
* This was done by running a loop and then adding to the previous row, $10^3$ Bernoulli random variables for left and right steps, to obtain the next row.

![space_time_curve_random_walker2](/home/utkarsh/Documents/iitb/cs215/assignment-1/report/space_time_curve_random_walker2.png)

### Part 3 

[code]

## Problem 3.2

![WhatsApp Image 2021-09-03 at 9.41.40 PM](/home/utkarsh/Documents/iitb/cs215/assignment-1/report/WhatsApp Image 2021-09-03 at 9.41.40 PM.jpeg)

### Part 1

Empirically-computed mean $\hat M$ = 3.9120e-04
Empirically-computed variance $\hat V$ = 9.9757e-04

### Part 2

$$
\text{True} \ \text{mean} = \frac{\sum_{N_i = 1}^{N} z_i}{N} \\
= \frac{\sum_{N_i = 1}^{N} \Delta z (2x_i -n)}{N} \\
= \Delta z (2 \frac{\sum_{N_i = 1}^{N} x_i}{N} -n)
$$

Now since $x$ is a binomial distribution with success probability p and number of trials n its mean is simply np.

Thus :=
True Mean = $\Delta z \cdot n(2 p - 1)$ 
				  = 0
$$
\text{True} \ \text{mean} = Var(z) \\
= Var(\Delta z (2x_i -n)) \\
= 4{(\Delta z)}^2 Var(x)
$$
Now since $x$ is a binomial distribution with success probability p and number of trials n its variance is simply np(1-p).

Thus := 
True Variance = $4{(\Delta z)}^2 \cdot np(1-p)$ 
					   = 1.0000e-03

### Part 3

error_mean = |True mean - Empirical mean| = 3.9120e-04
error_variance =  |True variance - Empirical variance| = 2.4314e-06
