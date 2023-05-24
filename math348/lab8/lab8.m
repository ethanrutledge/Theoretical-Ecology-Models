%Ethan Rutledge
%10/20/22
%MATH 348
%lab 8

clear;
clc;

maxsize=1000; %number of individuals in the population
maxweek=20;   %duration of the model run

numrun = 100;
suminf = zeros(1, numrun);
avewk = zeros(1, numrun);

R0PerWkPerSim = zeros(maxweek, numrun);

for i = 1:numrun   
    %Set up the graph (as an Adjacency matrix)
    R=randi([0,1],maxsize) .* randi([0,1],maxsize);
    Filter=rand(maxsize) <0.97;
    R=(R&Filter) & ~eye(maxsize) +0;
    Adjacency=R-tril(R,-1)+triu(R,1)';
    
    %Set up the vectors to keep track of the currently infected, newly
    %infected and individuals infected in the past. Assumed that an
    %individual can only infect during a single week and after that cannot
    %infect or be infected again
    infected=zeros(maxsize,1);
    newinfected=zeros(maxsize,1);
    previnfected=zeros(maxsize,1);
    
    %Randomly pick the first individual to be infected
    patient_zero=randi([1,maxsize],1);
    weeklycount=zeros(maxweek,1);
    totalcount=0;
    infected(patient_zero,1)=1;   
    
    for week=1:maxweek
        weekval=week;
        
        for row=1:maxsize
            for column=1:maxsize
                %if the individual at the column number is currently
                %infected and the individual in the row number is not and
                %has not previously been infected and they are connected
                %then determine if the row individual is now infected
                if infected(column,1)==1 & Adjacency(row,column)>0 & infected(row,1)~=1 & newinfected(row,1) ~= 1 & previnfected(row,1) == 0
                    %----------MODIFY THIS PART *vvvvv* TO CHANGE INFECTION PROBABILITY
                    if rand(1)>((.99)+((1-0.99)*(0.0)))
                        newinfected(row,1)=1;
                    end;                   
                end;
            end;
        end;
        
        if sum(infected) ~= 0  
            R0PerWkPerSim(weekval, i) = sum(newinfected)/sum(infected);
        end
        
        %Keep track of everyone who has been infected and the counts
        previnfected=previnfected+infected;
        infected=newinfected;
        newinfected=zeros(maxsize,1);
        weeklycount(week)=sum(sum(infected));
        totalcount=totalcount+weeklycount(week);   

    end;

    suminf(1, i) = totalcount;
    avewk(1, i) = totalcount/maxweek;
end

aveinfected = sum(suminf)/numrun;

R0PerSim = zeros(1, numrun);

for col = 1:numrun
    infWk = 0;
    for row = 1:maxweek
        if R0PerWkPerSim(row, col) > 0
            infWk = infWk + 1;
        end
    end
    
    if infWk ~= 0
        R0PerSim(1, col) = sum(R0PerWkPerSim(:,col))/infWk;
    end
end

R0 = sum(R0PerSim)/numrun;

fprintf('Average Number of Total Infected: %4.2f \nAverage Number Infected per Individual: %4.2f\n', aveinfected, R0)

figure;
subplot(1, 2, 1)
plot(avewk);
title(["Average Number of Individuals Infected per Week", "over 100 simulations"]);
xlabel('Number of Individuals');
ylabel('100 Simulations');
subplot(1, 2, 2)
plot(weeklycount');
title('example simulation');
ylabel('Number of Individals infected');
xlabel('week number');
suptitle('standard infection probability');
