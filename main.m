%% MAIN FILE for HAPPYBOT
% This script segments each significant computational step in the process.
%  To re-run the process with your own data, update the fields accordingly


%% MARK - Do the hard work. 
% This should ideally only be run when first opening the document or when 
% we get new data. 
happycsv = 'example_csv/happy.csv';
sadcsv = 'example_csv/sad.csv';

unigram_map_path = './example_data/unigram_map.mat';
happy_count_path = './example_data/happycount.mat';
sad_count_path = './example_data/sadcount.mat';
topwords_path = './example_data/topwords.mat';
town_path = './example_data/town.mat';


happycell = parse_csv(happycsv);
sadcell = parse_csv(sadcsv);

%% Mark - Get unigram data

unigram_map = unigram_analyze(happycell, sadcell);
save(unigram_map_path, 'unigram_map');

%% Mark - get our precalculataed data back into a hashmap
load(unigram_map_path);

%% Mark - Unigram example
%[conclusion, confidence] = unigram_classify('I hate everything', new_map);
%fprintf('I believe the phrase "%s" is %s with %.7f confidence\n', 'I hate everything', lower(conclusion), confidence);

%% Mark - Nearest Neighbor Method
% Hard part first - get counts.
hmap = map_count(happycell, false); % don't normalize
smap = map_count(sadcell, false); % don't normalize

%% Write these maps to disc for faster retreival
save(happy_count_path, 'hmap');
save(sad_count_path 'smap');

%% Get the counts from disc
load(happy_count_path);
load(sad_count_path);

%% Get some data for the neighborhood
nwords = 100; % IMPORTANT - determines dimension of search
hcell = map_to_cell(n_hmap);
scell = map_to_cell(n_smap);
topwords = top_n_words(hcell, scell, nwords);
topwords = [topwords{:}]; % convert from cell to mat
save(topwords_path, 'topwords');

%% Create a neighborhood. This takes a while for large datasets.
town = neighbor_town(topwords, happycell, sadcell, nwords);

%% Save the town! That took forever to compute.
save(town_path, 'town');

%% Classify the string by the nearest neighbors approach. EXAMPLE
%[conclusion, confidence] = neighbor_classify('satanists', topwords, town, 15);

%% Setup for the REPL = Read Evaluate Print Loop
load(town_path);
load(topwords_path);
load(unigram_map_path);

%% Run a REPL 
clc;
fprintf('I am HappyBot. I can analyze the sentiment of any given phrase!\n');
while true
    uinput = input('HappyBot >> ', 's');
    if strcmpi(uinput, 'quit') || strcmpi(uinput, 'bye')
        break;
    end
    
    if uinput(1) == '-' % flag
        tokenized = strsplit(uinput);
        if strcmp(tokenized(1), '-count') && length(tokenized) > 1
            for ii = 2:length(tokenized)
                % Mark - No Strip Map
                if repl_map.containsKey(cell2mat(tokenized(ii)))
                    fprintf('\tUNIGRAM: The count of "%s" is %.7f\n', cell2mat(tokenized(ii)), repl_map.get((cell2mat(tokenized(ii)))));
                else
                    fprintf('\tUNIGRAM: No count of "%s."\n', cell2mat(tokenized(ii)));
                end
            end
        else
            fprintf('\tERROR: Invalid flag argument. Words cannot start with "-"\n');
        end
        continue;
    end
    
    
    [u_conclusion, u_confidence] = unigram_classify(uinput, repl_map);
    [n_conclusion, n_confidence] = neighbor_classify(uinput, topwords, town, 15); 
    
    fprintf('\tUNIGRAM: "%s" is %s with %.5f confidence\n', uinput, lower(u_conclusion), u_confidence);
    fprintf('\tNEIGHBOR: "%s" is %s with %.5f confidence\n', uinput, lower(n_conclusion), n_confidence);
   
end

clear u_conclusion u_confidence
clear n_conclusion n_confidence
clear uinput

%% Heavy clear
clear repl_map
clear topwords
clear town

