cd H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\scripts\Kmeans_batch_processing\VH\VH_kmeans15
%% read the images individually(in for loop I cant perform the mathematical operation)
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
%% intersect all 12 images and find the permanent waters (in a year=12 months)
intersect_12=kmeans15_201705 & kmeans15_201706 & kmeans15_201707 & kmeans15_201708 &...
    kmeans15_201709 & kmeans15_201710 & kmeans15_201711 & kmeans15_201712 & kmeans15_201801...
    & kmeans15_201802 & kmeans15_201803 & kmeans15_201804;
%% save end result (include UTM33= epsg 32733-->the study area is in Angola)
geotiffwrite('Intersect_kmeans15_12img.tif',intersect_12,R,'CoordRefSysCode',32733);
%% sum all pixel values in order to get a 12-dimensional vector (it is annoying to add individual images,but I did not find anything better)
aggregate_12=kmeans15_201705 + kmeans15_201706 + kmeans15_201707 + kmeans15_201708 +...
    kmeans15_201709 + kmeans15_201710 + kmeans15_201711 + kmeans15_201712 + kmeans15_201801...
    + kmeans15_201802 + kmeans15_201803 + kmeans15_201804;
%% save end result(include UTM33= epsg 32733)
geotiffwrite('Aggregate_kmeans15_12img.tif',aggregate_12,R,'CoordRefSysCode',32733);
