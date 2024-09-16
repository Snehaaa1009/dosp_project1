# dosp_project1
Group: SV_1=>Sneha Edupuganti and Varshini kopparla

Problem Statement:
This project implements the actor model in Pony to parallelize the task of finding sums of perfect squares across a range of numbers. The approach involves creating worker actors to handle sub-problems (ranges of numbers), while a boss actor distributes tasks and manages overall computation. The goal is to divide the problem across multiple workers using Pony’s concurrency features to ensure high parallelism and low computational overhead.

Solution Architecture
Boss Actor:
Breaks the input problem (n numbers) into smaller chunks.
Assigns each chunk to a worker actor.
Tracks results and ensures all workers complete their assigned tasks.
Worker Actor:
Receives a range of numbers and checks if the sum of squares from i to i+k is a perfect square.
Reports results to the boss, who aggregates them.
Work Unit Size:
•	The optimal work unit size was determined by dividing the total tasks (n) into chunks that workers can handle efficiently. For example, when n = 1,000,000 and k = 4, eight workers were employed, each handling 125,000 numbers.
•	Even distribution of tasks is key. If one worker handles a large remainder, it leads to inefficiency.
Sliding Window Mechanism:
A sliding window was used when the input range wasn’t cleanly divisible by the number of workers or when the number of workers was odd. This ensured no worker was overloaded with tasks.







Performance Evaluation

Command Execution:

![image](https://github.com/user-attachments/assets/7533f9bf-cba8-4769-8f4c-8fdeb58b7e66)

 
This output shows eight workers handling 125,000 numbers each.

Time and Parallelism Evaluation: 

![image](https://github.com/user-attachments/assets/00c2086e-549a-4e1b-8e56-fb71547f5a8b)




This ratio indicates that about four cores were utilized in parallel. The CPU time to real time ratio of 4.11 indicates effective parallelism, with approximately 4 cores being used efficiently. The real time taken was minimal at 0.065625 seconds, showing that the task was completed quickly due to the division of labor across multiple workers.
Maximum Problem Solved:

Largest problem size solved: 1,000,000 numbers with k = 4.
Larger sizes may need more efficient task distribution or additional resources, but the current problem was handled efficiently with good parallelism.
