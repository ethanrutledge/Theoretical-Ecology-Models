%Ethan Rutledge
%12/15/22
%MATH 348
%Final Exam 

clear; 
clc;

%------------------------------PROBLEM 2----------------------------------

%define predefined variables
M = 100;
R0 = 1.15;
N0 = 0.5;
tmax = 80;

%matrix to hold population values
N = zeros(1, tmax);
%set initial population
N(1) = N0;

%compute population at each step using Beverton-Holt
for t = 2:tmax
    N(t) = (R0 * N(t-1)) / (1 + (N(t-1)) / M);
end

figure;
plot(N)
xlabel('Generations');
ylabel('Population');
title('Beverton-Holt Model');


t = linspace(0,1,100);
N = BH(t, R0, M);

figure;
hold on
plot(t, N)
plot(t, t, 'r')

t(1) = 1.13;
for i = 1:100
    t(i+1) = BH(t(i), R0, M);
    line([t(i),t(i)],[t(i),t(i+1)],'Color','g');
    line([t(i),t(i+1)],[t(i+1),t(i+1)],'Color','g');
end

t(1) = 1.15;
for i = 1:100
    t(i+1) = BH(t(i), R0, M);
    line([t(i),t(i)],[t(i),t(i+1)],'Color','b');
    line([t(i),t(i+1)],[t(i+1),t(i+1)],'Color','b');
end
hold off


function N = BH(N0, R0, M)
    N = (R0.*N0)/(1+(N0/M));
end


























