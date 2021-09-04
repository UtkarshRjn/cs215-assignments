# Problem 4

## How to run code

* My submissions are live-scripts of matlab
* They are in zip format, don't unzip them
* Open matlab go to the folder of that zip and open the *.mlx files from matlab
* They would appear as jupyter notebook with markdown, codeblock and outputs.
* Press ctrl + enter to run each code block 

## Part 1

Given PDF:
$$
P_x(x) := 0 \ \text{for} \ |x| > 1, \text{and} \\
P_x(x) := |x| \ for \ x \in [-1,1]
$$
We would use [Invese transform sampling](https://en.wikipedia.org/wiki/Inverse_transform_sampling) to generate/draw random numbers with the given custom pdf $P_x( \dot \ )$ .

So CDF for this distribution is:
$$
F_x(c) = \int_{-\infty}^c P_X(t) dt
$$


$$
\begin{equation}
F_x(x) := 
	\left\{
		\begin{array}{lll}
			\int_{-\infty}^x 0 \cdot dt && \forall x \in (-\infty,-1) \\
			\int_{-\infty}^{-1} 0 \cdot dt + \int_{-1}^x -t \cdot dt && \forall x \in [-1,0 ] \\
			\int_{-\infty}^{-1} 0 \cdot dt + \int_{-1}^0 -t \cdot dt + \int_{0}^x t \cdot dt && \forall x \in [0,1] \\
			\int_{-\infty}^{-1} 0 \cdot dt + \int_{-1}^0 -t \cdot dt + \int_{0}^1 t \cdot dt + \int_{1}^{x} 0 \cdot dt && \forall x \in (1,\infty) \\
		\end{array}
	\right.
= 
	\left\{
		\begin{array}{lll}
			0 && \forall x \in (-\infty,-1) \\
			\frac{1-x^2}{2} && \forall x \in [-1,0 ] \\
			\frac{x^2 + 1}{2} && \forall x \in [0,1] \\
			1 && \forall x \in (1,\infty) \\
		\end{array}
	\right.
\\
\end{equation}
$$
Now we would write the inverse of this cdf function $F^{-1}(x)$  in range [-1,1]
$$
F_x^{-1}(x) :=
\left\{
		\begin{array}{lll}
			-\sqrt{1-2x} && \forall x \in [0,\frac{1}{2}] \\
			\sqrt{2x-1} && \forall x \in [\frac{1}{2},1] \\
		\end{array}
	\right.
\\
$$

* So now we would generate random variable between 0 and 1 and then would find inverse-CDF of that random number. 
* This would given us a random number from the PDF whose inverse-CDF we have used.

Generated random value :-  x = -0.4074

## Part 2

![histogram_M-shaped_distribution](/home/utkarsh/Documents/iitb/cs215/assignment-1/report/histogram_M-shaped_distribution.png)

![M-shaped-CDF](/home/utkarsh/Documents/iitb/cs215/assignment-1/report/M-shaped-CDF.png)

## Part 3

* Draws from $P_{Y_N}(\cdot) $ can be easily found by taking N independent draws from $P_X(\cdot)$ and then taking their average

Generated  random value :- $Y_{100}$ = -0.0265

## Part 4

![histogram_Y_1](/home/utkarsh/Documents/iitb/cs215/assignment-1/report/histogram_Y_1.png)

![histogram_Y_2](/home/utkarsh/Documents/iitb/cs215/assignment-1/report/histogram_Y_2.png)

![histogram_Y_4](/home/utkarsh/Documents/iitb/cs215/assignment-1/report/histogram_Y_4.png)

![histogram_Y_8](/home/utkarsh/Documents/iitb/cs215/assignment-1/report/histogram_Y_8.png)

![histogram_Y_16](/home/utkarsh/Documents/iitb/cs215/assignment-1/report/histogram_Y_16.png)

![histogram_Y_32](/home/utkarsh/Documents/iitb/cs215/assignment-1/report/histogram_Y_32.png)

![histogram_Y_64](/home/utkarsh/Documents/iitb/cs215/assignment-1/report/histogram_Y_64.png)

![CDF_Y_N](/home/utkarsh/Documents/iitb/cs215/assignment-1/report/CDF_Y_N.png)

## Observation

* Our results are in accordance with the fact specified in the slides **The Average of "M" random variables tends to Gaussian(approximately)**

* The Observation are in accordance with the central limit theorem

* As the value of N is increasing the histograms obtained are getting more and more Gaussian.

   
