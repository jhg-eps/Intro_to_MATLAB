% Joseph Garcia
% ECE 498 Final
% 5/10/2016 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1 Given two arrays:
a = [1, 2, 3, 4, 5, 6];
b = [4, 5, 8, 7, 2, 1];
A = cat(1,a,b)
C = intersect(a,b)
% Use one line of Matlab code to complete the following tasks:
% a) Find out the total number of unique values in both a and b
common_unique = union(a,b)
% common_unique =
% 
%      1     2     4     5     7     8

% b) Find out all elements that are in both a and b. Sort the results in
% ascending order
common = intersect(a,b) 
% C =
% 
%      1     2     4     5
% c) Find out all elements that are in a but not in b.
different = setdiff(a,b)
% different =
% 
%      3     6
% d) Remove from a all elements that are elements of b.
% ismember(A,B) "returns an array containing 1 (true) where the data in A
% is found in B. Elsewhere, it returns 0 (false)." In that case, 
a(ismember(a,b)) = []
% a =
% 
%      3     6

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%