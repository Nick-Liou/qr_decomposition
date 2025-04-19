clear;
close all;

% Number of examples
n_tests = 30; 
a_size = round(linspace(10, 600, n_tests));
save_folder = 'figures' ; 

% Preallocate arrays for time measurements
times_qr = zeros(3, n_tests);
times_GQR = zeros(3, n_tests);
times_HQR = zeros(3, n_tests);

% Preallocate arrays for Frobenius norms
frobenius_norms_QR = zeros(3, n_tests);
frobenius_norms_GQR = zeros(3, n_tests);
frobenius_norms_HQR = zeros(3, n_tests);

% Loop over matrix types: 
titles = {"Real Numbers (rand)", "Small Integers (randi 100)", "Large Integers (randi 1000)"};
for matrix_type = 1:3
    for i = 1:n_tests
        % Generate matrix based on type
        if matrix_type == 1
            A = rand(a_size(i));  % Real numbers
        elseif matrix_type == 2
            A = randi(100, a_size(i));  % Integers in [1,100]
        else
            A = randi(1000, a_size(i));  % Integers in [1,1000]
        end
        
        % QR
        tic
        [Q, R] = qr(A);
        times_qr(matrix_type, i) = toc;
        frobenius_norms_QR(matrix_type, i) = norm(Q * R - A, 'fro');

        % GQR
        tic
        [Q, R] = GQR_optimized(A);
        times_GQR(matrix_type, i) = toc;
        frobenius_norms_GQR(matrix_type, i) = norm(Q * R - A, 'fro');

        % HQR
        tic
        [Q, R] = HQR_optimized(A);
        times_HQR(matrix_type, i) = toc;
        frobenius_norms_HQR(matrix_type, i) = norm(Q * R - A, 'fro');
    end
end



% ===== Plot and Save: Execution Times =====
for matrix_type = 1:3
    fig = figure;
    hold on;
    plot(a_size, times_qr(matrix_type, :), '-o', 'LineWidth', 2);
    plot(a_size, times_GQR(matrix_type, :), '-s', 'LineWidth', 2);
    plot(a_size, times_HQR(matrix_type, :), '-^', 'LineWidth', 2);
    legend("QR", "GQR", "HQR", "Location", "best");
    title_str = sprintf("Execution Time - %s", titles{matrix_type});
    title(title_str);
    grid on;
    xlabel('Matrix dimension');
    ylabel('Execution time (seconds)');
    save_figure(fig, title_str, save_folder);
end



% ===== Plot and Save: Frobenius Norms =====
for matrix_type = 1:3
    fig = figure;
    hold on;
    plot(a_size, frobenius_norms_QR(matrix_type, :), '-o', 'LineWidth', 2);
    plot(a_size, frobenius_norms_GQR(matrix_type, :), '-s', 'LineWidth', 2);
    plot(a_size, frobenius_norms_HQR(matrix_type, :), '-^', 'LineWidth', 2);
    legend("QR", "GQR", "HQR", "Location", "best");
    title_str = sprintf("Frobenius Norm - %s", titles{matrix_type});
    title(title_str);
    grid on;
    xlabel('Matrix dimension');
    ylabel('Frobenius norm');
    save_figure(fig, title_str, save_folder);
end

% ===== Comparisons: QR vs GQR =====
for matrix_type = 1:3
    fig = figure;
    hold on;
    plot(a_size, times_qr(matrix_type, :), '-o', 'LineWidth', 2);
    plot(a_size, times_GQR(matrix_type, :), '-s', 'LineWidth', 2);
    legend("QR", "GQR", "Location", "best");
    title_str = sprintf("QR vs GQR Execution Time - %s", titles{matrix_type});
    title(title_str);
    grid on;
    xlabel('Matrix dimension');
    ylabel('Execution time (seconds)');
    save_figure(fig, title_str, save_folder);

    fig = figure;
    hold on;
    plot(a_size, frobenius_norms_QR(matrix_type, :), '-o', 'LineWidth', 2);
    plot(a_size, frobenius_norms_GQR(matrix_type, :), '-s', 'LineWidth', 2);
    legend("QR", "GQR", "Location", "best");
    title_str = sprintf("QR vs GQR Frobenius Norm - %s", titles{matrix_type});
    title(title_str);
    grid on;
    xlabel('Matrix dimension');
    ylabel('Frobenius norm');
    save_figure(fig, title_str, save_folder);
end

% ===== Comparisons: QR vs HQR =====
for matrix_type = 1:3
    fig = figure;
    hold on;
    plot(a_size, times_qr(matrix_type, :), '-o', 'LineWidth', 2);
    plot(a_size, times_HQR(matrix_type, :), '-^', 'LineWidth', 2);
    legend("QR", "HQR", "Location", "best");
    title_str = sprintf("QR vs HQR Execution Time - %s", titles{matrix_type});
    title(title_str);
    grid on;
    xlabel('Matrix dimension');
    ylabel('Execution time (seconds)');
    save_figure(fig, title_str, save_folder);

    fig = figure;
    hold on;
    plot(a_size, frobenius_norms_QR(matrix_type, :), '-o', 'LineWidth', 2);
    plot(a_size, frobenius_norms_HQR(matrix_type, :), '-^', 'LineWidth', 2);
    legend("QR", "HQR", "Location", "best");
    title_str = sprintf("QR vs HQR Frobenius Norm - %s", titles{matrix_type});
    title(title_str);
    grid on;
    xlabel('Matrix dimension');
    ylabel('Frobenius norm');
    save_figure(fig, title_str, save_folder);
end

% ===== Comparisons: GQR vs HQR =====
for matrix_type = 1:3
    fig = figure;
    hold on;
    plot(a_size, times_GQR(matrix_type, :), '-o', 'LineWidth', 2);
    plot(a_size, times_HQR(matrix_type, :), '-^', 'LineWidth', 2);
    legend("GQR", "HQR", "Location", "best");
    title_str = sprintf("GQR vs HQR Execution Time - %s", titles{matrix_type});
    title(title_str);
    grid on;
    xlabel('Matrix dimension');
    ylabel('Execution time (seconds)');
    save_figure(fig, title_str, save_folder);

    fig = figure;
    hold on;
    plot(a_size, frobenius_norms_GQR(matrix_type, :), '-o', 'LineWidth', 2);
    plot(a_size, frobenius_norms_HQR(matrix_type, :), '-^', 'LineWidth', 2);
    legend("GQR", "HQR", "Location", "best");
    title_str = sprintf("GQR vs HQR Frobenius Norm - %s", titles{matrix_type});
    title(title_str);
    grid on;
    xlabel('Matrix dimension');
    ylabel('Frobenius norm');
    save_figure(fig, title_str, save_folder);
end





