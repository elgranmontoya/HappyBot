function [ rows ] = parse_csv( filename )
%PARSE_CSV Summary of this function goes here
    %   Detailed explanation goes here
    fid = fopen(filename, 'r');
    rows = textscan(fid, '%s', 'Delimiter', '\n');
    rows = rows{1};
    fclose(fid);
end

