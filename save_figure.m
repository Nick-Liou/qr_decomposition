function save_figure(fig, title_str, save_folder)
%SAVE_FIGURE Saves a MATLAB figure to a specified folder with a safe filename.
%
%   save_figure(fig, title_str, save_folder) saves the given figure `fig`
%   using a sanitized version of `title_str` as the filename, in the folder
%   specified by `save_folder`. The figure is resized to 800x600 pixels.
%
%   Inputs:
%       fig         - Handle to the figure to be saved.
%       title_str   - Descriptive title used for naming the file.
%       save_folder - Directory where the figure will be saved.
%
%   Note: You can uncomment the desired format(s) to enable saving.

    % Set figure size
    fig.Position = [100, 100, 800, 600];

    % Sanitize filename
    safe_title = regexprep(title_str, '[: ]', '_');

    % Ensure the save folder exists
    if ~isfolder(save_folder)
        mkdir(save_folder);
    end

    % Full path to the output file (without extension)
    filepath = fullfile(save_folder, safe_title);

    % Uncomment the format(s) you want to save in:

    % Save as SVG
    % print(fig, filepath, '-dsvg');

    % Save as PNG
    % print(fig, filepath, '-dpng');

    % Save as PDF (optional)
    % print(fig, filepath, '-dpdf');

    % Optional: Display confirmation
    % disp(['Figure saved to: ' filepath '.<ext>']);
end
