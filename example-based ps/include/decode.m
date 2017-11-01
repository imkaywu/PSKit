% decode from rgb image to norm map
% 0.5 * N + 0.5 = RGB
function norm_map = decode(norm_map_rgb, mask)
    norm_map = double(norm_map_rgb) / 255.0;
    norm_map = 2.0 * (norm_map - 0.5);
    
    mask_0_ind = find(mask == 0);
    for i = 1 : 3
        norm_map(mask_0_ind + (i - 1) * numel(mask)) = 0;
    end
end