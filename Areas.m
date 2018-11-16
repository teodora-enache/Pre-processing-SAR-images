function [ total_pixels ] = Areas( VH_water_flt1 )
%AREAS Summary of this function goes here
%   Detailed explanation goes here
    [L, num] = bwlabel(VH_water_flt1);
    L_regionprops = regionprops(L, 'area', 'PixelIdxList');
    allAreas=[L_regionprops.Area];
    total_pixels=sum(allAreas);
end
