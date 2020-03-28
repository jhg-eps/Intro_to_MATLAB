% Joseph Garcia
% ECE 498 Homework 3
% 2/15/16

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Problem 1 %%%%%%%%%%%%%%%%%%%%%%

% Rules to determine if a year is a leap year.
% if (year is not divisible by 4) then (it is a common year) 
    % if divisible by 4, then it is a leap year 
% else if (year is not divisible by 100) then (it is a leap year) yes
% else if (year is not divisible by 400) then (it is a common year) yes
    % so if divisble by 400, it is a leap year. 
% else (it is a leap year)

% Writing the rules in MATLAB 
% A(:,1)  is a leapyear if:
    % mod(A,100) ~= 0 OR 
    % mod(A,4) == 0 OR 
    % mod(A,400) == 0)
%    ((mod(years,4) == 0)  &
year_bn = 1;
year_en = 5000;
years = [year_bn:year_en];  % 1212 years 
is_leap_year = (((mod(years,4) == 0) & mod(years,100) ~= 0)) | (mod(years,400) == 0);
num_lyrs = sum(is_leap_year);
fprintf('\nProblem 1 Answer:\n');
fprintf( 'There are %d leap years between %d and %d\n', num_lyrs, year_bn, year_en);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Problem 2 %%%%%%%%%%%%%%%%%%%%%%

%Question 2: Table Tennis Tournament
%Two teams are playing table tennis tournament.

%Player in Team 1: A, B, C
%Players in Team 2: X, Y, Z

%Rules:
%A cannot play against X
%C cannot play against X and Z
%Write a matlab program to find out who will play against A, B, and C, respectively.
% Team 1:
fprintf('\nProblem 2 Answer:\n');
A = 1; B = 2; C = 3;
Team_1 = [A, B, C];
Team_1_names = ['A', 'B', 'C'];   %associate strings for each Team 1 player

% Team 2:
X = 4; Y = 5; Z = 6;
Team_2 = [X, Y, Z];
Team_2_names = ['X','Y','Z'];     %associate strings for each Team 1 player

prevented_competitors = [A, B, C; X 0 X; 0 0 0; 0 0 Z];  
% create matrix associating prohibited Team 2 players for each Team 1 player
% 0 means player not prhibited, otherwise letter represents prohibited
% player

prevented_size = size(prevented_competitors);
for i=1:prevented_size(2)  % go through prevented_competitors matrix columns
 people = prevented_competitors(2:end,i);   % grab all prohibited Team 2 players
 for j=2:4                 % scan through prohibited players
  if (prevented_competitors(j,i) == 0)  % determine whether prohibiting or not: 
      fprintf('player %c can play against player %c\n', Team_1_names(i), Team_2_names(j - 1))
  end
 end
end


%%%%%%% OUTPUT %%%%%%%%%%%%%%
%Problem 1 Answer:
%There are 1212 leap years between 1 and 5000

%Problem 2 Answer:
%player A can play against player Y
%player A can play against player Z
%player B can play against player X
%player B can play against player Y
%player B can play against player Z
%player C can play against player Y

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



