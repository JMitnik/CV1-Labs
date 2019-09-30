function tracking(path_to_image_folder, path_to_video, WINDOW_SIZE_OPT_FLOW, HARRIS_THRESHOLD, T_Delta, SIGMA, NEIGHBOURS)
    % Initialize writer
    v_writer = VideoWriter(path_to_video, 'MPEG-4');
    v_writer.Quality = 60;
    v_writer.FrameRate = 15;
    open(v_writer);

    % Grab all jpgs
    file_paths_jpg = fullfile(path_to_image_folder, '*.jpeg');
    file_paths_jpeg = fullfile(path_to_image_folder, '*.jpg');
    images = [dir(file_paths_jpg), dir(file_paths_jpeg)];

    % Initialize the features for the first image
    first_image = imread(fullfile(path_to_image_folder, images(1).name));
    [~, r, c] = HarrisCornerDetector(first_image, SIGMA, NEIGHBOURS, HARRIS_THRESHOLD, 0);

    for idx = 1:length(images) - 1
        % Get the subsequent images
        I1 = imread(fullfile(path_to_image_folder, images(idx).name));
        I2 = imread(fullfile(path_to_image_folder, images(idx + 1).name));

        % Calculate the directions of the lucas_kanade algorithm
        optical_flow = lucas_kanade(I1, I2, WINDOW_SIZE_OPT_FLOW);
        [vx, vy] = interpret_optical_flow(optical_flow);

        % Spread the directions to the entire local neighbourhood.
        vx = repelem(vx, WINDOW_SIZE_OPT_FLOW, WINDOW_SIZE_OPT_FLOW);
        vy = repelem(vy, WINDOW_SIZE_OPT_FLOW, WINDOW_SIZE_OPT_FLOW);

        % Pad the directions
        rowPadding = size(I1,1) - size(vx,1);
        colPadding = size(I1,2) - size(vx,2);
        vx = [vx, zeros(size(vx, 1), colPadding)];
        vy = [vy, zeros(size(vy, 1), colPadding)];
        vx = [vx; zeros(size(vx, 2), rowPadding)'];
        vy = [vy; zeros(size(vy, 2), rowPadding)'];

        % Calculate the new c and r
        [c, r] = calcMovement(c, r, vx, vy, T_Delta);

        % Plot c, r and store in the video
        imshow(I1); hold on;
        scatter(c, r, 20, 'b');
        title("Test"); hold off;
        frame = getframe(gcf);
        writeVideo(v_writer, frame);
    end

    close(v_writer)
end

function [c_new, r_new] = calcMovement(c, r, vx, vy, T_Delta)
    % New parameters will have the same length as before
    c_new = zeros(length(c), 1);
    r_new = zeros(length(r), 1);

    % Boundary of the points, where c is maxX and r maxY
    max_c = size(vx, 2);
    max_r = size(vx, 1);

    % For each point, get the column coordinate (x)
    for idx=1:length(c)
        c_xy = c(idx);
        r_xy = r(idx);
        vx_xy = vx(r_xy, c_xy);
        vy_xy = vy(r_xy, c_xy);

        % TODO [Uncertainty]: Vx_xy and vy_xy swapped or not?
        c_new(idx) = min(max(1, round(c(idx) + T_Delta * vx_xy)), max_c);
        r_new(idx) = min(max(1, round(r(idx) + T_Delta * vy_xy)), max_r);
    end
end
