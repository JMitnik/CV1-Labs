function tracking(path_to_image_folder, path_to_video, WINDOW_SIZE_OPT_FLOW, HARRIS_THRESHOLD, T_Delta)
    v_writer = VideoWriter(path_to_video, 'MPEG-4');
    open(v_writer);
    SIGMA= 1;
    NEIGHBOURS = 70;
    
    file_paths_jpg = fullfile(path_to_image_folder, '*.jpeg');
    file_paths_jpeg = fullfile(path_to_image_folder, '*.jpg');
    images = [dir(file_paths_jpg), dir(file_paths_jpeg)];
    

    first_image = imread(fullfile(path_to_image_folder, images(1).name));
    [~, r, c] = HarrisCornerDetector(first_image, SIGMA, NEIGHBOURS, HARRIS_THRESHOLD, 0);

    for idx = 1:length(images) - 1
        I1 = imread(fullfile(path_to_image_folder, images(idx).name));
        I2 = imread(fullfile(path_to_image_folder, images(idx + 1).name));

        optical_flow = lucas_kanade(I1, I2, WINDOW_SIZE_OPT_FLOW);
        [vx, vy] = interpret_optical_flow(optical_flow);
        vx = repelem(vx, WINDOW_SIZE_OPT_FLOW, WINDOW_SIZE_OPT_FLOW);
        vy = repelem(vy, WINDOW_SIZE_OPT_FLOW, WINDOW_SIZE_OPT_FLOW);

        % Pad matrices / elements and such
        rowPadding = size(I1,1) - size(vx,1);
        colPadding = size(I1,2) - size(vx,2);
        vx = [vx, zeros(size(vx, 1), colPadding)];
        vy = [vy, zeros(size(vy, 1), colPadding)];
        vx = [vx; zeros(size(vx, 2), rowPadding)'];
        vy = [vy; zeros(size(vy, 2), rowPadding)'];
        
        % These are the new coordinates of c and r.
        [c, r] = calcMovement(c, r, vx, vy, T_Delta);
        imshow(I1); hold on;
        scatter(c, r, 20, 'r');
        quiver(size(I1, 1), size(I1, 2), imgau(vx, , vy);
        title("Test"); hold off;
        frame = getframe(gcf);
        writeVideo(v_writer, frame);
    end

    close(v_writer)
end
% Define constants

% Vx, vy contains radiuses of change

% Then, the points on image-2 will be the next starting points.

% On image 3, we will again calcualte the optical-flow, and map the points
% from image-2 to image 3.

% For each of these, we write an image with scatter points to a frame. Each
% of these frames will eventually be put into a VideoWriter


function [c_new, r_new] = calcMovement(c, r, vx, vy, T_Delta)

    c_new = zeros(length(c), 1);
    r_new = zeros(length(r), 1);

    max_r = size(vx, 1);
    max_c = size(vx, 2);

    % Calculate
    for idx=1:length(c)
        c_cood = c(idx);
        r_cood = r(idx);
        new_x = vx(r_cood, c_cood);
        new_y = vy(r_cood, c_cood);
        r_new(idx) = min(max(1, round(r(idx) + T_Delta * new_y)), max_r);
        c_new(idx) = min(max(1, round(c(idx) + T_Delta * new_x)), max_c);
    end
end
