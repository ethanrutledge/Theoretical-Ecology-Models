classdef L3F
    %Holds functions used in lab3 script
    
    properties    
    end
    
    methods (Static)
        %produces cobweb diagram
        function pop = webEQ(x, r)
            %eqution for logisitic growth
            pop = r .* x .* (1-x);
        end
        
        %ode form of Allee effect model
        function [Ndot] = allee(t, N, r, K, A)
           Ndot = r .* N .* ((N ./ A) - 1) .* (1 - (N ./ K));
        end
        
        %plots cobwebbing for 
        function plotWeb(r)
            %set values for iteration
            a = 0;
            b = 1;
            x0 = 0.413;
            x1 = 0.513;
            N = 100;
            
            % generate the cobweb plot associated with
            % the orbits x_n+1=f(x_n).
            % N is the number of iterates, and
            % (a,b) is the interval
            % x0 and x1 are two initial points.
            % generate N linearly space values on (a,b)
            x = linspace(a, b, N);
            
            % which we use to plot the function y=lab3(x)
            y = L3F.webEQ(x, r);
            
            % turn hold on to gather up all plots in one
            figure;
            subplot(1, 2, 1);
            hold on;
            plot(x,y,'k'); % plot the function
            plot(x,x,'r'); % plot the straight line
            x(1)=x0; % plot orbit starting at x0
            
            for i=1:N
             x(i+1)=L3F.webEQ(x(i), r);
             % line is a graphic primative that draws a line on the current
             %  plot between the two specified coordinates
             line([x(i),x(i)],[x(i),x(i+1)],'Color','g');
             line([x(i),x(i+1)],[x(i+1),x(i+1)],'Color','g');
            end
            
            x(1)=x1; % plot orbig starting at x1
            for i=1:N
             x(i+1)=L3F.webEQ(x(i), r);
             line([x(i),x(i)],[x(i),x(i+1)],'Color','b');
             line([x(i),x(i+1)],[x(i+1),x(i+1)],'Color','b');
            end
            hold off;
            title('Cobweb diagram');
            xlabel('xn');
            ylabel('xn+1');
            
            subplot(1, 2, 2);
            plot(x);
            title('Population Growth over Time as a Fraction of K');
            xlabel('Number of Generations');
            ylabel('Population as a fraction of K');
            axis([0 100 0 1]);
            suptitle(['r = ', num2str(r)]);
        end
    end      
end


