function [ map ] = unigram_analyze( happycell, sadcell )
    % Given cells of happy and sad words, generate a unigram mapping where sad words have a negative count and happy words
    % have a positive count. Normalized for data set size.
    hmap = map_count(happycell, true); % true for normalize
    smap = map_count(sadcell, true);

    skeys = smap.keySet.toArray.cell;
    s_n = length(skeys);
    
    % merge smap with hmap to create final map.
    for sKey = 1:s_n
        if hmap.containsKey(skeys{sKey})
            hmap.put(skeys{sKey}, hmap.get(skeys{sKey}) + smap.get(skeys{sKey}));
        else
            hmap.put(skeys{sKey}, smap.get(skeys{sKey}));
        end
    end
    % set return value to hmap
    map = hmap;
end

