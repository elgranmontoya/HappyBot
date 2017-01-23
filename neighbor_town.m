function [ town ] = neighbor_town( topwords, happytweets, sadtweets, nwords )
%   For use in a Nearest-Neighbors calculation. Generates a matrix of (length(happytweets) + length(sadtweets)) x (nwords + 1) matrix of neighbor vectors.
    hlen = length(happytweets);
    slen = length(sadtweets);
    
    town = zeros(hlen + slen, nwords + 1);
    for ii = 1:hlen
        town(ii, :) = tweet_neighbor(happytweets{ii}, topwords, true); % true for happy
    end
    
    for jj = 1:slen
        idx = jj + hlen; % keep going from where we left off.
        town(idx, :) = tweet_neighbor(sadtweets{jj}, topwords, false); % false for sad
    end

end

