%Ethan Rutledge
%10/27/22
%MATH 348
%LAB 9

clear;
clc;
%% -------------------- part 1 ------------------------
type lotka;

t0 = 0;
tfinal = 15;
y0 = [20; 20];   
[t,y] = ode23(@lotka,[t0 tfinal],y0);

figure;
subplot(1, 3, 1);
plot(t,y)
title('Predator/Prey Populations Over Time')
xlabel('t')
ylabel('Population')
legend('Prey','Predators','Location','North')

subplot(1, 3, 2);
plot(y(:,1),y(:,2))
title('Phase Plane Plot')
xlabel('Prey Population')
ylabel('Predator Population')

[T,Y] = ode45(@lotka,[t0 tfinal],y0);

subplot(1, 3, 3);
plot(y(:,1),y(:,2),'-',Y(:,1),Y(:,2),'-');
title('Phase Plane Plot')
legend('ode23','ode45')

%% ------------------------ part 2 ---------------------
t0 = 0;
tfinal = 15;
y0 = [20; 20];  

tspan = [t0 tfinal];

[t1,y1] = ode23(@(tspan, y0) ABlotka(tspan, y0, 0.01, 0.02),tspan,y0);
[t2,y2] = ode23(@(tspan, y0) ABlotka(tspan, y0, 0.02, 0.01),tspan,y0);
[t3,y3] = ode23(@(tspan, y0) ABlotka(tspan, y0, 0.02, 0.02),tspan,y0);
[t4,y4] = ode23(@(tspan, y0) ABlotka(tspan, y0, 0.01, 0.01),tspan,y0);

figure;
hold on
plot(y1(:,1),y1(:,2))
plot(y2(:,1),y2(:,2))
plot(y3(:,1),y3(:,2))
plot(y4(:,1),y4(:,2))
hold off
title('Phase Plane Plot')
xlabel('Prey Population')
ylabel('Predator Population')
legend('a = 0.01 b = 0.02', 'a = 0.02 b = 0.01', 'a = 0.02 b = 0.02', 'a = 0.01 b = 0.01', 'Location', 'northeast');


%% ------------------------- part 3 ------------------------------
t0 = 0;
tfinal = 15;
y0 = [20; 20];  

tspan = [t0 tfinal];

[t,y] = ode23(@(tspan, y0) Klotka(tspan, y0, 0.01, 0.02, 800, 2),tspan,y0);

figure;
plot(y(:,1),y(:,2))
title('Phase Plane Plot')
xlabel('Prey Population')
ylabel('Predator Population')

%% ----------------------- part 4 ----------------------------
t0 = 0;
tfinal = 15;
y0 = [20; 20];  

tspan = [t0 tfinal];

[t1,y1] = ode23(@(tspan, y0) voltComp(tspan, y0, 2, 1, 0.02, 0.01, 0.01, 0.02),tspan,y0);
[t2,y2] = ode23(@(tspan, y0) voltComp(tspan, y0, 2, 1, 0.04, 0.01, 0.01, 0.02),tspan,y0);
[t3,y3] = ode23(@(tspan, y0) voltComp(tspan, y0, 2, 1, 0.02, 0.05, 0.01, 0.04),tspan,y0);
[t4,y4] = ode23(@(tspan, y0) voltComp(tspan, y0, 2, 1, 0.02, 0.01, 0.05, 0.02),tspan,y0);

figure;
subplot(1, 2, 1);
plot(t1,y1)
title('Predator/Prey Populations Over Time')
xlabel('t')
ylabel('Population')
legend('Prey','Predators','Location','North')

subplot(1, 2, 2);
hold on
plot(y1(:,1),y1(:,2))
plot(y2(:,1),y2(:,2))
plot(y3(:,1),y3(:,2))
plot(y4(:,1),y4(:,2))
hold off
title('Phase Plane Plot')
xlabel('Prey Population')
ylabel('Predator Population')

%% ---------------------- functions --------------------
function yp = ABlotka(t, y, a, b)
    yp = diag([1 - a*y(2), -1 + b*y(1)])*y;
end

function yp = Klotka(t, y, a, b, k, r1)
    
    yp = diag([r1*(1-((y(1)+a*y(2))/k)), -1 + b*y(1)])*y; 
end

function yp = voltComp(t, y, r1, r2, a11, a12, a21, a22)
    yp = diag([r1*(1 - a11*y(1) - a12*y(2)),r2*(1 - a21*y(1) - a22*y(2))])*y;
end

