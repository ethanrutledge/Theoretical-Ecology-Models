% Ethan Rutledge
% MATH 348
% LAB 2

classdef L2F
    %holds the functions used in lab2.m
    
    properties
    end
    
    methods (Static)
        %solves logisitic using specifc inputs for timespan, base
        %population, growth rate, and carrying capacity
        function [t, y] = solveLog(tspan, y0, r, K)
            %if not inputted just use presets in logisitic
            if nargin == 2
                %solve using built in nonstiff ode solver 
                [t, y] = ode45('L2F.logisitic', tspan , y0);
            else
                %solve using built in nonstiff ode solver 
                [t, y] = ode45(@(tspan, y0) L2F.logisitic(tspan, y0, r, K), tspan , y0);
            end
        end
        
        %ODE form of logistiic growth model
        function [ydot] = logisitic(t, y, r, K)
            %if not inputted use preset r and K
            if nargin == 2
                %preset growth factor to 0.5
                r = 0.5;

                %preset carrying capacity to 10
                K = 10;
            end
            
            %compute dy/dt for inputs
            ydot = r * y * (1 - (y / K)); 
        end
        
        %ODE form of logistic growth model with constant harvesting
        function [ydot] = harvesting(t, y, r, K, H)
            ydot = r * y * (1 - (y / K)) - H;
        end
        
        %solves the logistic model with constant harvesting
        function [t, y] = solveHarv(tspan, y0, r, K, H)
            [t, y] = ode45(@(tspan, y0) L2F.harvesting(tspan, y0, r, K, H), tspan, y0);
        end
        
        %ode form of Allee effect model
        function [ydot] = allee(t, y, r, K, A)
           ydot = r * y * ((y / A) - 1) * (1 - (y / K));
        end
        
        %solves the Allee effect model
        function [t, y] = solveAllee(tspan, y0, r, K, A)
            [t, y] = ode45(@(tspan, y0) L2F.allee(tspan, y0, r, K, A), tspan, y0);
        end
        
        %plot the logistic function 
        function plotLog(t, y)
            %plot inputs on graph with corresponding labels, title
            plot(t, y, 'b-o');
            title('Population Growth using Logisitic Model');
            xlabel('Number of Generations');
            ylabel('Number of Individuals');
        end
        
        %Plot the population growth using logistic growth model,
        %logistic with harvesting, or Allee model 
        %%PRESET:
        %Evaluates over 20 generations
        %y0: [1, 2 , 10, 20]
        %r: [0.5, 0.7, 1, 2]
        %K: [10, 1, 5, 20]
        %H: [0.2, 0.5, 1, 2]
        %A: [10, 1, 5, 20]
        %INPUT:
        %type: 'Logistic', 'Harvesting', or 'Allee'
        %will evaluate using specified model type
        %OUTPUT:
        %creates figure with plot for each varying factor
        function plotVaryingConditionLog(type)
            %evauluate of 20 generations
            ts = [0, 100];
            
            %set variatons in base populations
            y00 = 1;
            y01 = 2;
            y02 = 10;
            y03 = 20;

            %set variations in growth rate
            r0 = 0.5;
            r1 = 0.7;
            r2 = 1;
            r3 = 3.5;

            %set variations in carying capacity
            k0 = 10;
            k1 = 1;
            k2 = 5;
            k3 = 20;
            
            %determine type of function and compute growth for variations
            if strcmp(type,'Logisitic')
                %compute logistic growth for each variation in y0
                [ty0, yy0] = L2F.solveLog(ts, y00, r0, k0);
                [ty1, yy1] = L2F.solveLog(ts, y01, r0, k0);
                [ty2, yy2] = L2F.solveLog(ts, y02, r0, k0);
                [ty3, yy3] = L2F.solveLog(ts, y03, r0, k0);

                %compute logistic growth for each variation in r
                [tr0, yr0] = L2F.solveLog(ts, y00, r0, k0);
                [tr1, yr1] = L2F.solveLog(ts, y00, r1, k0);
                [tr2, yr2] = L2F.solveLog(ts, y00, r2, k0);
                [tr3, yr3] = L2F.solveLog(ts, y00, r3, k0);

                %compute logistic growth for each variation in k
                [tk0, yk0] = L2F.solveLog(ts, y00, r0, k0);
                [tk1, yk1] = L2F.solveLog(ts, y00, r0, k1);
                [tk2, yk2] = L2F.solveLog(ts, y00, r0, k2);
                [tk3, yk3] = L2F.solveLog(ts, y00, r0, k3);    
            elseif strcmp(type,'Harvesting')
                    %set variations in harvesting rate
                    h0 = 0.01;
                    h1 = 0.02;
                    h2 = 0.05;
                    h3 = 0.1;
              
                    %compute logistic growth for each variation in y0
                    [ty0, yy0] = L2F.solveHarv(ts, y00, r0, k0, h0);
                    [ty1, yy1] = L2F.solveHarv(ts, y01, r0, k0, h0);
                    [ty2, yy2] = L2F.solveHarv(ts, y02, r0, k0, h0);
                    [ty3, yy3] = L2F.solveHarv(ts, y03, r0, k0, h0);

                    %compute logistic growth for each variation in r
                    [tr0, yr0] = L2F.solveHarv(ts, y00, r0, k0, h0);
                    [tr1, yr1] = L2F.solveHarv(ts, y00, r1, k0, h0);
                    [tr2, yr2] = L2F.solveHarv(ts, y00, r2, k0, h0);
                    [tr3, yr3] = L2F.solveHarv(ts, y00, r3, k0, h0);

                    %compute logistic growth for each variation in k
                    [tk0, yk0] = L2F.solveHarv(ts, y00, r0, k0, h0);
                    [tk1, yk1] = L2F.solveHarv(ts, y00, r0, k1, h0);
                    [tk2, yk2] = L2F.solveHarv(ts, y00, r0, k2, h0);
                    [tk3, yk3] = L2F.solveHarv(ts, y00, r0, k3, h0);
                    
                    %compute logistic growth for each variation in H
                    [th0, yh0] = L2F.solveHarv(ts, y00, r0, k0, h0);
                    [th1, yh1] = L2F.solveHarv(ts, y00, r0, k0, h1);
                    [th2, yh2] = L2F.solveHarv(ts, y00, r0, k0, h2);
                    [th3, yh3] = L2F.solveHarv(ts, y00, r0, k0, h3);
            end
            
            %create figure showing specified model with plots for each
            %varying factor
            figure;
            %plot base population
            if strcmp(type,'Logisitic')
                subplot(1, 3, 1);
            else 
                subplot(1, 4, 1);
            end
            plot(ty0, yy0, 'b-');
            hold on
            plot(ty1, yy1, 'r-');
            plot(ty2, yy2, 'm-');
            plot(ty3, yy3, 'g-');
            hold off
            if strcmp(type,'Logisitic')
                title(["Varying Base Population" , "R = 0.5 and K = 10"]);
            elseif strcmp(type,'Harvesting')
                    title(["Varying Base Population" , "R = 0.5, K = 10, and H = 0.2"]);
            end
            xlabel('Number of Generations');
            ylabel('Number of Individuals');
            legend('y0 = 1','y0 = 2','y0 = 10', 'y0 = 20', 'Location','Northwest');
            %plot growth rate
            if strcmp(type,'Logisitic')
                subplot(1, 3, 2);
            else
                subplot(1, 4, 2);
            end
            plot(tr0, yr0, 'b-');
            hold on
            plot(tr1, yr1, 'r-');
            plot(tr2, yr2, 'm-');
            plot(tr3, yr3, 'g-');
            hold off
            if strcmp(type,'Logisitic')
                title(["Varying Growth Rate", "y0 = 1 and K = 10"]);
            elseif strcmp(type,'Harvesting')
                    title(["Varying Growth Rate", "y0 = 1, K = 10, and H = 0.2"]);
            end
            xlabel('Number of Generations');
            ylabel('Number of Individuals');
            legend('r = 0.5','r = 0.7','r = 1', 'r = 3.5', 'Location','Northwest');
            %plot carrying capacity
            if strcmp(type,'Logisitic')
                subplot(1, 3, 3);
            else 
                subplot(1, 4, 3);
            end
            plot(tk0, yk0, 'b-');
            hold on
            plot(tk1, yk1, 'r-');
            plot(tk2, yk2, 'm-');
            plot(tk3, yk3, 'g-');
            hold off
            if strcmp(type,'Logisitic')
                title(["Varying Carrying Capacity", "y0 = 1 and R = 0.5"]);
            elseif strcmp(type,'Harvesting')
                    title(["Varying Carrying Capacity", "y0 = 1, R = 0.5, and H = 0.2"]);
            end
            xlabel('Number of Generations');
            ylabel('Number of Individuals');
            legend('K = 10','K = 1','K = 5', 'K = 20', 'Location','Northwest');
            if strcmp(type,'Harvesting')
               subplot(1, 4, 4);
               plot(th0, yh0, 'b-');
               hold on
               plot(th1, yh1, 'r-');
               plot(th2, yh2, 'm-');
               plot(th3, yh3, 'g-');
               hold off
               title(["Varying Harvesting Rate", "y0 = 1, R = 0.5, and K = 10"]);
               xlabel('Number of Generations');
               ylabel('Number of Individuals');
               legend('H = 0.01','H = 0.02','H = 0.05','H = 0.1', 'Location','Southeast');
               axis([0 100 9.5 10]);
            end
            suptitle(['Population Growth using ', type, ' Model']);
        end
    end
end

