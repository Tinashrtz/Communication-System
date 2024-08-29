% Step 0: Prompt the user to select a file
%[file, path] = uigetfile('*.txt', 'Select a text file');
%if isequal(file, 0)
  %  disp('User selected Cancel');
 %   return;
%else
  %  filename = fullfile(path, file);
 %   disp(['User selected ', filename]);
%end

% Step 1: Read the content of the file
%fileID = fopen(filename, 'r');
fileID = fopen("shannon.txt", 'r');
text = fread(fileID, '*char')';
fclose(fileID);

% Step 2: Count the frequency of each character
unique_chars = unique(text);
freq = histc(text, unique_chars);


% Step 3: Calculate probabilities
probabilities = freq / sum(freq);


% Step 4: Calculate entropy
entropy = -sum(probabilities .* log2(probabilities));
% Display entropy
fprintf('Entropy of the text: %.4f bits\n', entropy);


% Step 5: Build the Huffman tree
symbols = num2cell(unique_chars); % Convert to cell array of characters
dict = huffmandict(symbols, probabilities);


% Step 6: Encode the text
text_cell = num2cell(text); % Convert text to cell array of characters
encoded_binary = huffmanenco(text_cell, dict);


% Convert encoded binary sequence to a string of '0's and '1's
encoded_text = sprintf('%d', encoded_binary);

% Step 7: Calculate the average length of Huffman encoded symbols
avg_length = 0;
for i = 1:length(dict)
    symbol_length = length(dict{i, 2});
    avg_length = avg_length + probabilities(i) * symbol_length;
end



% Step 8: Calculate efficiency
efficiency = entropy / avg_length;
% Display efficiency
fprintf('Huffman Coding Efficiency: %.2f%%\n', efficiency * 100);




% Step 9: Decode the text (optional)
decoded_cell = huffmandeco(encoded_binary, dict);
decoded_text = cell2mat(decoded_cell); % Convert back to character array




%simulink
T=1e-3;
t1=0:14275-1;
t=t1*T;
u=reshape(encoded_binary,14275,1);
%u=reshape(encoded_binary,1,14275);
var.time=t;
var.signals.values=u;
var.signals.dimensions=1;




%OOK
% T=1e-3;
% t=[0,T,2*T,3*T,4*T];
% u=[1;0;1;0;1];
% var.time=t;
% var.signals.values =u;
% var.signals.dimensions=1;





%%
simOut = sim('Channel.slx');  
var_out = simOut.get('yout');
% Delete the first element (bit) -- Delay
var_out = var_out(2:end);

% Convert var_out to a string of '0's and '1's for comparison
var_out_str = sprintf('%d', var_out);



% Display the lengths
fprintf('Length of encoded_text: %d\n', length(encoded_text));
fprintf('Length of var_out_str: %d\n', length(var_out_str));


% Compare the bits
if length(var_out_str) == length(encoded_text)
    bit_errors = sum(encoded_text ~= var_out_str);
    fprintf('Number of bit errors: %d\n', bit_errors);


    % Calculate portion of bits with error
    portion_with_error = bit_errors / len_encoded_text;
    fprintf('Portion of bits with error: %.4f\n', portion_with_error);

else
    disp('Length mismatch between var_out and encoded_text');
end





