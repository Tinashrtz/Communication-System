function [probability_out,key_output] = HighOrder(key_in,probability_in)
probability_out = zeros(1,length(probability_in)*length(probability_in));
probability_out = kron(probability_in,probability_in);
key_output = cell(1,length(key_in)*length(key_in));
i=1;
  for j = 1:1:length(key_in) 
     for k = 1:1:length(key_in)     
key_output(i) =strcat(key_in(j),key_in(k));
        i=i+1;
     end
  end 
end