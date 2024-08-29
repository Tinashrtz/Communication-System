function [keysVector, valuesVector] = mapToVector(map)
    % Extract keys and values from the map
    keys = map.keys;
    values = map.values;
    % Initialize vectors to store keys and values
    numElements = length(keys);
    keysVector = cell(1, numElements);
    valuesVector = zeros(1, numElements);
    % Convert the map to vectors
    for i = 1:numElements
        keysVector{i} = keys{i};
        valuesVector(i) = values{i};
    end
end
