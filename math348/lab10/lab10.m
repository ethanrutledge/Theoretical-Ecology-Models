%Ethan Rutledge
%11/3/22
%MATH 348
%lab 10

clear;
clc;

t0    = 0;
tfin  = 90;
tspan = [t0 tfin];

SI0 = [2.5; 
       0.1];

bet1 = 0.15;
bet2 = 0.21;
gam  = 0.08;

%% ----------------------no health measures--------------------------
[t1, SI1] = ode45(@(tspan, SI0) flu(tspan, SI0, gam, bet1), tspan, SI0);
[t2, SI2] = ode45(@(tspan, SI0) flu(tspan, SI0, gam, bet2), tspan, SI0);

plotSIR(t1, SI1, t2, SI2);
suptitle('No Public Health Measures')

%% --------------------everyone wears a mask-------------------------
[t1, SI1] = ode45(@(tspan, SI0) flu(tspan, SI0, gam, bet1*(1/2)), tspan, SI0);
[t2, SI2] = ode45(@(tspan, SI0) flu(tspan, SI0, gam, bet2*(1/2)), tspan, SI0);

plotSIR(t1, SI1, t2, SI2);
suptitle('100% of people wearing masks')

%% -------------------3/4 of people wear masks---------------------
[t1, SI1] = ode45(@(tspan, SI0) flu(tspan, SI0, gam, bet1*(5/8)), tspan, SI0);
[t2, SI2] = ode45(@(tspan, SI0) flu(tspan, SI0, gam, bet2*(5/8)), tspan, SI0);

plotSIR(t1, SI1, t2, SI2);
suptitle('75% of people wearing masks')

%% --------1/2 people wear masks & close restruants and bars-------
[t1, SI1] = ode45(@(tspan, SI0) flu(tspan, SI0, gam, bet1*(3/4)*(.90)*(.80)), tspan, SI0);
[t2, SI2] = ode45(@(tspan, SI0) flu(tspan, SI0, gam, bet2*(3/4)*(.90)*(.80)), tspan, SI0);

plotSIR(t1, SI1, t2, SI2);
suptitle('50% masked and restraunts and bars are closed')

%% -------50% people wear masks & close k-12 schools-------------
[t1, SI1] = ode45(@(tspan, SI0) flu(tspan, SI0, gam, bet1*(.75)*(.60)), tspan, SI0);
[t2, SI2] = ode45(@(tspan, SI0) flu(tspan, SI0, gam, bet2*(.75)*(.60)), tspan, SI0);

plotSIR(t1, SI1, t2, SI2);
suptitle('50% masked and K-12 schools are closed')


%% ------------------------- functions ---------------------------

function plotSIR(t1, SI1, t2, SI2)
labelSIR = {'Suceptible', 'Infected', 'Recovered'};

SIR1 = addR(SI1);
SIR2 = addR(SI2);

H1 = hospital(SI1);
H2 = hospital(SI2);

figure
subplot(2, 2, 1)
plot(t1, SIR1)
ylabel('100,000 Individuals');
xlabel('Days');
legend(labelSIR, 'Location', 'Best')
title('Beta = 0.15')

subplot(2, 2, 2)
plot(t2, SIR2)
ylabel('100,000 Individuals');
xlabel('Days');
legend(labelSIR, 'Location', 'Best')
title('Beta = 0.21')

subplot(2, 2, 3)
hold on
plot(t1, H1)
yline(840,'-', 'hospital capacity', 'LabelVerticalAlignment', 'Middle')
hold off
ylabel('Individuals');
xlabel('Days');
title('Hospitalized')

subplot(2, 2, 4)
hold on
plot(t2, H2)
yline(840,'-', 'hospital capacity', 'LabelVerticalAlignment', 'Middle')
hold off
ylabel('Individuals');
xlabel('Days');
title('Hospitalized')
end

function der = flu(t, SI, gam, bet)
    
    eqs = [ -bet*SI(2)
             bet*SI(1) - gam ];
    
    der = diag(eqs) * SI;
end

function SIR = addR(SI)
    SIR = zeros(length(SI), 3);
    
    for t = 1 : length (SI)
        SIR(t, 1) = SI(t, 1);
        SIR(t, 2) = SI(t, 2);
        SIR(t, 3) = (SI(1, 1) +  SI(1, 2)) - SI(t, 1) - SI(t, 2);
    end      
end

function H = hospital(SI)
    H = zeros(length(SI), 1);
    
    for t = 1 : length(SI)
        H(t, 1) = 0.01 * SI(t, 2) * 100000;
    end
end