close all; clc;

%% include directory
addpath('src/');
addpath('include/');

%% Read dataset
% set up various directories
data.obj_name = 'cat';
data.rdir = 'C:/Users/Admin/Documents/3D_Recon/git_repo/photometric-stereo';
data.idir = sprintf('%s/data/%s', data.rdir, data.obj_name);
data.mdir = data.idir;
data.ref_dir1 = sprintf('%s/ref/0000', data.idir);
data.ref_dir2 = sprintf('%s/ref/0001', data.idir);

% read image names
dirs = {data.idir, data.mdir, data.ref_dir1, data.ref_dir2};
for i = 1 : numel(dirs)
    files = dir(dirs{i});
    c = 1;
    for j = 1 : numel(files)
        [~, name, ext] = fileparts(files(j).name);
        if (strcmpi(ext, '.jpg') ||...
            strcmpi(ext, '.jpeg') ||...
            strcmpi(ext, '.png') ||...
            strcmpi(ext, '.bmp'))
            switch i
                case 1
                    if (~strcmpi(name, 'mask') && ~strcmpi(name, 'normal'))
                        data.name_img_tar{c, 1} = fullfile(dirs{i}, files(j).name);
                    end
                case 2
                    if (strcmpi(name, 'mask'))
                        data.name_mask_tar = fullfile(dirs{i}, files(j).name);
                    end
                case 3
                    if (strcmpi(name, 'mask'))
                        data.name_mask_ref{1, 1} = fullfile(dirs{i}, files(j).name);
                    else
                        data.name_img_ref{c, 1} = fullfile(dirs{i}, files(j).name);
                    end
                case 4
                    if (strcmpi(name, 'mask'))
                        data.name_mask_ref{2, 1} = fullfile(dirs{i}, files(j).name);
                    else
                        data.name_img_ref{c, 2} = fullfile(dirs{i}, files(j).name);
                    end
            end
            c = c + 1;
        end
    end
end

%% Run algorithm on dataset
data.nimgs = numel(data.name_img_tar);
data.nrobjs = 2;
data.update_file = 0;
data.range_radius = [150, 180]; % the range of radius is a user-defined parameter [150, 180] for cat

% normal estimation
exmp_based_ps_svbrdf;
% exmp_based_ps;
% n_map_tar{data.num_view} = n_map_tar;

% surface integration
esti_surf;

rmpath('src/');
rmpath('include/');