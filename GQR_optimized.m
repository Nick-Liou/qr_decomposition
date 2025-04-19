function [Q, R] = GQR_optimized(A)
%GQR_OPTIMIZED Performs QR decomposition using an optimized Givens rotation method.
%
%   [Q, R] = GQR_optimized(A) computes the QR factorization of a real m-by-n
%   matrix A using an efficient implementation of Givens rotations.
%   The function returns:
%       Q - an m-by-m orthogonal matrix
%       R - an m-by-n upper triangular matrix such that A = Q * R
%
%   This version optimizes performance by applying the rotations directly
%   to the necessary rows and columns without forming the full Givens matrix.

    [m, n] = size(A);
    Q = eye(m);  % Orthogonal matrix
    R = A;       % Upper triangular matrix initialization

    for j = 1:n
        for i = m:-1:(j+1)
            if R(i, j) ~= 0
                % Numerically stable calculation
                r = hypot(R(j,j), R(i,j));
                c = R(j,j) / r;
                s = R(i,j) / r;

                % Apply Givens rotation to R (only rows i and j)
                for k = j:n
                    temp = c * R(j,k) + s * R(i,k);
                    R(i,k) = -s * R(j,k) + c * R(i,k);
                    R(j,k) = temp;
                end

                % Apply Givens rotation to Q (only columns i and j)
                for k = 1:m
                    temp = c * Q(k,j) + s * Q(k,i);
                    Q(k,i) = -s * Q(k,j) + c * Q(k,i);
                    Q(k,j) = temp;
                end
            end
        end
    end
end

