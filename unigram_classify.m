function [ conclusion, confidence ] = unigram_classify( test_str, map )
%UNIGRAM_CLASSIFY Summary of this function goes here
%   Detailed explanation goes here
    score = 0.0;
    test_words = strsplit(test_str);
    for ii = 1:length(test_words)
        if map.containsKey(test_words{ii})
            score = score + map.get(test_words{ii});
        end
    end
    
    if score < 0.0
        conclusion = 'Negative';
    elseif score > 0.0
        conclusion = 'Positive';
    else
        conclusion = 'Neutral';
    end
    confidence = 10 * abs(score); % give a percentage.

end

