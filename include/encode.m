% encode from norm map to rgb image
% 0.5 * N + 0.5 = RGB

function norm_map_rgb = encode(norm_map, mask)
    norm_map_rgb = norm_map;
    norm_map_rgb = 0.5 * norm_map_rgb + 0.5;
    
    mask_0_ind = find(mask == 0);
    for i = 1 : 3
        norm_map_rgb(mask_0_ind + (i - 1) * numel(mask)) = 0;
    end
    
    norm_map_rgb = uint8(255 * norm_map_rgb);
end