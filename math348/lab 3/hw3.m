
th1 = -1;
th2 = 1;
th3 = 5;

r = 2.5;
K = 20;
N0 = 1;
t = [0 50];

[t1, y1] = solv(t, N0, r, K, th1);
[t2, y2] = solv(t, N0, r, K, th2);
[t3, y3] = solv(t, N0, r, K, th3);

figure;
subplot(1, 3, 1);
plot(t1, y1);
title('theta = -1');
ylabel('growth rate');
xlabel('number of individuals');
subplot(1, 3, 2);
plot(t2, y2);
title('theta = 1');
ylabel('growth rate');
xlabel('number of individuals');
subplot(1, 3, 3);
plot(t3, y3);
title('theta = 5');
ylabel('growth rate');
xlabel('number of individuals');
suptitle('growth rate per capita for varied theta values');


function[Ndot] = solvhelp(t, N, r, K, theta)
    Ndot = r*(1 - (N/K)^(theta));
end

function [t, y] = solv(tspan, N0, r, K, theta)
    [t, y] = ode45(@(tspan, y0) solvhelp(tspan, N0, r, K, theta), tspan , N0);
end
   

