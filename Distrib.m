function [VH_water_mask_counts,VH_water_mask_centers, VH_no_water_mask_counts,VH_no_water_mask_centers ] = Distrib( radar_image, water_masks )
%DISTRIB Summary of this function goes here
%   Detailed explanation goes here
    VH_band = squeeze(radar_image(:,:,1));
    idx0 = find(VH_band == 0);
    VH_band(idx0) = NaN;
    VH_wiener2 = wiener2(VH_band, [5 5]);
    VH_band = VH_wiener2;
    VH_prctile2 = prctile(VH_band(~isnan(VH_band)), 2);
    VH_prctile98 = prctile(VH_band(~isnan(VH_band)), 98);

    idx_water_training = find(water_masks == 1);
    idx_no_water_training=find(water_masks == 0);
    [VH_water_mask_counts, VH_water_mask_centers] = hist(VH_band(idx_water_training), 25);
    [VH_no_water_mask_counts, VH_no_water_mask_centers] = hist(VH_band(idx_no_water_training), [VH_prctile2:(VH_prctile98-VH_prctile2)/25:VH_prctile98]);
end

