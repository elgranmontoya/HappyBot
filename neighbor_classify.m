function [ conclusion, confidence ] = neighbor_classify( test_str, topwords, town, k_neighbors )
%NEIGHBOR_CLASSIFY Summary of this function goes here
%   Detailed explanation goes here
    
    assert(mod(k_neighbors, 2) == 1); % we want and odd number of neighbors.
    % intentional omission of happy/sad flag to set first element to .5
    neighbor_vec = tweet_neighbor(test_str, topwords);
    if ~any(neighbor_vec)% if everything is zero, nothing is conclusive.
        conclusion = 'inconclusive';
        confidence = 1.0;
        return;
    end
    subset_rows = randsample(1:length(town), 1000); % TODO: Hard coding 1000 seems naive. Could do better. 
    subset_pop = town(subset_rows, :); % get 1000 random neighbors from town.
    
    norms = arrayfun(@(idx) norm(subset_pop(idx, :) - neighbor_vec'), 1:length(subset_pop));
    [~, normidx] = sort(norms);
    vote = 0;
    for ii = 1:k_neighbors
        vote = vote + subset_pop(normidx(ii), 1); % add a vote if this near neighbor was positive.
    end
    percent_votes_happy = vote / k_neighbors;
    
    if percent_votes_happy > 0.50
        conclusion = 'Positive';
        confidence = percent_votes_happy;
    else
        conclusion = 'Negative';
        confidence = 1.0 - percent_votes_happy;
    end
end

