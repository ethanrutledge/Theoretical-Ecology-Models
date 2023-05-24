%Ethan Rutledge
%9/15/22
%MATH 348
%Lab 3

clear;
clc;

L3F = L3F;

%% Part 1: 
%Generate the cobweb plot for values of r ranging from 2, 3.35, 3.55, and 3.9. Discuss what the
%cobweb patterns seem to show for different values of r.
%Part 2: 
%Plot the logistic vs time for r=2, 3.35, 3.55, and 3.9.

L3F.plotWeb(2);
L3F.plotWeb(3.35);
L3F.plotWeb(3.55);
L3F.plotWeb(3.9);

%% Part 3: 
%Write a script that produces the phase-line plot (as discussed in lecture) showing dN/dt vs N for
% the Allee equation (from Lab 2). What are the equilibria and what is the stability of them for r=3.5, K=20
% and A=10. Also vary these parameters and explain what happens to the equilibria as the parameters
% vary (do you see any more or fewer equilibria for certain parameter sets? Does the stability of the
% equilibria change as the parameters vary?).

%set initial conditions
N = linspace(0, 20, 100);
t = [0, 20];

%set variations in growth rate
R = [0.5, 1, 3.5, 4];

%set variations in carying capacity
K = [1, 2, 10, 20];

%set variations in A
A = [1, 10, 20, 50];

%create matrices to fill later
NR = zeros(100, 4);
NA = zeros(100, 4);
NK = zeros(100, 4);

for cnt = 1:4
    NR(:, cnt) = L3F.allee(t, N, R(1, cnt), K(1, 4), A(1, 2));
end

for cnt = 1:4
    NA(:, cnt) = L3F.allee(t, N, R(1, 3), K(1, 4), A(1, cnt));
end

for cnt = 1:4
    NK(:, cnt) = L3F.allee(t, N, R(1, 3), K(1, cnt), A(1, 2));
end

figure;
subplot(1, 3, 1);
hold on;
plot(N, NR(:, 1), 'b-');
plot(N, NR(:, 2), 'g-');
plot(N, NR(:, 3), 'r-');
plot(N, NR(:, 4), 'm-');
line([0, 20], [0, 0], 'Color', 'k');
hold off;
title(["Varying r", "A = 10, K = 20"]);
xlabel('N');
ylabel('dN/dt');
legend(num2str(R(1, 1)), num2str(R(1, 2)), num2str(R(1, 3)), num2str(R(1, 4)), 'Location', 'Northwest');

subplot(1, 3, 2);
hold on;
plot(N, NA(:, 1), 'b-');
plot(N, NA(:, 2), 'g-');
plot(N, NA(:, 3), 'r-');
plot(N, NA(:, 4), 'm-');
line([0, 20], [0, 0], 'Color', 'k');
hold off;
title(["Varying A", "r = 3.5, K = 20"]);
xlabel('N');
ylabel('dN/dt');
legend(num2str(A(1, 1)), num2str(A(1, 2)), num2str(A(1, 3)), num2str(A(1, 4)), 'Location', 'Northwest');

subplot(1, 3, 3);
hold on;
plot(N, NK(:, 1), 'b-');
plot(N, NK(:, 2), 'g-');
plot(N, NK(:, 3), 'r-');
plot(N, NK(:, 4), 'm-');
line([0, 20], [0, 0], 'Color', 'k');
hold off;
title(["Varying K", "r = 3.5, A = 10"]);
xlabel('N');
ylabel('dN/dt');
legend(num2str(K(1, 1)), num2str(K(1, 2)), num2str(K(1, 3)), num2str(K(1, 4)), 'Location', 'Northwest');
axis([0 20 -200 200]);

suptitle('Phase Line Plot of Allee Population Growth Model');
