include "alldifferent.mzn";

% Parameters
int: n; % Size of the grid
set of int: DOMAIN = 1..9;

% Grid definition
array[1..n, 1..n] of var DOMAIN: grid;

% Sum and uniqueness constraints
constraint forall(i in 1..n) (
    alldifferent([grid[i, j] | j in 1..n]) /\ 
    sum([grid[i, j] | j in 1..n]) = row_sum[i]
);

constraint forall(j in 1..n) (
    alldifferent([grid[i, j] | i in 1..n]) /\ 
    sum([grid[i, j] | i in 1..n]) = col_sum[j]
);

% Input data
array[1..n] of int: row_sum; % Row sums
array[1..n] of int: col_sum; % Column sums

% Solving
solve :: int_search(grid, first_fail, complete) satisfy;
%solve :: int_search(grid, smallest, complete) satisfy;
%solve :: int_search(grid, input_order, complete) satisfy;

% Output
output [show(grid[i, j]) ++ if j == n then "\n" else " " endif | i in 1..n, j in 1..n];