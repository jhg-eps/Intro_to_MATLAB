function [last_trade open volume high low status]= get_last_trade(stock_symbol, varargin)

status = 1;
last_trade = NaN;
open = NaN;
volume = NaN;
high = NaN;
low = NaN;

optargin = size(varargin,2); % Inputs packaged in varargin
% determine if user specified 
temp = find(strcmp(varargin,'VERBOSE') == 1); % search for frequency
if isempty(temp)                            % if not given
    VERBOSE = 0;                             % default is daily
else                                        % if user supplies frequency
    VERBOSE = varargin{temp+1};                % assign to user input
    varargin(temp:temp+1) = [];             % remove from varargin
end
clear temp

stock_symbol = upper(stock_symbol);
stock_symbol = regexprep(stock_symbol, '\.', '-');  % for Yahoo: BF.B is BF-B.
stock_symbol = regexprep(stock_symbol, '/', '-');  % for Yahoo: RDS/B is RDS-B.


% Open connection to Yahoo! Finance statistics page
if VERBOSE == 1
    fprintf(1,'Retrieving Yahoo quote (last trade) for %s...', stock_symbol);    
end

URL = strcat('http://finance.yahoo.com/q?s=',  stock_symbol);

[HTMLstr, status] = urlread(URL, 'Timeout',5);     
if ~status, 
    fprintf(1, '= N/A\n%s: Yahoo Analyst Estimates failed\n', stock_symbol); 
    status = 0;
    return; 
end

%% Get the last trade
ptr = strfind(HTMLstr, 'Last Trade');

if VERBOSE == 1
    if isempty(ptr), fprintf(1,'= N/A\n'); return; end
end

if isempty(ptr)    
    return;
end
line_buff   = HTMLstr(ptr(1):end);
%disp(line_buff)

% Extract the last trade value
ptr_gt      = strfind(line_buff,'>');
ptr_lt      = strfind(line_buff,'<');
data_str    = line_buff(ptr_gt(5)+1:ptr_lt(6)-1);
%disp(data_str);
data_str = regexprep(data_str, ',', '');

last_trade  = str2num(data_str);

if VERBOSE == 1
    if length(last_trade) == 0
        fprintf(1,'N/A\n');
        last_trade = NaN;
    else
        fprintf(1,' = %3.2f\n', last_trade);
    end
end


%% Volume
% Volume:</th><td class="yfnc_tabledata1"><span id="yfs_v00_ne">2,338,672</span></td></tr><tr>
ptr = strfind(HTMLstr, 'Volume:');
if isempty(ptr)    
    return;
end
line_buff   = HTMLstr(ptr(1):end);
ptr_gt      = strfind(line_buff,'>');
ptr_lt      = strfind(line_buff,'<');
data_str    = line_buff(ptr_gt(3)+1:ptr_lt(4)-1);
%disp(data_str);
data_str = regexprep(data_str, ',', '');
volume  = str2num(data_str);

if isempty(volume), volume = NaN; end

%% Open
% Open:</th><td class="yfnc_tabledata1">25.23</td>
ptr = strfind(HTMLstr, 'Open:');
if isempty(ptr)    
    return;
end
line_buff   = HTMLstr(ptr(1):end);
ptr_gt      = strfind(line_buff,'>');
ptr_lt      = strfind(line_buff,'<');
data_str    = line_buff(ptr_gt(2)+1:ptr_lt(3)-1);
%disp(data_str);
data_str = regexprep(data_str, ',', '');
open  = str2num(data_str);
if isempty(open), open = NaN; end

%% Day's Range
% Day's Range:</th><td class="yfnc_tabledata1"><span><span id="yfs_g00_ne">25.08</span></span> - <span><span id="yfs_h00_ne">26.49</span></span>
ptr = strfind(HTMLstr, 'Day''s Range:');
if isempty(ptr)    
    return;
end
line_buff   = HTMLstr(ptr(1):end);
line_buff   = HTMLstr(ptr(1):end);
ptr_gt      = strfind(line_buff,'>');
ptr_lt      = strfind(line_buff,'<');
data_str    = line_buff(ptr_gt(4)+1:ptr_lt(5)-1);
data_str = regexprep(data_str, ',', '');
low  = str2num(data_str);
if isempty(low), low = NaN; end

data_str    = line_buff(ptr_gt(8)+1:ptr_lt(9)-1);
data_str = regexprep(data_str, ',', '');
high  = str2num(data_str);
if isempty(high), high = NaN; end

%% Avg Vol (3m):
% Avg Vol <span class="small">(3m)</span>:</th><td class="yfnc_tabledata1">10,860,700</td></tr>
ptr = strfind(HTMLstr, 'Avg Vol ');
if isempty(ptr)    
    return;
end
line_buff   = HTMLstr(ptr(1):end);
ptr_gt      = strfind(line_buff,'>');
ptr_lt      = strfind(line_buff,'<');
data_str    = line_buff(ptr_gt(4)+1:ptr_lt(5)-1);
%disp(data_str);
data_str = regexprep(data_str, ',', '');
AvgVol  = str2num(data_str);
if isempty(AvgVol), AvgVol = NaN; end

%% 52wk Range:
% 52wk Range:</th><td class="yfnc_tabledata1"><span>19.23</span> - <span>68.99</span></td></tr
ptr = strfind(HTMLstr, '52wk Range:');
if isempty(ptr)    
    return;
end
line_buff   = HTMLstr(ptr(1):end);
ptr_gt      = strfind(line_buff,'>');
ptr_lt      = strfind(line_buff,'<');
data_str    = line_buff(ptr_gt(3)+1:ptr_lt(4)-1);
data_str = regexprep(data_str, ',', '');
Fifty_two_week_low  = str2num(data_str);

data_str    = line_buff(ptr_gt(5)+1:ptr_lt(6)-1);
data_str = regexprep(data_str, ',', '');
Fifty_two_week_high  = str2num(data_str);

if isempty(Fifty_two_week_low), Fifty_two_week_low = NaN; end
if isempty(Fifty_two_week_high), Fifty_two_week_high = NaN; end

%% Change:
% Change:</th><td class="yfnc_tabledata1"><span id="yfs_c10_ne" class="yfi_quote_price">
% <img width="10" height="14" border="0" src="http://us.i1.yimg.com/us.yimg.com/i/us/fi/03rd/up_g.gif" alt="Up"> 
% <b class="yfi-price-change-up">1.04</b></span> <span id="yfs_p20_ne" class="yfi_quote_price"><b class="
% yfi-price-change-up"> (4.07%)</b></span></td></tr><tr><th scope="row" width="48%">

%% Prev Close:
% Prev Close:</th><td class="yfnc_tabledata1">25.56</td></tr>

%% P/E (ttm):
% P/E <span class="small">(ttm)</span>:</th><td
% class="yfnc_tabledata1">4.55</td></tr>

%% EPS (ttm):
% EPS <span class="small">(ttm)</span>:</th><td
% class="yfnc_tabledata1">5.85</td></tr>

%% Market Cap:
% Market Cap:</th><td class="yfnc_tabledata1"><span
% id="yfs_j10_ne">6.96B</span>

%% 1y Target Est:
% 1y Target Est:</th><td class="yfnc_tabledata1">38.77</td></tr>

%% Div & Yield:
% Div &amp; Yield:</th><td class="yfnc_tabledata1">0.16 (0.60%)</td></tr>


if isempty(last_trade)
        last_trade = NaN;
        open = NaN;
        volume = NaN;
        high = NaN;
        low = NaN;
        status = 0;
end

end