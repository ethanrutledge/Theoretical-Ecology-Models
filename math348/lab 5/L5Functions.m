classdef L5Functions
    %hold the functions needed for the lab 5 main script
    
    properties
    end
    
    methods (Static)
                %creates matrix of population of each age class at each year based
                %off of provided leslie matrix
                %INPUTS:
                %L = Leslie Matrix
                %N0 = vector of initial populations of each age class
                %a = number of age classes
                %t = number of years to calculate over
                %OUTPUTS:
                %N = matrix of size a x t of population of each class at each year
        function[N] = popFin(L, N0, a, t)
            %create empty matrix of correct size to fill in 
            N = zeros(a, t);
            
            %input the initial condition
            N(:, 1) = N0;
            
            %compute population values at each year
            for t = 2:t
               N(:, t) = L * N(:, t - 1); 
            end
        end
        
                %plot the age class populations over time on a linear plot
                %INPUT:
                %N = matrix of size (num of age classes) x (num of years) and holds
                %the population of each age class at each year
        function linearPlot(N)
           %number of age classes
           a = length(N(:, 1));
           
           %create string to hold legend 
           labels = string(linspace(1, a, a));
           
           %create linear plot 
           plot(N');
           xlabel('Number of years');
           ylabel('Number of individuals');
           title("Linear Plot");
           legend(labels);
        end
        
                %plot the age class populations over time on a semi-log y plot
                %INPUT:
                %N = matrix of size (num of age classes) x (num of years) and holds
                %the population of each age class at each year
        function semilogPlot(N)
           %number of age classes
           a = length(N(:, 1));
           
           %create string to hold legend 
           labels = string(linspace(1, a, a));
           
           %create semi log y plot
           semilogy(N');
           xlabel('Number of years');
           ylabel('Number of individuals');
           title("semi-log y Plot");
           legend(labels);
        end
        
                %calculate and create plot of the growth rate change between years
                %for population
                %N = matrix of size (num of age classes) x (num of years) and holds
                %the population of each age class at each year
        function plotGrowthRate(N)
            %calculate max years for N
            tmax = length(N(1, :));
            
            %create matrix to fill in growth rate changes between years
            r = zeros(1, tmax);
            
            for t = 2 : tmax
                r(1, t) = sum(N(:, t))/sum(N(:, t - 1));
            end
            
            %plot the growth rate at each generation
            figure;
            plot(r);
            xlabel('Number of years');
            ylabel('Growth rate');
            title(['Growth rate change over ', num2str(tmax), ' years']);
        end
        
                %calculate and create plot of the relative percents of each age
                %class for each year over time period
                %for population
                %N = matrix of size (num of age classes) x (num of years) and holds
                %the population of each age class at each year
        function plotAgePercents(N)
            %calculate max years for N
            tmax = length(N(1, :));
            %calculate number of age classes in N
            amax = length(N(:, 1));
            
            %calculate percent of age class at each year
            perc = zeros(amax, tmax);

            for a= 1 : amax
                for t = 1 : tmax
                    perc(a, t) = N(a, t)/sum(N(:, t));
                end
            end
            
            %create string to hold legend 
            labels = string(linspace(1, amax, amax));

            %plot the percent of each age class at each year
            figure;
            plot(perc');
            xlabel('Number of years');
            ylabel('Percent of total population');
            title(['Percent of total population of each age class over ', num2str(tmax), ' years']);
            legend(labels);
        end 
    end
end

