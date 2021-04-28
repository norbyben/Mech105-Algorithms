function [L, U, P] = luFactor(A)
% luFactor(A)
%	LU decomposition with pivotiing
% inputs:
%	A = coefficient matrix
% outputs:
%	L = lower triangular matrix
%	U = upper triangular matrix
%       P = the permutation matrix
if (nargin ~= 1) || (nargout < 1) || (nargout > 3)
    error("Incorrect inputs/outputs. A single array is an input, with 1-3 outputs in the order L,U,P");
end

sz = size(A);
m = sz(1); %Rows
n = sz(2); %Columns
if n ~= m
    error("Incorrect dimensions... Input array 'A' must be square.");
end

L = eye(m);
P = eye(m);

for c = 1:(m-1)
%We'll pivot first...
maxabs_row = c;
maxabs = abs(A(c,c));
    for pivoting_row = (c+1):(m)
        tmp = abs(A(pivoting_row,c));
        if tmp > maxabs
            maxabs_row = pivoting_row;
            maxabs = tmp;
        end
    end
%We need to swap the top row with the maxabs_row for the pivoting matrix
%and the A matrix
if maxabs_row ~= 1
    tmp_p_row = P(maxabs_row,:);
    tmp_A_row = A(maxabs_row,:);
    tmp_L_section = L(maxabs_row,1:(c-1));
    A(maxabs_row,:) = A(c,:);
    P(maxabs_row,:) = P(c,:);
    L(maxabs_row,1:(c-1)) = L(c,1:(c-1));
    A(c,:) = tmp_A_row;
    P(c,:) = tmp_p_row;
    L(c,1:(c-1)) = tmp_L_section;
end

%now, we need to use Guassian elimination to form L and modify A into U
 for guass_index = (c+1):(m)
     coefficient = A(guass_index,c)/A(c,c);
     L(guass_index,c) = coefficient;
     tmp_guass_row = coefficient.*A(c,:);
     A(guass_index,:) = A(guass_index,:)- tmp_guass_row;
 end
 
end
    U = A;
end