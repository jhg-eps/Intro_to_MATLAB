function RSI = calc_RSI(S_Data_CP, T)

%Using Wikipedia function RSI = 100(1 - 1/(1 + RS))
diff_S = diff(S_Data_CP);   % create a diff vector from the stock closing price data
up_S = diff_S;
down_S = diff_S;     % split diff_S into two vectors that will become the U and D vectors.

up_S(up_S<0)=0;      % Set up_S to 0 where it is less than zero      

down_S(down_S>0)=0;  % Set up_S to 0 where it is greater than zero   
down_S = -down_S;    

up_MA = calc_SMA(up_S, T);
down_MA = calc_SMA(down_S, T);       % calculate the simple moving average of stock price U and D arrays. 

rel_strength = up_MA./down_MA;   % Create RS
one = ones(length(diff_S), 1);
RSI = 100*(one - (one)./(one + rel_strength));   % compute RSI
