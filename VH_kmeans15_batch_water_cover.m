%% Extract number of water_covered pixels
cd H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\scripts\Kmeans_batch_processing\VH\VH_kmeans15
%% Read kmeans water masks
kmeans_masks=dir('H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\scripts\Kmeans_batch_processing\VH\VH_kmeans15\VH_kmeans15_water_41e4*.tif');
%% Calculate total pixels of water
for l=1:length(kmeans_masks)
    filename = kmeans_masks(l).name;
    [I,R]=geotiffread(filename);
    figure,imshow(I)
    total_pixels(l)=Areas(I);
    fprintf('Water-covered pixels for month #%d : %d\n',...
    l,total_pixels(l));
    %save(['total_pixels_' kmeans_masks(l).name(24:29) '.mat'],'total_pixels')
end
%% FOR CONFUSION MATRIX WITH 13 ROIs:reunite and write all watermasks as mat file
cd H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\scripts\Kmeans_batch_processing\VH
T_masks=dir('H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\scripts\Kmeans_batch_processing\VH\*test_masks.mat');
W_masks=dir('H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\scripts\Kmeans_batch_processing\VH\*water_mask1.mat');
%% Reunite test and water masks into a single group called ALL_MASKS
for m=1:length(T_masks)
    Tname=T_masks(m).name;
    Wname=W_masks(m).name;
    load(Tname)
    load(Wname)
    all_masks=water_masks|test_masks;
    figure
    imshow(all_masks)
    %save(['all_masks_' W_masks(m).name(5:12) '.mat'],'all_masks')
end
%% Now load classification computed with test masks (they were initially training masks, but now kmeans=training masks)
cd H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\scripts\Kmeans_batch_processing\VH\VH_test_masks
test_flt=dir('H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\scripts\Kmeans_batch_processing\VH\VH_test_masks\*_Sigma0_VH_water_flt1.tif');
%% Read all masks (test+water masks)
cd H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\scripts\Kmeans_batch_processing\VH
A_masks=dir('H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\scripts\Kmeans_batch_processing\VH\all_masks_*.mat');
%% Compute confusionmat between kmeans and all masks
for t=1:length(kmeans_masks)
    filename_pred = kmeans_masks(t).name;
    filename_test=test_flt(t).name;
    VH_pred=geotiffread(filename_pred);
    VH_test=geotiffread(filename_test);
    A_name=A_masks(t).name;
    load(A_name)
    figure
    imshow(all_masks)
    index1=find(all_masks==1);
    VH_pred=VH_pred(index1);
    VH_test=VH_test(index1);
    VH_pred=VH_pred';
    VH_test=VH_test';
    C{t}=confusionmat(VH_test,VH_pred);
end
%% NEW ROI WATER MASK SELECTION:
%1)first read images (DONE)
cd H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets
Oshanas=dir('H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\S1B_IW_GRDH_1SDV*.tif');
%% 2)Now make new water masks from scratch!
cd H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\scripts\Kmeans_batch_processing\VH
for i=1:length(Oshanas)
    filename = Oshanas(i).name;
    [I,R]=geotiffread(filename);
    [water_masks, idx_water_masks] = ROI_make(I);
    figure,imshow(water_masks) 
    %save(['ten_masks_' Oshanas(i).name(18:25) '.mat'],'water_masks')
    poly_name=strcat('waterpoly_',Oshanas(i).name(18:25),'.tif');
    geotiffwrite(poly_name,water_masks,R,'CoordRefSysCode',32733);
end
%% 3)Calculate confusionmat with new water masks: first read kmeans
cd H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\scripts\Kmeans_batch_processing\VH\VH_kmeans
kmeans_masks=dir('H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\scripts\Kmeans_batch_processing\VH\VH_kmeans\VH_kmeans12_water_41e4*.tif');
%% 4)Now read new masks(tiff format)
cd H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\scripts\Kmeans_batch_processing\VH
ten_masks=dir('H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\scripts\Kmeans_batch_processing\VH\waterpoly*.tif');
%% 5)Apparently, I made the ROIs too well:I have 100% accuracy
for t=1:length(kmeans_masks)
    filename_pred = kmeans_masks(t).name;
    filename_test=ten_masks(t).name;
    VH_pred=geotiffread(filename_pred);
    VH_test=geotiffread(filename_test);
    index1=find(VH_test==1);
    VH_pred=VH_pred(index1);
    VH_test=VH_test(index1);
    VH_pred=VH_pred';
    VH_test=VH_test';
    C{t}=confusionmat(VH_test,VH_pred);
end