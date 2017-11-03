% Perform linear least square method (L2, BASELINE) on photometric stereo data
% Author: Boxin Shi 
% Contact: boxin.shi@gmail.com
% Release date: 20160315
% Author (modified): Kai Wu
% Contact: kaywu@ece.ubc.ca
% Release date: 20171102

% 'load_datadir_re' and 'imread_datadir_re' functions are modified 
% based on the original code written by Neil Alldrin 

clear data; close all; clc;
set_path;

rdir = 'C:\Users\Admin\Documents\3D_Recon\git_repo\photometric-stereo';
data_name = 'buddha';
datadir = fullfile(rdir, 'data', data_name);
bitdepth = 16;
gamma = 1;
resize = 1;
data = load_datadir_re(datadir, bitdepth, resize, gamma);

L = data.s;
f = size(L, 1);
[height, width, color] = size(data.mask);
if color == 1
    mask1 = double(data.mask./255);
else
    mask1 = double(rgb2gray(data.mask)./255);
end
mask3 = repmat(mask1, [1, 1, 3]);
m = find(mask1 == 1);
p = length(m);

%% Standard photometric stereo
normal_map = lls_ps(data, m);

%% Visulize height map
esti_surf(data.imgs{1}, mask3, normal_map, datadir);

%% Save results "png"
imwrite(uint8((normal_map+1)*128).*uint8(mask3), fullfile(datadir, strcat(data_name, '_normal.png')));

%% Save results "mat"
% save(strcat(dataName, '_Normal_l2.mat'), 'Normal_L2');

unset_path;