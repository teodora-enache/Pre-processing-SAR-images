function [water_masks, idx_water_masks] = ROI_make(radar_image)
%PREPROCESS Preprocesses all the images, filters and thresholds
%   using image statistics
    VH_band = squeeze(radar_image(:,:,1));
    idx0 = find(VH_band == 0);
    VH_band(idx0) = NaN;
    VH_wiener2 = wiener2(VH_band, [5 5]);
    VH_band = VH_wiener2;
    VH_prctile2 = prctile(VH_band(~isnan(VH_band)), 2);
    VH_prctile98 = prctile(VH_band(~isnan(VH_band)), 98);
    figure
    imagesc(VH_band, [VH_prctile2 VH_prctile98]); colormap gray
    water_mask1=roipoly();
    water_mask2=roipoly();
    water_mask3=roipoly();
    water_mask4=roipoly();
    water_mask5=roipoly();
    water_mask6=roipoly();
    water_mask7=roipoly();
    water_mask8=roipoly();
    water_mask9=roipoly();
    water_mask10=roipoly();
    water_masks=water_mask1|water_mask2|water_mask3|water_mask4|water_mask5|water_mask6|water_mask7|water_mask8|water_mask9|water_mask10;

    idx_water_masks = find(water_masks == 1);     
end
