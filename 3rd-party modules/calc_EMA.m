function EMA = calc_EMA (price, N)

% op, cl, high, low,

% In order to reduce the lag in simple moving averages, technicians 
% often use exponential moving averages (also called exponentially 
% weighted moving averages). EMA's reduce the lag by applying more 
% weight to recent prices relative to older prices. The weighting 
% applied to the most recent price depends on the specified period of 
% the moving average. The shorter the EMA's period, the more weight 
% that will be applied to the most recent price. 
% 
% For example: a 10-period exponential moving average weighs the most 
% recent price 18.18% while a 20-period EMA weighs the most recent 
% price 9.52%. As we'll see, the calculating and EMA is much harder 
% than calculating an SMA. The important thing to remember is that the 
% exponential moving average puts more weight on recent prices. As such, 
% it will react quicker to recent price changes than a simple moving average. 
% Here's the calculation formula. 
%
% Exponential Moving Average Calculation
% Exponential Moving Averages can be specified in two ways - as a 
% percent-based EMA or as a period-based EMA. A percent-based EMA 
% has a percentage as it's single parameter while a period-based 
% EMA has a parameter that represents the duration of the EMA. 
%
% The formula for an exponential moving average is: 
%
% EMA(current) = ( (Price(current) - EMA(prev) ) x Multiplier) + EMA(prev)
%
% For a percentage-based EMA, "Multiplier" is equal to the EMA's specified 
% percentage. For a period-based EMA, "Multiplier" is equal to 2 / (1 + N) 
% where N is the specified number of periods. 
%
% For example, a 10-period EMA's Multiplier is calculated like this: 
%
% (2 / (Time periods + 1) ) = (2 / (10 + 1) ) = 0.1818 (18.18%)
%
% This means that a 10-period EMA is equivalent to an 18.18% EMA. 


data = price;

% If only one variable is passed, set default period to 14
if nargin == 1
    N = 50;                     % set default period
end

EMA = NaN * ones(1,length(data));    % intialize RSI vector 

if (length(data) < N+1)
    %fprintf('\tEMA Error. data size too small, N = %d, length =%d\n', round(N), round(length(data)));
    return;
end


EMA(N) = nanmean(data(1:N));

for i = N+1:length(data)
	EMA(i) = ( data(i) - EMA (i-1) )*2/(N+1) + EMA(i-1);
end

