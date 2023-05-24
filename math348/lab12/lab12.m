%Ethan Rutledge
%12/4/22
%MATH 348
%Lab 11

%track allele freq in population over time, need to determine the
%probability of fixation or loss with the mean and variance on the time

%iter through many generations and track f(A), run for 3 pop sizes and 100
%populations of each size, generation duration undetermined, need 4
%different starting frequencies for each pop size

clear;
clc;

s = [2, 20, 200];
f0 = [0.2, 0.4, 0.6, 0.8];

for i = 1:4
    f2(:,:,i) = A(s(1,1),f0(1,i));
    f20(:,:,i) = A(s(1,2),f0(1,i));
    f200(:,:,i) = A(s(1,3),f0(1,i));
end

function freqs = A(size, f0)
    runs = 100;
    gens = 15;

    freqs = zeros(runs, gens);
    pop = zeros(runs, size, gens);
    
    for p = 1:runs
        for i = 1:size
           r = rand();
           if r < f0 
               pop(p, i, 1) = 1;
           end
        end
        freqs(p, 1) = sum(pop(p, 1:end, 1))/size;
    end
    
    for p = 1:runs
        for t = 2:gens
            for i = i:size
                p1 = randi(size, 1);
                p2 = randi(size, 1);
                
                if pop(p,p1,t-1) == 1 || pop(p,p2,t-1) == 1;
                    pop(p,i,t) = 1; 
                end
            end
            freqs(p, t) = sum(pop(p, 1:end, t))/size;
        end
    end
end
