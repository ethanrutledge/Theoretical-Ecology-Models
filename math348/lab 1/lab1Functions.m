% Ethan Rutledge
% MATH 348
% LAB 1

classdef lab1Functions
    %holds functions used in lab1 script
    properties
    end
    
    methods (Static)
        %create vector of population growth over given period using fibonacci model
        function[N] = fib(mo)
            %create vector of zeros to fill in fib sequence
            N = zeros(1, mo);

            %begin with population of 1 at month 1 and month 2
            N(1, 1) = 1;
            N(1, 2) = 1;

            %fill in remainder of vector with fib sequence
            for i = 1:mo - 2
                N(1, i + 2) = N(1, i + 1) + N(1, i);
            end
        end

        %plot population growth over given period using fibonacci model
        function plotfib(mo)
            %retrieve fib sequence for given period
            N = zeros(1, mo);
            N = lab1Functions.fib(mo);
            xAx = linspace(1, mo, mo);

            %plot the sequence
            figure;
            plot(xAx, N, 'b.');
            title('Population Growth using Fibonacci Model');
            xlabel('Months');
            ylabel('Number of Individuals');
        end
        
        %copy of plotfib without the title, axis so it can be used later cleaner
        function plotfibCombo(mo)
            %retrieve fib sequence for given period
            N = zeros(1, mo);
            N = lab1Functions.fib(mo);
            xAx = linspace(1, mo, mo);

            %plot the sequence
            plot(xAx, N, 'b.');
        end

        %print population at given months using fibonacci model
        function printfib(mo)
            %retrieve the fib for time period and pull population at end 
            N = zeros(1, mo);
            N = lab1Functions.fib(mo);
            population = N(mo);

            %print 
            fprintf('Population at %d months is %d\n', mo, population);
        end

        %plot population growth using geometric and fibonacci models
        function plotGeoFib(t, R)
            %retrieve population at each generation using geometric model
            curP = zeros(1, t);
            curP = lab1Functions.geo(t, R);

            %plot population at each generation from both geometric model and fibonacci sequence
            figure;
            plot(curP, 'r.');
            hold on
            lab1Functions.plotfibCombo(t);
            hold off
            legend('Geometric','Fibonacci','Location','Northwest');
            title('Population Growth using Geometric and Fibonacci Models');
            xlabel('Generations');
            ylabel('Number of Individuals');
        end

        %print the population at given t using geometric growth for given r
        function printGeo(t, R);
        %retrieve geometric sequence for given t and R and pull end population
        pTemp = zeros(1, t);
        pTemp = lab1Functions.geo(t, R);
        pop = pTemp(1, t);

        fprintf('Population at %d generations is %d\n Growth Rate(R) is %3.2f\n', t, pop, R);
        end

        %create vector of population at each generation using geometric growth
        function[P] = geo(t, R)
            %start with blank vector and set population at generation 1 to 1
            P = zeros(1, t);
            P(1, 1) = 1;

            %fill in remainder of vector using geometric growth model
            for q = 1:t
                P(1, q + 1) = exp(R*(q+1));
            end
        end
   end
end

