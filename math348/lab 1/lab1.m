%%
% Ethan Rutledge
% MATH 348
% LAB 1
format long;
clear;
clc;

%create obj of class used for functions
L1F = lab1Functions;
%%
% Part 1:
% Your first project is to produce a script that computes the number of rabbits at a particular month. 
% First compute the number of rabbits at one year (the original question posed in Liber Abaci). 
% The sequence starts 1, 1, 2, … . Then compute the number of rabbits in the 50th month. 
% After computing these, modify the script to plot the growth in rabbits over 100 months. 
% Since this is a discrete system, the plot should only be points and not a continuous line. 
% To do that, you can do something like, plot(Population, ‘r.’), which will produce red dots for each value. 


%run function for given inputs
L1F.fib(12);
L1F.printfib(12); 

L1F.fib(50);
L1F.printfib(50);

L1F.fib(100);
L1F.printfib(100);
L1F.plotfib(100);

%%
% Part 2:
% Now generate a graph for the geometric growth model, Nt=R^t * N0 for 100 generations. 
% Plot both this and the Fibonacci sequence on the same graph 
% (remember, all graphs need to have a title, axes labels, and some indication of which curve belongs to which function). 
% Experiment with R to find a growth rate that causes the geometric growth to be similar in scale to the Fibonacci sequence .

%adjust to try to find closest R 
%found 0.473 to be closest to fibonacci growth 
R = 0.473;

%determine population using geometric growth model and plot it alongside a fibonacci model
L1F.geo(100, R);
L1F.printGeo(100, R);
L1F.plotGeoFib(100, R);
%%
% In this project, you will compute the exponential growth equation over a range of values of r between      
% -0.1 and 0.1 (use 10 intervals). Start with N(0)=10 and compute it for 10 generations. The goal is to 
% In your figure you should label the axes and title the graph. The pink surface is just a flat plane at N=10 
% to show the initial population value. Since this is a three-dimensional plot you will need to use surf to 
% get this appearance. To include both surfaces, you need to execute it in this manner:
% surf(Pop, 'FaceColor','g', 'FaceAlpha',0.5, 'EdgeColor','none')
% hold on;
% surf(n10, 'FaceColor','r', 'FaceAlpha',0.5, 'EdgeColor','none')
% hold off;
% Pop and n10 are the 10x10 arrays of values that contain the populations over the 10 generations or the 
% constant value of 10 – your variable names can be whatever you want.

%create blank matrix to build on
mat = zeros(10,10);

%set starting r value and population at t = 0
rtemp = -0.1;
n0 = 10;

%iterate across 10 generations and r -0.1 to 0.1 and calculate population at each point
for ri = 1:10
    for ti = 1:10
        mat(ti, ri) = exp(ti*rtemp) * n0;
    end
    rtemp = rtemp + 0.02;
end

%create matrix of population at t = 0
n0Mat = zeros(10,10)+n0;

%plot both matrices together
figure;
surf(mat, 'FaceColor','g', 'FaceAlpha',0.5, 'EdgeColor','none')
hold on;
xlabel('Number of Generations');
ylabel('Growth Rate');
zlabel('Population');
title('Population variance with R of -0.1 to 0.1 over 10 generations');
surf(n0Mat, 'FaceColor','r', 'FaceAlpha',0.5, 'EdgeColor','none')
hold off;