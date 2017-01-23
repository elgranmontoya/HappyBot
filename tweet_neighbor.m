function [ neighbor_vec ] = tweet_neighbor( tweet, top_words, happy)
%   Helper function for neighborhood_town. Generates one row given the tweet itself, the n most common words, and a boolean
%   Indicating whether or not the tweet is in the Happy training data. If no happy boolean is supplied, that field is set
%   To .5, to make it exactly equidistant from all elements in that dimension (equidistant from 0 and 1). 
    neighbor_vec = zeros(length(top_words) + 1, 1);
    
    if nargin < 3 % no happiness specified, this is a query
        neighbor_vec(1) = .5; % this will be equidistant from sad and happy tweets 
    elseif happy
        neighbor_vec(1) = 1;
    end
    
    tweetarr = strsplit(tweet);
    
    for ii = 1:length(tweetarr)
        idx = find(ismember(top_words, tweetarr{ii}));
        if ~isempty(idx)
            neighbor_vec(idx + 1) = neighbor_vec(idx + 1) + 1;
        end
    end

end

