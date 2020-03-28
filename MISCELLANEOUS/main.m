close all
clear all

%% Clean data
S = hist_stock_data('01012010','','AAPL'); % start date, end date, ticker

%% Adjust Close Price
figure(1)
subplot(4, 1, [1:3])
plot(S.Date, S.AdjClose, 'LineWidth', 1.5)
grid on
dateFormat = 11;
datetick('x',dateFormat)

subplot(4, 1, 4)
% plot your RSI
