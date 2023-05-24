%%
% Ethan Rutledge
% MATH 348
% LAB 2

format long;
clear;
clc;

%create obj for instance of class used to hold functions 
L2F = L2F;

%% Part 0
% We continue with single population models today. Last week we worked with discrete time populations. 
% This week we consider continuous time models. In class we have begun exploring the logistic model. 
% Now, we will use the computer to solve the ordinary differential equation (which, it turns out, is quite 
% easy in Matlab)

%define as timespan of across 20 generations
tspan = [0 , 20];
%set base population at t0 to 1 individual
y0 = 1;

%define t and y based on ode solver for logistic
[t, y] = L2F.solveLog(tspan, y0);

%plot to show relation between y and t
L2F.plotLog(t, y);

%% Part 1
% Find solutions to the logistic equation for several initial conditions (you should vary y0 and also 
% vary r and K to see how each alters the results. On your plots, include the carrying capacity (so you 
% should use the hold on command. Place a set of different plots (based on changes to the parameters) on 
% a single figure and make sure you label each of the solutions. You should have values of y0 that are 
% above and below K.

L2F.plotVaryingConditionLog('Logisitic');

%% Part 2
% Use your scripts from part 1 to explore the effect of constant harvesting of the population. In this 
% case see what happens when a constant amount, H is subtracted from the population per time. The 
% logistic becomes:
% (dN/dt) = rN(1 - (N/K)) - H
% Again, test several different initial conditions. Is it now guaranteed that any small initial population will 
% grow to carrying capacity? 

L2F.plotVaryingConditionLog('Harvesting');

%% Part 3
% The logistic is a quadratic equation in terms of N. Now we will consider the Allee effect. Warder Allee 
% first describe the effect in the 1930s. Through experiments he showed that some populations do better 
% when there are more individuals in a population the more likely the population will grow to carrying 
% capacity. To model this effect, the basic equation becomes: 
% (dN/dt) = rN((N/A) - 1)(1 - (N/K))
% Copy your logistic scripts and modify them to solve the Allee equation. Start with r=3.5, K=20 and A=10. 
% Vary the starting population and explore what happens. Discuss the behavior of the model as y0 is 
% varied and provide the necessary plots to show what dynamics you see.



%set specified factors
a0 = 10;
r0 = 3.5;
k0 = 20;
ts = [0, 5];

%specifiy variations in y0
y00 = 5;
y01 = 8;
y02 = 10;
y03 = 15;
y04 = 25;

%compute growth for each variation in y0 using allee model
[ta0, ya0] = L2F.solveAllee(ts, y00, r0, k0, a0);
[ta1, ya1] = L2F.solveAllee(ts, y01, r0, k0, a0);
[ta2, ya2] = L2F.solveAllee(ts, y02, r0, k0, a0);
[ta3, ya3] = L2F.solveAllee(ts, y03, r0, k0, a0);
[ta4, ya4] = L2F.solveAllee(ts, y04, r0, k0, a0);

%plot the variations one one plot 
figure;
hold on
plot(ta0, ya0, 'b-');
plot(ta1, ya1, 'r-');
plot(ta2, ya2, 'm-');
plot(ta3, ya3, 'c-');
plot(ta4, ya4, 'k-');
hold off
title(["Population Growth using Allee Model", "A = 10, R = 3.5, and K = 20"]);
xlabel('Number of Generations');
ylabel('Number of Individuals');
legend('y0 = 1','y0 = 2','y0 = 5','y0 = 10','y0 = 25', 'Location','Northwest');
                   
                   