% Nagi Hatoum, Candlestick chart ploter function, 5/29/03

function cndl(S)

C20   = calc_EMA(S.Close, 20); % stock.Close_EMA20;  	 % Exponential Moving Average (EMA)
C50   = calc_EMA(S.Close, 50); % stock.Close_EMA50;  	 % Exponential Moving Average (EMA)
C200  = calc_EMA(S.Close,200); % stock.Close_EMA200;	 % Exponential Moving Average (EMA)
V50   = calc_EMA(S.Volume, 20); % stock.Volume_EMA50;	 % Exponential Moving Average (EMA)
%CW50  = calc_WMA(S.Close, S.Volume, 50); % stock.Close_WMA50;
%CW200 = calc_WMA(S.Close, S.Volume, 200); % stock.Close_WMA200;


% [BU, BL, BM] = calc_BollingerBands (S.Close, 20);    % Cacluate Bollinger Bands

h = figure;
FigureHandles(1) = h;
scrsz = get(0,'ScreenSize');
set(h, 'Position',[1 scrsz(4) scrsz(3) scrsz(4)]);
figureName = sprintf('Daily (%s)', char(S.Ticker));

ax(1) = subplot(4, 1, [1 3]);
hold on


w=.4; %width of body, change to draw body thicker or thinner
%%%%%%%%%%%Find up and down days%%%%%%%%%%%%%%%%%%%
d=S.Close-S.Open;
l=length(d);
hold on
%%%%%%%%draw line from Low to High%%%%%%%%%%%%%%%%%
for i=1:l
   line([i i],[S.Low(i) S.High(i)])
end
%%%%%%%%%%draw red body (down day)%%%%%%%%%%%%%%%%%
n=find(d<0);
if ~isempty(n)
   for i=1:length(n)
      x=[n(i)-w n(i)-w n(i)+w n(i)+w n(i)-w];
      y=[S.Open(n(i)) S.Close(n(i)) S.Close(n(i)) S.Open(n(i)) S.Open(n(i))];
      patch(x,y,'r')
   end
   %plot(n,S.Close(n),'rs','MarkerFaceColor','r')
end


%%%%%%%%%%draw blue body(up day)%%%%%%%%%%%%%%%%%%%
n=find(d>=0);
if ~isempty(n)
   for i=1:length(n)
      x=[n(i)-w n(i)-w n(i)+w n(i)+w n(i)-w];
      y=[S.Open(n(i)) S.Close(n(i)) S.Close(n(i)) S.Open(n(i)) S.Open(n(i))];
      patch(x,y,'b')
   end
end

%%%%%%%%%% Draw Bollinger Bands %%%%%%%%%%%%%%%%%%%
% semilogy(BU, '--', 'Parent',ax(1));
% semilogy(BM, '--', 'Parent',ax(1));
% semilogy(BL, '--', 'Parent',ax(1));


%%%%%%%%%%%%% Plot Date Ticks %%%%%%%%%%%%%%%%%%%%
[yy, mm, dd, hh, mn, ss] = datevec(S.Date);
tick = [1:30:length(S.Date)];
if tick(end) ~= length(S.Date)
    tick = [tick, length(S.Date)];
end

for i=1:length(S.Date)
    if (i == 1) 
        DATES(i) = cellstr(sprintf('%d-%d', yy(i), mm(i)));
    else            
        DATES(i) = cellstr(sprintf('%d', mm(i)));
    end
end

for i = 2:length(tick)
    id = tick(i);
    if yy(id) > yy(tick(i-1))
        DATES(id) = cellstr(sprintf('%d-%s', yy(id), char(DATES(id))));
    end
end



xlim([1, length(S.Date) + 5]);
set(gca, 'XTick', tick);
set(gca, 'XTickLabel', DATES(tick), 'FontSize', 8);
set(gca, 'YAxisLocation','right');
set(gca, 'YMinorGrid', 'on');
title(S.Ticker)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
grid on

hold off



ax(2) = subplot(4, 1, 4);
%set(gca, 'Position', get(gca, 'OuterPosition') - ...
%    get(gca, 'TightInset') * [-1 0 2 0; 0 -1 0 1; 0 0 2 0; 0 0 0 1]);
hold on

n = find(d < 0);
if ~isempty(n)
    bar(n, S.Volume(n), 'r', 'Parent',ax(2)); 
end
n = find(d >= 0);
if ~isempty(n)
    bar(n, S.Volume(n), 'b', 'Parent',ax(2)); 
end
grid on

plot(V50, 'Parent',ax(2));
if max(S.Volume) > 0
    set(gca,'ylim', [0, max(S.Volume)]);
end

set(gca,'XTick', tick);
set(gca,'XTickLabel', DATES(tick), 'FontSize', 8);
%datetick('x');

set(gca, 'YAxisLocation','right');
set(gca, 'YMinorGrid', 'on');

xlim([1, length(S.Date) + 5]);

%figmaximize(1+figureID);

%%%%%%%%%%Link Axes%%%%%%%%%%%%%%%%%%%
%% Link all axes
linkaxes(ax,'x');

hold off

