%% Add coordinate system information
%% Everything is built upon new functions: Preprocess_kmeans,Clean_humidAreas,Clean_kmeans
cd H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets
Oshanas = dir('H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\*.tif');
%% Extract and save water masks(function preprocess_train2 with threshold 5*1e4)
cd H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\scripts\Kmeans_batch_processing\VH\VH_kmeans15
for p=[11 12]
    filename = Oshanas(p).name;
    [I,R]=geotiffread(filename);
    I=im2double(I);
    [idx,C,pixel_labels] = Preprocess_kmeans(I);%12 clusters produce same water masks as 13 clusters
    figure
    imshow(pixel_labels,[])
    %kmeans_name=strcat('VH_kmeans15_',num2str(p),'.tif');%starts from
    %1,2,3...12
    kmeans_name=strcat('VH_kmeans15_',sprintf('%02d',p),'.tif');%starts from 01,02,03...12(for looping the results in correct order)
    geotiffwrite(kmeans_name,pixel_labels,R,'CoordRefSysCode',32733)
end
%% at the beginning of for loop--> if you skip some images:
%for n = [4 5 6 7 8 9 10 11 12]
 %do something
%end
%% at the naming of results inside the for loop-->if first 01,02,03... method failed:
%kmeans_name=strcat('VH_means12_',num2str([1:12].','%02d'),'.tif');
%% Go to the classified images and extract water+humid areas(4*1e4 is a realistic area threshold)
cd H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\scripts\Kmeans_batch_processing\VH\VH_kmeans15
%% 1)Only extract water values(w) and humid(h)-->cluster numbers are random for each image
[img,R]=geotiffread('VH_kmeans15_01.tif');
idx_w1=img==11;
figure,imshow(idx_w1);
[VH_water_flt1_1] = Clean_kmeans(idx_w1);%I filled holes
figure,imshow(VH_water_flt1_1);
%% write them
geotiffwrite('VH_kmeans15_water_41e4_201705.tif',VH_water_flt1_1,R,'CoordRefSysCode',32733)
%% 2)Only extract water values(w) and humid(h)
[img,R]=geotiffread('VH_kmeans15_02.tif');
idx_w1=img==12;
figure,imshow(idx_w1);
[VH_water_flt1_2] = Clean_kmeans(idx_w1);%I filled holes
figure,imshow(VH_water_flt1_2);
%% write them
geotiffwrite('VH_kmeans15_water_41e4_201706.tif',VH_water_flt1_2,R,'CoordRefSysCode',32733)
%% 3)Only extract water values(w) and humid(h)
[img,R]=geotiffread('VH_kmeans15_03.tif');
idx_w1=img==9;
figure,imshow(idx_w1);
[VH_water_flt1_3] = Clean_kmeans(idx_w1);%I filled holes
figure,imshow(VH_water_flt1_3);
%% write them
geotiffwrite('VH_kmeans15_water_41e4_201707.tif',VH_water_flt1_3,R,'CoordRefSysCode',32733)
%% 4)Only extract water values(w) and humid(h)
[img,R]=geotiffread('VH_kmeans15_04.tif');
idx_w1=img==8;
figure,imshow(idx_w1);
[VH_water_flt1_4] = Clean_kmeans(idx_w1);%I filled holes
figure,imshow(VH_water_flt1_4);
%% write them
geotiffwrite('VH_kmeans15_water_41e4_201708.tif',VH_water_flt1_4,R,'CoordRefSysCode',32733)
%% 5)Only extract water values(w) and humid(h)
[img,R]=geotiffread('VH_kmeans15_05.tif');
idx_w1=img==4;
figure,imshow(idx_w1);
[VH_water_flt1_5] = Clean_kmeans(idx_w1);%I filled holes
figure,imshow(VH_water_flt1_5);
%% write them
geotiffwrite('VH_kmeans15_water_41e4_201709.tif',VH_water_flt1_5,R,'CoordRefSysCode',32733)
%% 6)Only extract water values(w) and humid(h)
[img,R]=geotiffread('VH_kmeans15_06.tif');
idx_w1=img==15;
figure,imshow(idx_w1);
[VH_water_flt1_6] = Clean_kmeans(idx_w1);%I filled holes
figure,imshow(VH_water_flt1_6);
%% write them
geotiffwrite('VH_kmeans15_water_41e4_201710.tif',VH_water_flt1_6,R,'CoordRefSysCode',32733)
%% 7)Only extract water values(w) and humid(h)
[img,R]=geotiffread('VH_kmeans15_07.tif');
idx_w1=img==13;
figure,imshow(idx_w1);
[VH_water_flt1_7] = Clean_kmeans(idx_w1);%I filled holes
figure,imshow(VH_water_flt1_7);
%% write them
geotiffwrite('VH_kmeans15_water_41e4_201711.tif',VH_water_flt1_7,R,'CoordRefSysCode',32733)
%% 8)Only extract water values(w) and humid(h)
[img,R]=geotiffread('VH_kmeans15_08.tif');
idx_w1=img==3;
figure,imshow(idx_w1);
[VH_water_flt1_8] = Clean_kmeans(idx_w1);%I filled holes
figure,imshow(VH_water_flt1_8);
%% write them
geotiffwrite('VH_kmeans15_water_41e4_201712.tif',VH_water_flt1_8,R,'CoordRefSysCode',32733)
%% 9)Only extract water values(w) and humid(h)
[img,R]=geotiffread('VH_kmeans15_09.tif');
idx_w1=img==9;
figure,imshow(idx_w1);
[VH_water_flt1_9] = Clean_kmeans(idx_w1);%I filled holes
figure,imshow(VH_water_flt1_9);
%% write them
geotiffwrite('VH_kmeans15_water_41e4_201801.tif',VH_water_flt1_9,R,'CoordRefSysCode',32733)
%% 10)Only extract water values(w) and humid(h)
[img,R]=geotiffread('VH_kmeans15_10.tif');
idx_w1=img==5;
figure,imshow(idx_w1);
[VH_water_flt1_10] = Clean_kmeans(idx_w1);%I filled holes
figure,imshow(VH_water_flt1_10);
%% write them
geotiffwrite('VH_kmeans15_water_41e4_201802.tif',VH_water_flt1_10,R,'CoordRefSysCode',32733)
%% 11)Only extract water values(w) and humid(h)
[img,R]=geotiffread('VH_kmeans15_11.tif');
idx_w1=img==2;
figure,imshow(idx_w1);
[VH_water_flt1_11] = Clean_kmeans(idx_w1);%I filled holes
figure,imshow(VH_water_flt1_11);
%% write them
geotiffwrite('VH_kmeans15_water_41e4_201803.tif',VH_water_flt1_11,R,'CoordRefSysCode',32733)
%% 12)Only extract water values(w) and humid(h)
[img,R]=geotiffread('VH_kmeans15_12.tif');
idx_w1=img==15;
figure,imshow(idx_w1);
[VH_water_flt1_12] = Clean_kmeans(idx_w1);%I filled holes
figure,imshow(VH_water_flt1_12);
%% write them
geotiffwrite('VH_kmeans15_water_41e4_201804.tif',VH_water_flt1_12,R,'CoordRefSysCode',32733)