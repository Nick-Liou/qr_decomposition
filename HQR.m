function [Q, R] = HQR(A)
%HQR Performs QR decomposition of a square matrix using Householder reflections.
%
%   [Q, R] = HQR(A) computes the QR factorization of a square matrix A.
%   The function constructs Householder matrices to iteratively zero out
%   the subdiagonal elements of A, producing an orthogonal matrix Q and
%   an upper triangular matrix R such that A = Q * R.
%
%   Input:
%       A - an n-by-n real square matrix to be factorized
%
%   Output:
%       Q - an n-by-n orthogonal matrix
%       R - an n-by-n upper triangular matrix
%
%   This implementation uses explicit construction of full Householder
%   matrices and multiplies them successively to form Q.

    % Define anonymous function to create a Householder matrix from a vector h
    H = @(h) eye(length(h)) - 2 / (h' * h) * h * h';

    n = length(A);     % Assuming A is square (n x n)
    Q = eye(n);        % Initialize orthogonal matrix Q as the identity

    for k = 1:n-1
        HH = eye(n);   % Initialize full-size Householder matrix

        % Extract the vector from the k-th row down in column k
        ak = A(k:n, k);

        % Create the Householder vector to zero out below-diagonal elements
        h = ak - sign(ak(1)) * norm(ak, 2) * eye(n + 1 - k, 1);

        % Insert the Householder reflection into the appropriate submatrix
        HH(k:n, k:n) = H(h);

        % Apply the transformation to A
        A = HH * A;

        % Accumulate the orthogonal transformations into Q
        Q = Q * HH;
    end

    R = A;  % After transformations, A becomes the upper triangular matrix R
end
