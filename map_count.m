function [ map ] = map_count( inputcell, normalize )
%MAP_COUNT Summary of this function goes here
%  Given a cell of words - return a java.util.HashMap of their unigram counts - optionally normalized. 
    count = 0;
    map = java.util.HashMap;
    for ii = 1:length(inputcell)
        split = strsplit(inputcell{ii});
        for jj = 1:length(split)
            count = count + 1;
            if map.containsKey(split{jj})
                map.put(split{jj}, map.get(split{jj}) + 1);
            else
                map.put(split{jj}, 1);
            end
        end 
    end
    
    if normalize
        keys = map.keySet.toArray.cell;
        for ii = 1:length(keys)
            map.put(keys{ii}, map.get(keys{ii}) / count);
        end
    end

end

