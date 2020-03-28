function SMA = calc_SMA (data, N)
windowSize = N;
SMA = filter(ones(1,windowSize)/windowSize, 1, data);