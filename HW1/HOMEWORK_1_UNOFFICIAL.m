% Joseph Garcia ECE 498
% Homework # 1 
%length(find(roster(:,2) > 60))
roster = [
        8000          80
        8001          39
        8002          24
        8003          40
        8004          10
        8005          13
        8006          94
        8007          96
        8008          58
        8009          16
        8010          23
        8011          35
        8012          82
        8013          12
        8014          34
        8015          17
        8016          65
        8017          73
        8018          65
        8019          4];

%Find out how many students in ECE 498? (Hint: size)
length(roster(:,2))  % ans = 20
%What is the highest score? (Hint: max)
max(roster(:,2))   % ans = 96 
%What is the lowest score? (Hint: min)
min(roster(:,2))    % ans = 4
%What is the median score? (Hint: median)
median(roster(:,2))  %ans = 37
%What is the mean score? (Hint: mean)
mean(roster(:,2))   %ans = 44
%What is the sum of all scores? (Hint: sum)
sum(roster(:,2))   %ans = 880
%Find out how many students have a score greater than 60 (Hint: sum)
sum(roster(:,2) > 60)  % ans = 7 
%Sort the roster based on the scores in descending order. The student ids have to remain in the same row as their scores. (Hint: sort)
sortrows(roster,2)  % or sortrows(roster,-2)
flip(ans)

%ans =
%        8019           4
%        8004          10
%        8013          12
%        8005          13
%        8009          16
%        8015          17
%        8010          23
%        8002          24
%        8014          34
%        8011          35
%        8001          39
%        8003          40
%        8008          58
%        8016          65
%        8018          65
%        8017          73
%        8000          80
%        8012          82
%        8006          94
%        8007          96
%Remove the row from the roster that contains the highest score (Hint: max)
loc = find(roster(:,2) == max(roster(:,2)))
roster(loc,:) = [];
