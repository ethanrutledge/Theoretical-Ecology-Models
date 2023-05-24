%Ethan Rutledge
%12/13/22
%MATH 348
%Final Project

%This model is based off of the one described in the 1995 paper "Evolution
%as a self-organized critical phenomenon" by Sneppen, et. al. published in
%PNAS

% Sneppen K, Bak P, Flyvbjerg H, Jensen MH. Evolution as a self-organized 
%     critical phenomenon. Proc Natl Acad Sci U S A. 1995 May 23;92(11): 
%     5209-13.doi: 10.1073/pnas.92.11.5209. PMID: 7761475; PMCID: PMC41878.


%------------------ABSTRACT (from the original paper)----------------------
% We present a simple mathematical model of biological macroevolution. The 
% model describes an ecology of adapting, interacting species. The 
% environment of any given species is affected by other evolving species; 
% hence, it is not constant in time. The ecology as a whole evolves to a 
% "self-organized critical" state where periods of stasis alternate with 
% avalanches of causally connected evolutionary changes. This characteristic 
% behavior of natural history, known as "punctuated equilibrium," 
% thus finds a theoretical explanation as a self-organized critical 
% phenomenon. The evolutionary behavior of single species is intermittent. 
% Also, large bursts of apparently simultaneous evolutionary activity 
% require no external cause. Extinctions of all sizes, including mass 
% extinctions, may be a simple consequence of ecosystem dynamics. Our 
% results are compared with data from the fossil record.

%-----------------------------OUTLINE--------------------------------------.
%The probability of evolution a species to next "state" is:
%                   P = exp(-B/T)
%                       P == Probality
%                       B == number of mutations seperating current state 
%                            and next
%                       T == effective mutation parameter defining
%                              timesale of mutations
%With the assumption that: a species with low fitness is more likely to
%evolve to a higher next fitness state than a species with already high 
%fitness, B becomes a measure of fitness. 
%The model relates nearby species as links on a chain, if one species
%evolves then its direct neighbors will also evolve in response.
%Thus if a species currently has a high fitness and it's neighbor evolves
%it is very unlikely that it will retain this high fitness.
%The model uses the limit case that T is very low. This leads to the
%species with lowest B always being the next species to evolve.

%------------------------------MODEL---------------------------------------
% The model I created was structured as 200 species in a "chain" each being
% effected by the mutation of its direct neighbors (not circular). They are
% all randomly assigned a b value (fitness) that ranges from 0-1, the
% initial dispersion appears to have no effect on outcomes. The species
% which has the lowest b value has a p probability it mutates. If it does 
% then it and its neighbors, evolve at the next time. The evolution is 
% expressed as a new random assignment to their b value. The model is run 
% for 100 iterations to track average values throught.

%-----------------------------RESULTS--------------------------------------
%Over time the entire group of species trended towards higher fitness. As
%expressed in the paper, there is a critical b value of approximately 0.667
%at which most species remain above. If one or more species is below this 
%threshold than it is defined as an extinction event. If too many species 
%fall below the threshold than a mass extinction event occurs. The average
%b value of the lowest b value species is 0.1996. It is a near 50/50 ratio 
%of advantageous to deleterious mutations. Over 100 iterations, with 1000 
%steps per iteration, the average number of advantageous mutations and
%deleterious mutations were 1543 and 1448 respectively. This is a logical
%result of the model but does not necessarily make sense in reality. In
%nature it is more common for mutations to be slightly deleterious. Below
%are shown figures of an example group of species at various snapshots
%throughout the time period. It is clear how the group trends towards
%higher total fitness over time than the intial state. I chose this
%specific iteration to show what a mass extinction event looks like which
%occured around t = 200. Even at t = 400 the group had not fully recovered.
%By t = 600 significant improvement is seen and then by t = 1000 the total
%fitness is very high.

%-------------------------------CODE---------------------------------------
%clear the workspace and command window
clear;
clc;

%set the number of species, number of timesteps, and number of iterations
numSpecies = 200;
tmax = 1000;
iterMax = 100;

%matrix will hold the fitness of each species at each time step for all
%iterations
global fitness;
fitness = zeros(tmax, numSpecies, iterMax);

%stores some values for later calculations
goodEvolAll = zeros(1, iterMax);
badEvolAll = zeros(1, iterMax);
bLowAveAll = zeros(1,iterMax);

%as defined in the paper T is set very low to 0.01
T = 0.01;

%run model for iterMax number of iterations
for i = 1:iterMax
    %randomly assign the fitness (0-1) of each species for t=1
    for s = 1:numSpecies
        r = rand();
        fitness(1,s,i) = r;
    end

    %to store what lowest b vals are at each time step
    bLowAll = zeros(1, tmax);

    %to store num of positive evolutions/ negative evolutions
    global goodEvol 
    goodEvol = 0;
    global badEvol 
    badEvol = 0;

    %iterates for tmax steps and evols each species as defined by model
    for t = 2:tmax
        %find species with lowest B value and also copy over previous t 
        %step b values to current t step
        bLow = fitness(t-1,1,i);
        fitness(t,1,i) = bLow;
        bLowSpecies = 1;

        for s = 2:numSpecies
            fitness(t,s,i) = fitness(t-1,s,i);
            if fitness(t,s,i) < bLow
                bLow = fitness(t,s,i);
                bLowSpecies = s;
            end
        end

        %record lowest bval for cur t
        bLowAll(1, t) = bLow;

        %species w/ lowest b val and its neighbors get new b vals
        p = exp(bLow/T);
        r = rand();
        if r < p
            r = rand();
            chkEvol(r, t, bLowSpecies, i);
            fitness(t, bLowSpecies, i) = r;
            if bLowSpecies ~= 1
                r = rand();
                chkEvol(r, t, bLowSpecies - 1, i);
                fitness(t, bLowSpecies - 1, i) = r;
            end
            if bLowSpecies ~= numSpecies
                r = rand();
                chkEvol(r, t, bLowSpecies + 1, i);
                fitness(t, bLowSpecies + 1, i) = r;
            end
        end
    end
    
    %add to iter trackers
    goodEvolAll(1, i) = goodEvol;
    badEvolAll(1, i) = badEvol;

    %calculate average lowest b val
    bLowAve = sum(bLowAll)/tmax;
    bLowAveAll(1,i) = bLowAve;

    %to help with formatting plots
    ts = [1, round(tmax/5,0), round(2*(tmax/5),0), round(3*(tmax/5),0), round(4*(tmax/5),0), tmax];
    
    %create an example plot of bvals over time
    if i == 1
        %plots the bvals at 4 time steps on one figure
        figure;
        for p = 1:length(ts)
            subplot(3,2,p)
                hold on
                plot(fitness(ts(p),:, 1), '.b');
                yline(0.667, 'r','b crit', 'LabelVerticalAlignment', 'Bottom');
                hold off
                xlabel('Species Number');
                ylabel('B Value');
                title(['t = ', num2str(ts(p))]);
        end 
        suptitle('Snapshots of B Values at Increasing Time Steps');
    end
end

%calculate ave number of good evolutions and bad evolutions
goodEvolAve = sum(goodEvolAll)/iterMax;
badEvolAve = sum(badEvolAll)/iterMax;

bLowTotAve = sum(bLowAveAll)/iterMax;


%check if evoltution was to higher b val or lower
function chkEvol(r, t, s, i)
    global fitness;
    global goodEvol;
    global badEvol;
    
    if r > fitness(t - 1, s, i)
        goodEvol = goodEvol + 1;
    else
        badEvol = badEvol + 1;
    end
end









