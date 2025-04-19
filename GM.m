function G = GM(n, p, q, st, ct)
    % GM - Constructs an n x n Givens rotation matrix G
    %      that rotates the (p, q) plane using sin (st) and cos (ct)
    %
    % Syntax:
    %   G = GM(n, p, q, st, ct)
    %
    % Inputs:
    %   n  - Size of the square matrix G (n x n)
    %   p  - Row/column index of the first element to rotate
    %   q  - Row/column index of the second element to rotate
    %   st - sin(theta), sine of rotation angle
    %   ct - cos(theta), cosine of rotation angle
    %
    % Output:
    %   G  - Givens rotation matrix (n x n)

    % === Validations ===
    if p == q
        error('Indices p and q must be different.');
    end
    if any([p, q] < 1) || any([p, q] > n)
        error('Indices p and q must be between 1 and n.');
    end
    if abs(ct^2 + st^2 - 1) > 1e-10
        warning('ct^2 + st^2 ≠ 1 (possible numerical error)');
    end

    % === Construct G ===
    G = eye(n);
    G([p, q], [p, q]) = [ct, st; -st, ct];
end
