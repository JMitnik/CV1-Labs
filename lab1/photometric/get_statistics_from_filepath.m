function [albedo, normals, p, q, SE, height_map] = get_statistics_from_filepath(path_to_folder, shadow_trick, map_construction_path)
%GET_STATISTICS_FROM_FILEPATH Summary of this function goes here
%   Detailed explanation goes here

[image_stack, scriptV] = load_syn_images(path_to_folder);

if shadow_trick == true
    [albedo, normals] = estimate_alb_nrm(image_stack, scriptV);
else
    [albedo, normals] = estimate_alb_nrm(image_stack, scriptV, false);
end

[p, q, SE] = check_integrability(normals);
threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));
height_map = construct_surface( p, q, map_construction_path );
end

