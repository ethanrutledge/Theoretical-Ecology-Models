%Ethan Rutledge
%9/22/22
%MATH 348
%LAB 4 part 1

clear;
clc;

%part 1
plotBifurcation(2.5, 6, 'Ricker');
%part 2
plotBifurcation(2.5, 4, 'Logistic');
%part 3
plotBifurcation(3.82, 3.87, 'Logistic');


function plotBifurcation(rMin, rMax, functype)
%set initial values
n0 = 0.2;
tMaxStep = 1000;
rMaxStep = 1000;
trunc = 250;
delta = (rMax - rMin)/rMaxStep;

%create matrices to hold computations
R = zeros(rMaxStep, 1);
R(1) = rMin;
NTrunc = zeros(rMaxStep, trunc);

%compute growth using ricker equation varying stepping through r range
for rStep = 1 : rMaxStep
    if (rStep ~= 1)
        R(rStep) = rMin + (delta * rStep);
    end
    N = zeros(tMaxStep, 1);
    N(1) = n0;
    
    for t = 1 : tMaxStep
        if strcmp(functype, 'Ricker')
            N(t + 1) = R(rStep) .* (N(t) .* exp(1 - N(t)));
        elseif strcmp(functype, 'Logistic')
            N(t + 1) = R(rStep) .* N(t) .* (1 - N(t));
        end
        if (t > (tMaxStep - trunc))
            NTrunc(rStep, t - (tMaxStep - trunc)) = N(t + 1);
        end
    end
end

%plot result
figure;
plot(R, NTrunc, 'k.', 'MarkerSize', 2)
title(['Bifurcation Diagram of ', functype, ' Population Growth Model']);
xlabel('Growth Rate');
ylabel('Population');
end
