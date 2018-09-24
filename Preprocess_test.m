function [VH_test_flt1, VH_test_flt] = Preprocess_test(radar_image, test_masks)
%PREPROCESS Preprocesses all the images, filters and thresholds
%   using image statistics
    VH_band = squeeze(radar_image(:,:,1));
    idx0 = find(VH_band == 0);
    VH_band(idx0) = NaN;
    VH_wiener2 = wiener2(VH_band, [5 5]);
    VH_band = VH_wiener2;

    idx_water_test = find(test_masks == 1);
        
    VH_test_mask1_stats = [mean(VH_band(idx_water_test)) std(VH_band(idx_water_test)) ...
        median(VH_band(idx_water_test)) min(VH_band(idx_water_test)) max(VH_band(idx_water_test)) ...
        prctile(VH_band(idx_water_test), 25) prctile(VH_band(idx_water_test), 75) prctile(VH_band(idx_water_test), 5) ];

    VH_idx_test_min_max = find(VH_band > (VH_test_mask1_stats(4)) & ...
        VH_band < (VH_test_mask1_stats(5)));

    VH_test = logical(zeros(size(VH_band,1), size(VH_band,2)));
    VH_test(VH_idx_test_min_max) = 1;

    VH_test_flt = bwmorph(VH_test, 'thin');
    VH_test_flt1 = imfill(VH_test_flt, 'holes');

    [VH_test_flt_L, ~] = bwlabel(VH_test_flt1);
    VH_test_flt_L_regionprops = regionprops(VH_test_flt_L, 'area', 'PixelIdxList');

    pixel_size = 10;
    area_threshold = round(1e4 / pixel_size^2);
    idx2remove = find([VH_test_flt_L_regionprops.Area] < area_threshold);

    for i = 1:numel(idx2remove)
        VH_test_flt1(VH_test_flt_L_regionprops(idx2remove(i)).PixelIdxList) = 0;
    end
    
    [VH_test_flt_L, ~] = bwlabel(VH_test_flt1);
end



