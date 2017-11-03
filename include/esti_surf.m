% rearrange the normal map and estimate the height map
function esti_surf(img, mask, norm_map, odir)

% mask_tar = imread(data.name_mask_tar);
% mask_tar(mask_tar > 0) = 1;
% mask_tar_ind = find(mask_tar);
% mask_reso = numel(mask_tar);
% img_tar = imread(data.name_img_tar{1});

if (size(mask, 3) ~= 1)
    mask = rgb2gray(mask);
end
mask(mask > 0) = 1;
% mask_ind = find(mask);
% mask_reso = numel(mask);
if (size(norm_map, 3) == 1)
    norm_map(3, norm_map(3, :) < 1e-8) = 1;
    norm_map = norm2nmap(mask, norm_map);
end
% norm_map = zeros(size(mask_tar, 1), size(mask_tar, 2), 3);
% norm_map(mask_tar_ind + mask_reso * 0) = normals(1, :);
% norm_map(mask_tar_ind + mask_reso * 1) = normals(2, :);
% norm_map(mask_tar_ind + mask_reso * 2) = normals(3, :);

% show normal map
show_surfNorm(img, norm_map, 10);

% write to normal map (color coded)
norm_map_rgb = encode(norm_map, mask);
imwrite(norm_map_rgb, sprintf('%s/normal.png', odir));
clear norm_map_rgb;

% integrate the normal to get the surface
% depth from gradients
DfG = 1;
if DfG
% solution 1: solving a sparse system of linear equations
% height_map = compute_heightMap(norm_map, mask_tar);

% solution 2: horn's method, slow
% n_z = norm_map(:, :, 3);
% n_z(n_z < 0.01) = 1;
% n_x = norm_map(:, :, 1) ./ n_z;
% n_y = norm_map(:, :, 2) ./ n_z;
% height_map = integrate_horn2(n_x, n_y, double(mask_tar), 100000, 1);

% solution 3:
p = -norm_map(:,:,1) ./ norm_map(:,:,3);
q = -norm_map(:,:,2) ./ norm_map(:,:,3);
p(isnan(p)) = 0;
q(isnan(q)) = 0;
height_map = DepthFromGradient(p, q);

% Visualize depth map.
figure;
height_map(isnan(norm_map(:,:,1)) | isnan(norm_map(:,:,2)) | isnan(norm_map(:,:,3))) = NaN;
surf(height_map, 'EdgeColor', 'None', 'FaceColor', [0.5 0.5 0.5]);
axis equal; camlight;
view(-75, 30);

% write to .ply file
write_ply(sprintf('%s/hmap.ply', odir), height_map, norm_map, img, mask);
end

% rmpath(fullfile(fileparts(fileparts(mfilename('fullpath'))), 'io'));
% rmpath(fullfile(fileparts(fileparts(mfilename('fullpath'))), 'include'));