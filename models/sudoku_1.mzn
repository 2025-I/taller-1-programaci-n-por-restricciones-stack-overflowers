include "globals.mzn";

int: n = 9; % number of cells
set of int: DOMAIN = 1..n; % defining the domain of the variables

array [1..n*n] of var DOMAIN: cell; % defining the cells as a 1D array
array [1..n, 1..n] of int: pre; % input array where are defined the assigned values

% Function to convert 2D indices to 1D index
function var int: index(int: i, int: j) = (i - 1) * n + j;

% constraints on the rows and the columns
constraint forall(i in DOMAIN)
    (alldifferent([cell[index(i, j)] | j in DOMAIN]));
    
constraint forall(j in DOMAIN)
    (alldifferent([cell[index(i, j)] | i in DOMAIN]));
    
set of int: D1 = 1..3;
set of int: D2 = 4..6;
set of int: D3 = 7..9;

% constraints on the cells
constraint alldifferent([cell[index(i,j)] | i in D1, j in D1]);
constraint alldifferent([cell[index(i,j)] | i in D1, j in D2]);
constraint alldifferent([cell[index(i,j)] | i in D1, j in D3]);
constraint alldifferent([cell[index(i,j)] | i in D2, j in D1]);
constraint alldifferent([cell[index(i,j)] | i in D2, j in D2]);
constraint alldifferent([cell[index(i,j)] | i in D2, j in D3]);
constraint alldifferent([cell[index(i,j)] | i in D3, j in D1]);
constraint alldifferent([cell[index(i,j)] | i in D3, j in D2]);
constraint alldifferent([cell[index(i,j)] | i in D3, j in D3]);

% constraint on the pre defined values
constraint forall(i,j in DOMAIN) (
    if pre[i,j] != 0 
      then cell[index(i,j)] = pre[i,j]
    else true
    endif
);
        

solve :: int_search(cell, first_fail, complete) satisfy;
%solve :: int_search(cell, smallest, complete) satisfy;
%solve :: int_search(cell, input_order, complete) satisfy;

output [
  if index mod n = 0 then show(cell[index]) ++ "\n"
  else show(cell[index]) ++ " "
  endif 
  | index in 1..n*n
];