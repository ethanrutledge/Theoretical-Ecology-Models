%Ethan Rutledge
%10/6/22
%MATH 348
%lab 6

clear;
clc;
%% -----------------part 1 - population growth by age group
%create transition matrix
T = [0      0.966   0.013   0.007   0.008   0;
     0      0       0.01    0       0       0;
     0      0       0.125   0.125   0.038   0;
     0      0       0       0.238   0.245   0.023;
     0      0       0       0       0.167   0.75;
     322.38 0       3.448   30.17   0.862   0];

%set num of years to calc over
tmax = 15;

%set initial population (not defined in lab)
N0 = [10;
      10;
      10;
      10;
      10;
      10];

%calculate population over tmax using transition matrix
N = zeros(6,tmax);
N = pop(N0, T, tmax);
 
%holds labels for groups
labels = categorical({'Dormant Seeds 1','Dormant Seeds 2','Rosette Small','Rosette Medium','Rosette Large','Flowering'});
 
%plot the population growth of each age class
plotN(N);
suptitle('Population Growth of each Age Class');
%% -------------------part 2 - relative population bar graph
%will hold the relative values
rel = zeros(1, 6);

%calculate percent of each group relative to total population
for a = 1:6
    rel(1, a) = N(a, tmax)/sum(N(:,tmax));
end

%plot on a bar graph
figure;
bar(labels,rel);
title('Relative Value of each Life Stage');
%% -----------------part 3 - reproductive value bar graph
%will hold the reproductive values
R = zeros(1, 6);

%calculate proportion of offspring at t to num in age class at t-1
for a = 1:6
    R(1, a) = N(1,tmax)/N(a,tmax - 1);
end

%plot on bar graph
figure;
bar(labels,R);
title('Reproductive Value of each Life Stage');
%% ---------------------part 4 - beetle harvesting of flowers
%create new transtition matrix adjusted for harvesting 
Beetle = T;
Beetle(:, 6) = 0.2 .* Beetle(:, 6);

%recalculate the population
BeetleN = zeros(6, tmax);
BeetleN = pop(N0, Beetle, tmax);

%plot the population of each age class
plotN(BeetleN);
suptitle('Population Growth with Beetle Harvesting');
%% --------------------part 5 - fungus harvesting of seed 1
%create new transtion matrix adjusted for harvesting
fungus = T;
fungus(:, 1) = 0.2 .* fungus(:, 6);

%recalculate population
fungusN = zeros(6, tmax);
fungusN = pop(N0, fungus, tmax);

%plot the population of each age class
plotN(fungusN);
suptitle('Population Growth with Fungus Harvesting');
%% -------------------functions section
    %pop
    %creates matrix of size (age classes) x (tmax) and calculates the
    %population of each age class at each year using the transtion matrix
    %INPUT:
    %N0 = initial population vector
    %T = transtion matrix
    %tmax = number of years to calculate over
    %OUTPUT:
    %N = age class population matrix
function [N] = pop(N0, T, tmax)
    %create blank matrix and insert initial condition
    N = zeros(6,tmax);
    N(:, 1) = N0;
    
    %calculate population of each age class at each year using T
    for t = 2 : length(N(1,:))
        N(:,t) = T' * N(:,t-1);
    end
end

    %plotN
    %creates subplot of linear and semilogy for age class population matrix
    %INPUT:
    %N = holds population values for each age class at each year 
    %   is of size (ageclass) x (tmax)
function plotN(N)
    figure;
    subplot(1, 2, 1);
    plot(N');
    title('Linear');
    xlabel('Number of Individuals');
    ylabel('Number of Years');
    legend('Dormant Seeds 1','Dormant Seeds 2','Rosette Small','Rosette Medium','Rosette Large','Flowering','Location', 'Northwest');
    subplot(1, 2, 2);
    semilogy(N');
    title('Semi-Log Y');
    xlabel('Number of Individuals');
    ylabel('Number of Years');
    legend('Dormant Seeds 1','Dormant Seeds 2','Rosette Small','Rosette Medium','Rosette Large','Flowering','Location', 'Northwest');
end









