%% changing text 
clear;
 clc;
 close all;
shannon = importdata("shannon.txt");
shannontext = shannon.textdata;
j = repmat(" ",24,1);
for i=1:24
    x = shannontext(i,1);
    j(i) = x{1,1};
end
for i=1:23
    j(i) = j(i) + "/";
end
text="";
for i=1:24
    text = text+j(i);
end
char = convertStringsToChars(text);
num = double(char);
%% huffman coding
frequency = findCharFrequency(char);
[keys,values] = mapToVector(frequency);
prob_values = values/length(char);
%[huff1,len1]=huffman(prob_values);
[dict,avg_len] = huffmandict(keys,prob_values);
huffman_code1 = huffmanenco(char,dict);
[prob_values_2d , keys_2d] = HighOrder(keys,prob_values) ;
[dict1,avg_len1] = huffmandict(keys_2d,prob_values_2d);
%huffman_code2 = huffmanenco(char,dict1);
%% modulation
T = 1e-3;
vec = [0:length(huffman_code1)-1];
cod = huffman_code1(1:10);
vec2 = [0:length(cod)-1];
t = vec2 .* T;
max_time = (length(vec2))*T;
var_in.time = t;
var_in.signals.values = cod';
var_in.signals.dimension = 1;

%% decode
receviced_data = double(out.var_out');
receviced_data_final = receviced_data(3:length(huffman_code1)+2); 
c = 0;
e = 0 ;
for i=1:length(receviced_data_final)
if receviced_data_final(i) == huffman_code1(i)
 c = c+1;
else
    e = e+1;
    code_error(e)=i;
end
end
if c == length(receviced_data_final)
  disp('all correct');
end    
output = huffmandeco(receviced_data_final,dict);