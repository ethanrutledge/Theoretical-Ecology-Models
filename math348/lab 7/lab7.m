%Ethan Rutledge
%10/13/22
%MATH 348
%LAB 7

clear;
clc;

%% -----------------------part 1---------------------------
%set the number of nodes and number of graphs to run 
size = 15;
cnt = 100;

%define empty arrays to fill in
degMax = zeros(1, cnt);
av = zeros(1, cnt);

%loop through all the graphs 
for i = 1:cnt
    %create a random (0 to 1) symetrical matrix to use as adjaceny 
    rndm = randi(2, size) - 1;
    lTri = tril(rndm, -1);
    adj = lTri + lTri';
    
    %create graph from symetrical adjaceny matrix
    G = graph(adj);
    
    %fill in average num of degrees of this graph
    av(1, i) = sum(degree(G))/size;
    
    %find the max degree of any node in the graph and save to vector
    maxDeg = max(degree(G));
    degMax(1, i) = maxDeg;
end

%compute average and standard deviation
average = sum(av)/cnt;
stdev = std(av);

%print results


%plot an example digraph and a bar graph of max degrees of each digraph
figure;
subplot(1, 2, 1);
plot(G);
title('Example Graph')
subplot(1, 2, 2);
bar(degMax);
ylim([size/3 size]);
title('Largest Degree of each Digraph');
ylabel('Size of Largest Degree');
suptitle('100 Unweighted Pseudorandom Adjacency Matrices');

%% ---------------------- part 2--------------------------
%set the size of each digraph and number of iterations
size = 5;
cnt = 100;

%create empty matrix to fill in 
totweights = zeros(1, cnt);

%create cnt number of graphs
for i = 1:cnt
    %create a asymetrical adjacency and a random uniform matrix
    rndm = randi(2, size) - 1;
    rndmW = abs(rand(size));
    
    %fill in all edges of adjacency matrix with corresponding random value
    for row = 1:size
        for col = 1:size
            if rndm(row, col) == 1
                rndm(row, col) = rndmW(row, col);
            end
        end
    end
    
    %make adjacency matrix symetrical
    lTri = tril(rndm, -1);
    adj = lTri + lTri';
    
    %create graph
    W = graph(adj);
    
    %fill in vector 
    totweights(1, i) = sum(W.Edges.Weight)/(size);
end

%compute mean proabability of infection
mean = sum(totweights)/(cnt) * 100;

%display results
fprintf('Mean Probability of Infection: %4.2f%%\n', mean)

%plot one example graph
figure;
p = plot(W);
labeledge(p,1:numedges(W),W.Edges.Weight);
title(["Example Graph", "with Weighted Uniform Psuedorandom Adjaceny Matrix"]);







