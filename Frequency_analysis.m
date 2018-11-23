cd H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\scripts\Kmeans_batch_processing\VH\VH_kmeans15
%% read the images individually(in for loop I cant perform the mathematical operation)
[kmeans15_201609,R]=geotiffread('VH_kmeans15_water_41e4_201609.tif');
[kmeans15_201610,R]=geotiffread('VH_kmeans15_water_41e4_201610.tif');
[kmeans15_201611,R]=geotiffread('VH_kmeans15_water_41e4_201611.tif');
[kmeans15_201612,R]=geotiffread('VH_kmeans15_water_41e4_201612.tif');
[kmeans15_201701,R]=geotiffread('VH_kmeans15_water_41e4_201701.tif');
[kmeans15_201702,R]=geotiffread('VH_kmeans15_water_41e4_201702.tif');
[kmeans15_201703,R]=geotiffread('VH_kmeans15_water_41e4_201703.tif');
[kmeans15_201704,R]=geotiffread('VH_kmeans15_water_41e4_201704.tif');
[kmeans15_201705,R]=geotiffread('VH_kmeans15_water_41e4_201705.tif');
[kmeans15_201706,R]=geotiffread('VH_kmeans15_water_41e4_201706.tif');
[kmeans15_201707,R]=geotiffread('VH_kmeans15_water_41e4_201707.tif');
[kmeans15_201708,R]=geotiffread('VH_kmeans15_water_41e4_201708.tif');
[kmeans15_201709,R]=geotiffread('VH_kmeans15_water_41e4_201709.tif');
[kmeans15_201710,R]=geotiffread('VH_kmeans15_water_41e4_201710.tif');
[kmeans15_201711,R]=geotiffread('VH_kmeans15_water_41e4_201711.tif');
[kmeans15_201712,R]=geotiffread('VH_kmeans15_water_41e4_201712.tif');
[kmeans15_201801,R]=geotiffread('VH_kmeans15_water_41e4_201801.tif');
[kmeans15_201802,R]=geotiffread('VH_kmeans15_water_41e4_201802.tif');
[kmeans15_201803,R]=geotiffread('VH_kmeans15_water_41e4_201803.tif');
[kmeans15_201804,R]=geotiffread('VH_kmeans15_water_41e4_201804.tif');
[kmeans15_201805,R]=geotiffread('VH_kmeans15_water_41e4_201805.tif');
[kmeans15_201806,R]=geotiffread('VH_kmeans15_water_41e4_201806.tif');
[kmeans15_201807,R]=geotiffread('VH_kmeans15_water_41e4_201807.tif');
[kmeans15_201808,R]=geotiffread('VH_kmeans15_water_41e4_201808.tif');

%% intersect all 24 images and find the permanent waters
%% FOR LOOP: first initialize empty array(preallocate)
intersect=zeros(5544,7392);
Oshanas=dir('H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\scripts\Kmeans_batch_processing\VH\VH_kmeans15\VH_kmeans15_water_41e4_*.tif');
%% 
for x=1:length(Oshanas)
    filename = Oshanas(x).name;
    [I,R]=geotiffread(filename);
    I=im2double(I);
    intersect=intersect+I;
end
%% save intersect
geotiffwrite('Intersect_preallocated_24img.tif',intersect,R,'CoordRefSysCode',32733);
