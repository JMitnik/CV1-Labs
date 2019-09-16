close all
clear all
clc

file_sizes = ['5', '10', '25', '30'];

% obtain many images in a fixed view under different illumination

image_dir = 'photometrics_images/MonkeyGray/';
% Third argument values are ['column', 'row', 'average']
[albedo, normals, p, q, SE, height_map] = get_statistics_from_filepath(image_dir, true, 'row');

show_results(albedo, normals, SE);
show_model(albedo, height_map);
