# dosp_project1
Group: SV_1=>Sneha Edupuganti and Varshini kopparla

## Problem Statement:
This project implements the actor model in Pony to parallelize the task of finding sums of perfect squares across a range of numbers. The approach involves creating worker actors to handle sub-problems (ranges of numbers), while a boss actor distributes tasks and manages overall computation. The goal is to divide the problem across multiple workers using Pony’s concurrency features to ensure high parallelism and low computational overhead.

## Work Unit Size and Its Determination Method
In your code, the work unit size, work_size, is determined by dividing the total number of sub-problems by the number of workers; in other words, work_size = n_input/workers. Here, you've set the number of workers to be 200 by default unless your input size, n_input, is less than 200. You might need for each worker to work on a chunk of the work, which will be about 5000 sub-problems as described in your output.
### Finding Optimal Performance
Performance Consideration: The performance optimization comes from balancing the load across workers. You slice the input into chunks of roughly equal-sized sub-problems to reduce at least some idleness, as every worker also has some amount of work to be done.

Adjustments in Work Size: If the number of sub-problems isn't divisible evenly—that is, came out with a remainder—then the last chunk comes out a little bigger. This adjustment ensures that all the sub-problems are dealt with without causing huge imbalances. Smaller work size implies more workers that can potentially reduce execution time due to more parallelism but may lead to more overhead in the creation and communication of actors. Again, this seems to be optimally set by trial and error or observing CPU usage at 200 workers.

## Output of Running Your Program for projectpony.exe 1000000 24
The output of the program for this run is a list of numbers. Each of the numbers is the starting number of a run of consecutive integers such that the sum of their squares is a perfect square. For example, the number 1 indicates that the sum of the squares of the integers beginning at 1 and extending over 24 consecutive integers is a square. The program does this with n_input=1000000 and k_input=24, division of the input into 200 chunks of approximately 5000 numbers each. Every worker will check if the sum of squares of 24 consecutive numbers starting from each number in their range forms a perfect square.
output:
![image](https://github.com/user-attachments/assets/177aad9f-a46b-4f0b-b234-02941086ffd2)

## Running Time and CPU Usage for Different Inputs
For projectpony.exe 1000000 24: the running time is:
Real Time: 0.065 seconds
CPU Time: 0.33 seconds
CPU Time to Real Time Ratio: 5.08
Cores Used: Effectively used approx. 5 cores.

![image](https://github.com/user-attachments/assets/f5f48f15-9802-417b-9721-6f0fe7c0e47a)

## For projectpony.exe 1000000 4:
This would result in a smaller window k=4, meaning each worker is required to process fewer amounts of consecutive squares in his/her range. This will give a running time that is likely to be slightly faster because of fewer iterations in the sum calculation.
![image](https://github.com/user-attachments/assets/bacb03ed-6683-49bf-b9ec-20b22ed72562)


## Comparison:

Real Time will be reduced.
CPU Time may decrease but still reflect an effective parallelism due to the use of multiple cores.
Key observation:
The CPU Time to Real Time Ratio measures if parallelism is effective when the ratio is > 1. A ratio of 5.08 means 5 times more CPU cycles were consumed than wall-clock time, which means 5 cores have been computing in parallel.

## Practical Application of the Problem
The problem—some number is a sum of perfect squares over a consecutive range of integers—finds some real-world use in:
Cryptography: Perfect squares and number theory have much to do with cryptographic algorithms. Efficient computation of problems such as these aids research into cryptographic protocols.
Research in Mathematics: This algorithm can be useful in exploring patterns in number theory. For instance, identifying which numbers can be written as a sum of consecutive squares may have real-world applications in advanced algebra or proofs.
Demonstration of Parallel Computing: Your code really illustrates just how much quicker a computation can be if you parallelize it correctly; that would make for a pretty good case study in optimizing algorithms for multi-core processors. It provides a template for a very common challenge in distributed systems—work distribution among several workers in the most efficient way.
Simulations or Game Physics: Perfect square sums can be of great use in simulations, in the design of games, or within physics engines whereby, through the use of squares in your calculation, the simulated trajectories or forces take hold
