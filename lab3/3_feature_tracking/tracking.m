function tracking(path_to_image_folder)
    v_writer = VideoWriter('test.mp4', 'MPEG-4');
    open(v_writer);
    SIGMA= 1;
    NEIGHBOURS = 10;
    WINDOW_SIZE_OPT_FLOW = 15;
    THRESHOLD = 0.2;

    % Read input files from the img-path
%     TODO: Allow for jpegs and jpg
    file_paths = fullfile(path_to_image_folder, '*.jpeg');
    images = dir(file_paths);

    % Apply H-detection on the first image
    first_image = imread(fullfile(path_to_image_folder, images(1).name));
    [~, r, c] = HarrisCornerDetector(first_image, SIGMA, NEIGHBOURS, THRESHOLD, 0);

    % Calculate the optical flow with the next image
    % second_image = imread(fullfile(path_to_image_folder, images(2).name));
    % optical_flow = lucas_kanade(first_image, second_image, WINDOW_SIZE_OPT_FLOW);

    for idx = 1:length(images) - 1
        I1 = rgb2gray(imread(fullfile(path_to_image_folder, images(idx).name)));
        I2 = rgb2gray(imread(fullfile(path_to_image_folder, images(idx + 1).name)));

        optical_flow = lucas_kanade(I1, I2, WINDOW_SIZE_OPT_FLOW);
        [vx, vy] = interpret_optical_flow(optical_flow);
        vx = repelem(vx, WINDOW_SIZE_OPT_FLOW, WINDOW_SIZE_OPT_FLOW);
        vy = repelem(vy, WINDOW_SIZE_OPT_FLOW, WINDOW_SIZE_OPT_FLOW);

        rowPadding = size(I1,1) - size(vx,1);
        colPadding = size(I1,2) - size(vx,2);
        vx = [vx, zeros(size(vx, 1), colPadding)];
        vy = [vy, zeros(size(vy, 1), colPadding)];
        
        vx = [vx; zeros(size(vx, 2), rowPadding)'];
        vy = [vy; zeros(size(vy, 2), rowPadding)'];

        [c, r] = calcMovement(c, r, vx, vy);
%         figure(idx);
        imshow(I1); hold on;
        scatter(c, r, 20, 'r');
        title("Test"); hold off;
        frame = getframe(gcf);
        writeVideo(v_writer, frame);
%         drawnow
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


function [c_new, r_new] = calcMovement(c, r, vx, vy)
    BOOST_VECTOR = 10;

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
        r_new(idx) = min(max(1, round(r(idx) + BOOST_VECTOR * new_y)), max_r);
        c_new(idx) = min(max(1, round(c(idx) + BOOST_VECTOR * new_x)), max_c);
%         
%         r_new(idx) = round(r(idx) + BOOST_VECTOR * new_y);
%         c_new(idx) = round(c(idx) + BOOST_VECTOR * new_x);
    end
end
