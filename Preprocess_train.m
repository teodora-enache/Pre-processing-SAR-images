function [VH_water_flt1, VH_water_flt] = Preprocess_train(radar_image, water_masks)
%PREPROCESS Preprocesses all the images, filters and thresholds
%   using image statistics
    VH_band = squeeze(radar_image(:,:,1));
    idx0 = find(VH_band == 0);
    VH_band(idx0) = NaN;
    VH_wiener2 = wiener2(VH_band, [5 5]);
    VH_band = VH_wiener2;

    idx_water_training = find(water_masks == 1);
        
    VH_water_mask1_stats = [mean(VH_band(idx_water_training)) std(VH_band(idx_water_training)) ...
        median(VH_band(idx_water_training)) min(VH_band(idx_water_training)) max(VH_band(idx_water_training)) ...
        prctile(VH_band(idx_water_training), 25) prctile(VH_band(idx_water_training), 75) prctile(VH_band(idx_water_training), 5) ];

    VH_idx_water_min_max = find(VH_band > (VH_water_mask1_stats(4)) & ...
        VH_band < (VH_water_mask1_stats(5)));

    VH_water = logical(zeros(size(VH_band,1), size(VH_band,2)));
    VH_water(VH_idx_water_min_max) = 1;

    VH_water_flt = bwmorph(VH_water, 'thin');
    VH_water_flt1 = imfill(VH_water_flt, 'holes');

    [VH_water_flt_L, ~] = bwlabel(VH_water_flt1);
    VH_water_flt_L_regionprops = regionprops(VH_water_flt_L, 'area', 'PixelIdxList');

    pixel_size = 10;
    area_threshold = round(1e4 / pixel_size^2);
    idx2remove = find([VH_water_flt_L_regionprops.Area] < area_threshold);

    for i = 1:numel(idx2remove)
        VH_water_flt1(VH_water_flt_L_regionprops(idx2remove(i)).PixelIdxList) = 0;
    end
    
    [VH_water_flt_L, ~] = bwlabel(VH_water_flt1);
end



