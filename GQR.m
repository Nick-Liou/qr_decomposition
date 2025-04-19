function [Q, R] = GQR(A)
    %GQR Performs QR decomposition using Givens rotations.
    %
    %   [Q, R] = GQR(A) computes the QR factorization of a real m-by-n matrix A
    %   using Givens rotations. It returns:
    %       Q - an m-by-m orthogonal matrix
    %       R - an m-by-n upper triangular matrix such that A = Q * R
    %
    %   This implementation is particularly useful for sparse matrices or
    %   when only specific elements need to be eliminated, as Givens rotations
    %   introduce zeros one at a time.
    [m, n] = size(A);
    Q = eye(m);  % Initialize Q as the identity matrix
    R = A;       % Start with R as the original matrix A

    % Loop over the columns of A
    for j = 1:n
        for i = m:-1:(j+1)
            if R(i,j) ~= 0
                % Compute Givens rotation values c and s
                r = hypot(R(j,j), R(i,j));  % More stable than sqrt(x^2 + y^2)
                c = R(j,j) / r;
                s = R(i,j) / r;

                % Construct Givens rotation matrix G for rows i and j
                G = eye(m);
                G([j i], [j i]) = [c s; -s c];

                % Apply G to R from the left: G * R
                R = G * R;

                % Accumulate the rotation in Q: Q = Q * G'
                Q = Q * G';
            end
        end
    end
end
