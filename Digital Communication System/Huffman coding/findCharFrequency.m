function charFreq = findCharFrequency(text)
    % Initialize a map to store the frequency of each character
    charFreq = containers.Map('KeyType', 'char', 'ValueType', 'int32');
    % Iterate through each character in the text
    for i = 1:length(text)
        char = text(i);
        if isKey(charFreq, char)
            charFreq(char) = charFreq(char) + 1;
        else
            charFreq(char) = 1;
        end
    end  
    % Display the frequency of each character
    keys = charFreq.keys;
    values = charFreq.values;
    for i = 1:length(keys)
        fprintf('Character: %s, Frequency: %d\n', keys{i}, values{i});
    end
end
