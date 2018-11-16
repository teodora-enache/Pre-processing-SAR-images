function [VH_water_flt1] = Clean_kmeans(kmeans_cluster)
%CLEAN KMEANS Retouches the kmeans
    VH_water_flt = bwmorph(kmeans_cluster, 'thin');
    VH_water_flt1 = imfill(VH_water_flt, 'holes');

    [VH_water_flt_L, ~] = bwlabel(VH_water_flt1);
    VH_water_flt_L_regionprops = regionprops(VH_water_flt_L, 'area', 'PixelIdxList');

    pixel_size = 10;
    area_threshold = round(4*1e4 / pixel_size^2);
    idx2remove = find([VH_water_flt_L_regionprops.Area] < area_threshold);

    for i = 1:numel(idx2remove)
        VH_water_flt1(VH_water_flt_L_regionprops(idx2remove(i)).PixelIdxList) = 0;
    end
    
    [VH_water_flt_L, ~] = bwlabel(VH_water_flt1);
end





