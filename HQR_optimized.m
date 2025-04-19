function [Q, R] = HQR_optimized(A)
%HQR_OPTIMIZED Performs QR decomposition of a matrix using Householder reflections.
%
%   [Q, R] = HQR_optimized(A) computes the QR factorization of the input
%   square matrix A using an optimized version of Householder transformations.
%   The function returns:
%       Q - an orthogonal matrix (Q' * Q = I)
%       R - an upper triangular matrix such that A = Q * R
%
%   Input:
%       A - an n-by-n real matrix to be factorized
%
%   Output:
%       Q - an n-by-n orthogonal matrix
%       R - an n-by-n upper triangular matrix
%
%   This implementation reduces A to upper triangular form R using
%   successive Householder reflections, and builds the orthogonal
%   matrix Q from the accumulation of these reflections.

    n = size(A, 1);     % Get the size of the matrix (assumes square)
    Q = eye(n);         % Initialize Q as the identity matrix

    for k = 1:n-1
        % Extract the k-th column vector from row k downwards
        x = A(k:n, k);
        e1 = zeros(length(x), 1); 
        e1(1) = 1;

        % Create the Householder vector h
        h = x - sign(x(1)) * norm(x) * e1;
        h = h / norm(h);

        % Apply the Householder transformation to zero out subdiagonal elements
        A(k:n, k:end) = A(k:n, k:end) - 2 * h * (h' * A(k:n, k:end));

        % Update Q with the same transformation
        Q(:, k:n) = Q(:, k:n) - 2 * (Q(:, k:n) * h) * h';
    end

    R = A;  % The resulting upper triangular matrix
end
