close all
clear all
clc

file_sizes = ['5', '10', '25', '30'];

% obtain many images in a fixed view under different illumination

image_dir = 'photometrics_images/MonkeyColor/';
% Third argument values are ['column', 'row', 'average']
[albedo, normals, p, q, SE, height_map] = get_statistics_from_filepath(image_dir, true, 'row', 1);

show_results(albedo, normals, SE);
show_model(albedo, height_map);

%%
image_dir = 'photometrics_images/MonkeyColor/';

[image_stack_1, scriptV] = load_syn_images(image_dir, 1);
[image_stack_2, ~] = load_syn_images(image_dir, 2);
[image_stack_3, ~] = load_syn_images(image_dir, 3);

image_stack = ((image_stack_1 .* 0.4) + (image_stack_2 .* 0.4) + (image_stack_3 .* 0.2));

[albedo, normals] = estimate_alb_nrm(image_stack, scriptV);

[p, q, SE] = check_integrability(normals);
threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));
height_map = construct_surface( p, q, 'average' );
show_model(albedo, height_map);

%% Calculating for multiple RGB values
image_dir = 'photometrics_images/MonkeyColor/';
path_traversal_algo = 'row';
use_shadow_trick = false;

[albedo_1, normals_1, p_1, q_1, SE_1, height_map_1] = get_statistics_from_filepath(image_dir, use_shadow_trick, path_traversal_algo, 1);
[albedo_2, normals_2, p_2, q_2, SE_2, height_map_2] = get_statistics_from_filepath(image_dir, use_shadow_trick, path_traversal_algo, 2);
[albedo_3, normals_3, p_3, q_3, SE_3, height_map_3] = get_statistics_from_filepath(image_dir, use_shadow_trick, path_traversal_algo, 3);

albedo_avg = (albedo_1 + albedo_2 + albedo_3) / 3;
normals_avg = (normals_1 + normals_2 + normals_3) / 3;
height_map_avg = (height_map_1 + height_map_2 + height_map_3) / 3;
show_model(albedo_avg, height_map_avg);