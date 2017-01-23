function [ cellarr ] = map_to_cell( javamap )
%   Summary of this function goes here
%   Given a java.util.HashMap, return a length(HashMap.keySet) by 2 cell with all keys and values.
    keys = javamap.keySet.toArray.cell;
    cellarr = cell(length(keys), 2);
    for ii = 1:length(keys)
        cellarr{ii, 1} = keys{ii};
        cellarr{ii, 2} = javamap.get(keys{ii});
    end

end

