% Joseph Garcia
% ECE 498
% Homework 4

close all
clear all   % Cleanup commands

%% Clean data
S = hist_stock_data('01012010','','AAPL'); % Grab the stock price data for Apple from January 1st, 2010 to present

%% Adjust Close Price
figure(1);     % create figure 
subplot(4, 1, [1:3]);      % create subplot on figure, 4 rows, 1 column of axes pairs. First three axes pairs are for the plot right below. 
plot(S.Date, S.AdjClose, 'LineWidth', 1.5);   % plot the closing price data for each time on January 1st, 2010
grid on;        
dateFormat = 11;
datetick('x',dateFormat);       % Convert the 7XXXXX numbers to the '11 , '12, '13, etc. date format 
xlim([min(S.Date) max(S.Date)]); % Set the x-limits to the time range where we are interested in the stock
ylabel('Stock Price'); 

subplot(4, 1, 4);   % move the RSI plot, this gets 1 of the 4 axes rows created by subplot 
% plot RSI
hold on;
grid on;                   
RSI = calc_RSI(S.AdjClose, 14);  % Calculate the relative strength Index of AAPL in the time interval of interest
S.Date(end,:) = [];       % cut off the last row of S.Date, since RSI is a vector that is 1 member shorter
plot(S.Date ,RSI, 'g-', 'LineWidth', 1.5);
plot([min(S.Date), max(S.Date)],[70 70], 'r--', 'LineWidth', 1.5);
plot([min(S.Date), max(S.Date)],[30 30], 'b--', 'LineWidth', 1.5);  % plot the 70% and 30% dashed lines.
dateFormat = 11;
datetick('x',dateFormat);            
xlim([min(S.Date) max(S.Date)]);  %follow the same dating format 
ylim([0 100]);     % change the y limits 
ylabel('RSI');
