function stocks = hist_stock_data(start_date, end_date, varargin)
% HIST_STOCK_DATA     Obtain historical stock data
%   hist_stock_data(X,Y,'Ticker1','Ticker2',...) retrieves historical stock
%   data for the ticker symbols Ticker1, Ticker2, etc... between the dates
%   specified by X and Y.  X and Y are strings in the format ddmmyyyy,
%   where X is the beginning date and Y is the ending date.  The program
%   returns the stock data in a structure giving the Date, Open, High, Low,
%   Close, Volume, and Adjusted Close price adjusted for dividends and
%   splits.
%
%   hist_stock_data(X,Y,'tickers.txt') retrieves historical stock data
%   using the ticker symbols found in the user-defined text file.  Ticker
%   symbols must be separated by line feeds.
%
%   EXAMPLES
%       stocks = hist_stock_data('23012003','15042008','GOOG','C');
%           Returns the structure array 'stocks' that holds historical
%           stock data for Google and CitiBank for dates from January
%           23, 2003 to April 15, 2008.
%
%       stocks = hist_stock_data('12101997','18092001','tickers.txt');
%           Returns the structure arrary 'stocks' which holds historical
%           stock data for the ticker symbols listed in the text file
%           'tickers.txt' for dates from October 12, 1997 to September 18,
%           2001.  The text file must be a column of ticker symbols
%           separated by new lines.
%
%       stocks = hist_stock_data('12101997','18092001','C','frequency','w')
%           Returns historical stock data for Citibank using the date range
%           specified with a frequency of weeks.  Possible values for
%           frequency are d (daily), w (weekly), or m (monthly).  If not
%           specified, the default frequency is daily.
%
%   DATA STRUCTURE
%       INPUT           DATA STRUCTURE      FORMAT
%       X (start date)  ddmmyyyy            String
%       Y (end date)    ddmmyyyy            String
%       Ticker          NA                  String 
%       ticker.txt      NA                  Text file
%
%   OUTPUT FORMAT
%       All data is output in the structure 'stocks'.  Each structure
%       element will contain the ticker name, then vectors consisting of
%       the organized data sorted by date, followed by the Open, High, Low,
%       Close, Volume, then Adjusted Close prices.
%
%   DATA FEED
%       The historical stock data is obtained using Yahoo! Finance website.
%       By using Yahoo! Finance, you agree not to redistribute the
%       information found therein.  Therefore, this program is for personal
%       use only, and any information that you obtain may not be
%       redistributed.
%
%   NOTE
%       This program uses the Matlab command urlread in a very basic form.
%       If the program gives you an error and does not retrieve the stock
%       information, it is most likely because there is a problem with the
%       urlread command.  You may have to tweak the code to let the program
%       connect to the internet and retrieve the data.

% Created by Josiah Renfree
% January 25, 2008

global SP500;

stocks = struct([]);        % initialize data structure

% split up beginning date into day, month, and year.  The month is
% subracted is subtracted by 1 since that is the format that Yahoo! uses
bd = start_date(1:2);       % beginning day
bm = sprintf('%02d',str2double(start_date(3:4))); % beginning month
bm_start_0 = sprintf('%02d',str2double(start_date(3:4))-1); % beginning month
by = start_date(5:8);       % beginning year
start_datenum = datenum(str2double(by), str2double(bm), str2double(bd));

% determine if user specified frequency
temp = find(strcmp(varargin,'frequency') == 1); % search for frequency
if isempty(temp)                            % if not given
    freq = 'd';                             % default is daily
else                                        % if user supplies frequency
    freq = varargin{temp+1};                % assign to user input
    varargin(temp:temp+1) = [];             % remove from varargin
end
clear temp

% for moving average we need to get at least more
PRE_WINDOW_SIZE = 600;
if  strcmp(freq, 'w') || strcmp(freq, 'W')
    PRE_WINDOW_SIZE = 600;
elseif   strcmp(freq, 'm') || strcmp(freq, 'M') 
    PRE_WINDOW_SIZE = 600;
end

start_date_pre = datestr(datenum(str2double(by), str2double(bm), str2double(bd)) - PRE_WINDOW_SIZE,  'ddmmyyyy');
bd = start_date_pre(1:2);       % beginning day
bm = sprintf('%02d', str2double(start_date_pre(3:4))); % beginning month
bm_start_0 = sprintf('%02d',str2double(start_date(3:4))-1); % beginning month
by = start_date_pre(5:8);       % beginning year

% split up ending date into day, month, and year.  The month is subracted
% by 1 since that is the format that Yahoo! uses
if( ~isempty(end_date) )
	ed = end_date(1:2);         % ending day
	em = sprintf('%02d',str2double(end_date(3:4))-1);   % ending month
	ey = end_date(5:8);         % ending year
end

temp = find(strcmp(varargin,'CONCISE') == 1); % search for frequency
if isempty(temp)                              % if not given
    CONCISE = 0;                              % default is daily
else                                          % if user supplies frequency
    CONCISE = varargin{temp+1};               % assign to user input
    varargin(temp:temp+1) = [];               % remove from varargin
end
clear temp

% Determine if user supplied ticker symbols or a text file
if isempty(strfind(varargin{1},'.txt'))     % If individual tickers
    tickers = varargin;                     % obtain ticker symbols
else                                        % If text file supplied
    tickers = textread(varargin{1},'%s');   % obtain ticker symbols
end


% h = waitbar(0, 'Please Wait...');           % create waitbar
idx = 1;                                    % idx for current stock data

% cycle through each ticker symbol and retrieve historical data
for i = 1:length(tickers)
    
    % update waitbar to display current ticker
    % waitbar((i-1)/length(tickers),h,sprintf('%s %s %s%0.2f%s', ...
    %    'Retrieving stock data for',char(tickers{i}),'(',(i-1)*100/length(tickers),'%)'))
        
    % download historical data using the Yahoo! Finance website
    %sprintf('%s\n', strcat('http://ichart.finance.yahoo.com/table.csv?s='...
    %    ,tickers{i},'&a=',bm,'&b=',bd,'&c=',by,'&d=',em,'&e=',ed,'&f=',...
    %    ey,'&g=',freq,'&ignore=.csv'));
   
    % s - This is where you can specify your stock quote, if you want to 
    %	download stock quote for Microsoft, just enter it as 's=MSFT'
    % a - This parameter is to get the input for the start month. '00' is 
    %	for January, '01' is for February and so on.
    % b - This parameter is to get the input for the start day, this one quite 
    %	straight forward, '1' is for day one of the month, '2' is for second
    % 	day of the month and so on.
    % c - This parameter is to get the input for the start year
    % d - This parameter is to get the input for end month, and again '00' 
    %	is for January, '02' is for February and so on.
    % e - This parameter is to get the input for the end day
    % f - This parameter is to get the input for the end year
    % g - This parameter is to specify the interval of the data you want to 
    %	download. 'd' is for daily, 'w' is for weekly and 'm' is for monthly
    % 	prices. The default is 'daily' if you ignore this parameter.
    %
    % With all the parameters above, you can now construct a URL to download 
    % historical prices for any stock quotes you want. 
    %
    % But if you are going to download all historical prices for a stock 
    % quotes from day one onward (eg: Intel), you don't need to crack your 
    % head to look for information such as when is Intel went IPO. You 
    % just need to ignore the start and end date as follow:
    % eg: http://ichart.finance.yahoo.com/table.csv?s=INTC
    %
    %
    % If you only specify the start date and ignore the end date, it will 
    % download everything right from the start date until the most current
    % prices.

    ticker = char(tickers{i});
    ticker = regexprep(ticker, '\.', '-');  % for Yahoo: BF.B is BF-B.
    ticker = regexprep(ticker, '/', '-');  % for Yahoo: RDS/B is RDS-B.
    ticker = regexprep(ticker, '-PK$', '.PK'); %for Yahoo: LPHCQ.PK should not be LPHCQ-PK. 

    if( isempty(end_date) )
        URL = sprintf('%s\n', strcat('http://ichart.finance.yahoo.com/table.csv?s='...
                ,ticker,'&a=',bm_start_0,'&b=',bd,'&c=',by,'&g=',freq,'&ignore=.csv'));
    else
        URL = strcat('http://ichart.finance.yahoo.com/table.csv?s='...
                ,ticker,'&a=',bm_start_0,'&b=',bd,'&c=',by,'&d=',em-1,'&e=',ed,'&f=',...
                ey,'&g=',freq,'&ignore=.csv');
    end
    
    URL = strcat('http://ichart.finance.yahoo.com/table.csv?s='...
                ,ticker);
    %disp(URL);
    [temp, status] = urlread(URL, 'Timeout',5);
    
    if status
        % organize data by using the comma delimiter
        [dates, op, high, low, cl, volume, adj_close] = ...
            strread(temp(43:end),'%s%s%s%s%s%s%s','delimiter',',');
        
        dates = ChangeOrder(dates);
        op = str2double(ChangeOrder(op));
        high = str2double(ChangeOrder(high));
        low = str2double(ChangeOrder(low));
        cl = str2double(ChangeOrder(cl));
        volume = str2double(ChangeOrder(volume));
        adj_close = str2double(ChangeOrder(adj_close));  

        enddatanums = datenum(dates(end), 'yyyy-mm-dd');  % '2008-04-03'
        current_date = datestr(date(), 29); 
        [N, S] = weekday(datenum(date()));
        if ( enddatanums < datenum(current_date) ) && ...
                (strcmp(freq, 'd') || strcmp(freq, 'D')) && ...
                N ~= 1 && N ~= 7 % 
            n = length(dates);
            if isempty(strfind(tickers{i}, '^'))
                [last_trade dopen dvolume dhigh dlow dstatus] = get_last_trade(tickers{i}, 'VERBOSE', 0);
            else
                [last_trade dopen dvolume dhigh dlow dstatus] = get_last_index(tickers{i}, 'VERBOSE', 0);
            end
            
            if dstatus == 1
                dates{n+1} = current_date;
                
                if isempty(dopen)
                    op(n+1) = NaN;
                else
                    op(n+1) = dopen(1);
                end                
                
                if isempty(dhigh)
                    high(n+1) = NaN;
                else
                    high(n+1) = dhigh(1);
                end  
                
                if isempty(dlow)
                    low(n+1) = NaN;
                else
                    low(n+1) = dlow(1);
                end                
                
                if isempty(last_trade)
                    cl(n+1) = NaN;
                else
                    cl(n+1) = last_trade(1);
                end
                
                if isempty(dvolume)
                    volume(n+1) = NaN;
                else
                    volume(n+1) = dvolume(1);
                end
                
                if isempty(last_trade)
                    adj_close(n+1) = NaN;
                else
                    adj_close(n+1) = last_trade(1);
                end                
                
            end
        end
        
        mydatanums = datenum(dates, 'yyyy-mm-dd');  % '2008-04-03'
        n = find(mydatanums >= start_datenum); 
        if isempty(n), return; end
        index = n(1):length(dates);
        
        op = op .* adj_close./cl;
        high = high .* adj_close./cl;
        low = low .* adj_close./cl;
        cl = cl .* adj_close./cl;
        
        stocks(idx).Ticker = tickers{i};         % obtain ticker symbol
        stocks(idx).Date = datenum(dates(index), 'yyyy-mm-dd'); %dates(index);          % save date data
        stocks(idx).Open = op(index);            % save opening price data
        stocks(idx).High = high(index);          % save high price data
        stocks(idx).Low = low(index);            % save low price data
        stocks(idx).Close = cl(index);           % save closing price data
        stocks(idx).Volume = volume(index);      % save volume data
        stocks(idx).AdjClose = adj_close(index); % save adjustied close data
        
        if CONCISE == 1, idx = idx + 1;  continue; end
        
        if strcmp(freq, 'w') || strcmp(freq, 'W')
            DayFactor = 5;
        else
            DayFactor = 1;
        end
       
%         % Simple Moving Average (SMA)  
%         cl_SMA20 = calc_SMA(cl, 20/DayFactor);                
%         cl_SMA50 = calc_SMA(cl, 50/DayFactor);
%         cl_SMA200 = calc_SMA(cl, 200/DayFactor);           
% 
%         % Exponential Moving Average
%         avgPrice = (op + cl + high + low)/4; 
%         cl_EMA20 = calc_EMA(avgPrice, 20/DayFactor);
%         cl_EMA50 = calc_EMA(avgPrice, 50/DayFactor);
%         cl_EMA200 = calc_EMA(avgPrice, 200/DayFactor);
%         volume_EMA50 = calc_EMA(volume, 50/DayFactor);
%         
%         % Weighted average (Weight is the volume)
%         cl_WMA20 = calc_WMA(cl, volume, 20/DayFactor);
%         cl_WMA50 = calc_WMA(cl, volume, 50/DayFactor);
%         cl_WMA200 = calc_WMA(cl, volume, 200/DayFactor);
%         
%         % 50 days Simple Moving Average (SMA)   
%         volume_SMA50 = calc_SMA(volume, 50/DayFactor);     
%         
%         % Cacluate Relative Strength Index (RSI)
%         RSI = calc_RSI(cl, 30);
%         
%         % Cacluate Stochastic RSI  
%         StochRSI = calc_StochRSI(cl, 14);
%         %StochRSID = calc_EMA(StochRSI, 3);
%         StochRSID = calc_SMA(StochRSI, 3);
%           
%         %MACD Moving Average Convergence / Divergence,
%         cl_EMA12 = calc_EMA(cl, 12);
%         cl_EMA26 = calc_EMA(cl, 26);
%         MACD = cl_EMA12 - cl_EMA26;
%         MACD_Signal = calc_EMA(MACD, 9);
%         MACD_Histogram = MACD - MACD_Signal; 
% 
%         % Cacluate Bollinger Bands
%         [BU, BL, BM] = calc_BollingerBands (cl, 20);
%         
%         % Average Directional Index
%         [ADXt, ADX, DIplus, DIneg] = calc_DMI (op, cl, high, low, 14);
%         
%         % Money flow index
%         MFI = calc_MFI (op, cl, high, low, volume, 14);
%         
%         % Chaikin Money Flow
%         CMF = calc_CMF (op, cl, high, low, volume, 10);   
%         
%         % Aroon Indicator
%         [Aroon_Up, Aroon_Down, Aroon_OS] = calc_Aroon (op, cl, high, low, volume, 25);
%         
%         % Williams %R
%         R = calc_Williams_R (cl, 14);        
%         
%         % volume index; 
%         nvi = negvolidx(cl, volume);
%         pvi = posvolidx(cl, volume);
%         if  strcmp(freq, 'w') || strcmp(freq, 'W')
%             nvi_255EMA = calc_EMA(nvi, 51);
%             pvi_255EMA = calc_EMA(pvi, 51);
%         else
%             nvi_255EMA = calc_EMA(nvi, 255);
%             pvi_255EMA = calc_EMA(pvi, 255);
%         end
%         
%         % mass index 
%         mass = calc_mass_index(high, low);
%         
%         stocks(idx).Close_SMA20 = cl_SMA20(index);
%         stocks(idx).Close_SMA50 = cl_SMA50(index);     
%         stocks(idx).Close_SMA200 = cl_SMA200(index);
%         stocks(idx).Close_WMA20 = cl_WMA20(index);
%         stocks(idx).Close_WMA50 = cl_WMA50(index);
%         stocks(idx).Close_WMA200 = cl_WMA200(index);
%         stocks(idx).Volume_SMA50 = volume_SMA50(index);
%         
%         stocks(idx).Close_EMA20 = cl_EMA20(index);
%         stocks(idx).Close_EMA50 = cl_EMA50(index);
%         
%         stocks(idx).mass = mass(index);
%         
%         stocks(idx).nvi = nvi(index);
%         stocks(idx).pvi = pvi(index);        
%         stocks(idx).nvi_255EMA = nvi_255EMA(index);
%         stocks(idx).pvi_255EMA = pvi_255EMA(index);        
%         
%         if( max(stocks(idx).Close_EMA50) == 0)
%             fprintf('\t Stock %s: 50-day EMA size is zero\n ', stocks(idx).Ticker);
%         end
%         stocks(idx).Close_EMA200 = cl_EMA200(index);
%         if( max(stocks(idx).Close_EMA200) == 0)
%             fprintf('\t Stock %s: 200-day EMA size is zero\n', stocks(idx).Ticker);
%         end
%         stocks(idx).Volume_EMA50 = volume_EMA50(index);
%         if( max(stocks(idx).Volume_EMA50) == 0)
%             fprintf('\t Stock %s: 50-day EMA  size is zero\n', stocks(idx).Ticker);
%         end
%         
%         %stocks(idx).MACD12 = cl_EMA12(index);
%         %stocks(idx).MACD26 = cl_EMA26(index);
%         stocks(idx).MACD = MACD(index);
%         stocks(idx).MACD_Signal = MACD_Signal(index);
%         stocks(idx).MACD_Histogram = MACD_Histogram(index);
%         
%         stocks(idx).RSI = RSI(index);
%         stocks(idx).StochRSI = StochRSI(index);
%         stocks(idx).StochRSID = StochRSID(index);
%         
%         stocks(idx).BU = BU(index);
%         stocks(idx).BL = BL(index);
%         stocks(idx).BM = BM(index);
%         
%         stocks(idx).ADX = ADX(index);
%         stocks(idx).ADXt = ADXt(index);
%         stocks(idx).DIplus = DIplus(index);
%         stocks(idx).DIneg = DIneg(index);
%         
%         stocks(idx).MFI = MFI(index);
%         stocks(idx).CMF = CMF(index);
%         
%         % Price Ralative
%         stocks(idx).PR = []; %calc_PR(cl(index), SP500.Close);  
%         
%         % Aroon
%         stocks(idx).Aroon_Up = Aroon_Up(index);
%         stocks(idx).Aroon_Down = Aroon_Down(index);
%         stocks(idx).Aroon_OS = Aroon_OS(index);
%         
%         % Williams %R
%         stocks(idx).R = R(index);
        
        idx = idx + 1;                          % increment stock index
    end
    
    % clear variables made in for loop for next iteration
    clear dates op high low cl volume adj_close temp status
    
    % update waitbar
    %waitbar(i/length(tickers),h)
end
%close(h)    % close waitbar
