function tracking_v2(path_to_image_folder, path_to_video, WINDOW_SIZE_OPT_FLOW, HARRIS_THRESHOLD, T_Delta, SIGMA, NEIGHBOURS)
    % Initialize writer
    v_writer = VideoWriter(path_to_video, 'MPEG-4');
    v_writer.Quality = 60;
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

        [c, r, vx_points, vy_points] = calcMovement(I1, I2, c, r, T_Delta, WINDOW_SIZE_OPT_FLOW);

        % Plot c, r and store in the video
        f = figure('visible', 'off');
        imshow(I1); hold on;
        scatter(c, r, 20, 'b');
        quiver(c,r,vx_points, vy_points);
        title("Test"); hold off;
        frame = getframe(gcf);
        writeVideo(v_writer, frame);
    end

    close(v_writer)
end

function [c_new, r_new, vx_points, vy_points] = calcMovement(I1, I2, c, r, T_Delta, window_size)
    % New parameters will have the same length as before
    c_new = zeros(length(c), 1);
    r_new = zeros(length(r), 1);
    vx_points = zeros(length(c), 1);
    vy_points = zeros(length(r), 1);

    % Boundary of the points, where c is maxX and r maxY
    max_c = size(I1, 2);
    max_r = size(I1, 1);

    % For each point, get the column coordinate (x)
    for idx=1:length(c)
        c_xy = c(idx);
        r_xy = r(idx);
        if r_xy > window_size && c_xy > window_size && max_r - r_xy > window_size && max_c - c_xy > window_size
           optical_flow = lucas_kanade_local(I1, I2, r_xy, c_xy, window_size);
           vx = optical_flow(1);
           vy = optical_flow(2);
        else
            vx = 0;
            vy = 0;
        end

        vx_xy = vx * T_Delta;
        vy_xy = vy * T_Delta;
        vx_points(idx) = vx_xy;
        vy_points(idx) = vy_xy;

        c_new(idx) = min(max(1, round(c(idx) + vx_xy)), max_c);
        r_new(idx) = min(max(1, round(r(idx) + vy_xy)), max_r);
    end
end
