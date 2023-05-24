%Ethan Rutledge
%9/29/22
%MATH 348
%LAB 5

clear;
clc;

func = L5Functions;

%% ----------------------------part 1---------------------------------
%----------------------------question 1-------------------------------
%leslie matrix for crabs
crabL = [0   4   3;
         .5  0   0; 
         0  .25  0];

%---------------------------question 2-------------------------------
%initial populations of each age class
crabN0 = [10; 10; 10];

%number of age classes
ages = 3;

%set 2 time periods
ta = 20;
tb = 50;

%calculate for each time period
crabT1N = func.popFin(crabL, crabN0, ages, ta);
crabT2N = func.popFin(crabL, crabN0, ages, tb);

%plot linear and semi log for time 1
figure;
subplot(1, 2, 1);
func.linearPlot(crabT1N);
subplot(1, 2, 2);
func.semilogPlot(crabT1N);
suptitle(["Crab Population Growth of each Age Class over 20 years"]);

%plot linear and semi log for time 2
figure;
subplot(1, 2, 1);
func.linearPlot(crabT2N);
subplot(1, 2, 2);
func.semilogPlot(crabT2N);
suptitle(["Crab Population Growth of each Age Class over 50 years"]);

%---------------------------question 3---------------------------------
%plot how growth rate changes over time period for total population
func.plotGrowthRate(crabT1N);
func.plotGrowthRate(crabT2N);

%---------------------------question 4---------------------------------
%plot how relative percent of each age class changes over time period
func.plotAgePercents(crabT1N);
func.plotAgePercents(crabT2N);

%--------------------------question 5-----------------------------------
%computes and prints the eigen vector for the leslie matrix
eigen_vector = eig(crabL)

%% -------------------------part 2----------------------------------
%--------------------------question 1-------------------------------
%leslie matrix for salmon population
salmonL = [0    0    0   5000; 
           .05  0    0   0; 
           0    .07  0   0; 
           0    0    .33 0];

%------------------------question 2---------------------------------
%initial populations of each age class
salmonN0 = [1000; 0; 0; 0];

%calculate population of each age class each year over 50 years
salmonN = func.popFin(salmonL, salmonN0, length(salmonN0(:, 1)), 50);

%plot population of each age class over time period
figure;
subplot(1, 1, 1);
func.linearPlot(salmonN);
suptitle(["Salmon Population Growth of each Age Class over 50 years"]);

%-----------------------question 3---------------------------------
%create blank matrix to fill and set initial population
salmonNadj = zeros(4, tb);
salmonNadj(:,1) = [2000; 0; 0; 0];

%calculate salmon at each year then add in 1000 fry for first 4 years
for t = 2:tb
    salmonNadj(:, t) = salmonL * salmonNadj(:, t - 1); 
    
    if (t == 2) | (t == 3) | (t == 4)
       salmonNadj(1, t) = salmonNadj(1, t) + 1000; 
    end
end
%plot population of each age class over time period
figure;
subplot(1, 1, 1);
func.linearPlot(salmonNadj);
suptitle(["Salmon Population Growth of each Age Class over 50 years", "with 1000 fry added first four years"]);

%-----------------------question 4----------------------------------
%adjust the survival rate from year 3 to 4 to represent fishing when
%returning to spawn
salmonLadj = [0    0    0   5000; 
             .05   0    0    0; 
              0   .07   0    0; 
              0    0   .15   0];

%calculate population of each age class each year over 50 years
salmonNfishing = func.popFin(salmonLadj, salmonN0, length(salmonN0(:, 1)), 50);

%plot population of each age class over time period
figure;
subplot(1, 1, 1);
func.linearPlot(salmonNfishing);
suptitle(["Salmon Population Growth of each Age Class over 50 years", "with fishing occuring when returning to natal streams"]);













