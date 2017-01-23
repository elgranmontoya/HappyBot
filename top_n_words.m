function [ top_n_words ] = top_n_words( hcell, scell, nwords )
%   Given two cells of happy and sad words, return the n most frequent words irrespective of sentiment 
    [hsorted, hidx] = sort([hcell{:, 2}], 'descend');
    [ssorted, sidx] = sort([scell{:, 2}], 'descend');
    
    % pointers to our current index in each of the sorted lists
    hptr = 1;
    sptr = 1;
    
    top_n_words = cell(nwords, 1);
    for ii = 1:nwords
        if hsorted(hptr) > ssorted(hptr)
            top_n_words{ii} = hcell(hidx(hptr));
            hptr = hptr + 1;
        else % sad gets the tie. Does this matter?
            top_n_words{ii} = scell(sidx(sptr));
            sptr = sptr + 1;
        end
    end

end

