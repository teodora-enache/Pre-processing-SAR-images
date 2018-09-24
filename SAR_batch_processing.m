%% Before you run this, dont forget that this code builds upon new functions: Preprocess_train,Preprocess_test,Distrib,Areas
cd "\your folder path here\"
Oshanas = dir('\*.tif');%the tif files in the folder you use
%% Read images and water ROI variables (mat files)
names=dir('\*.mat');
masks =dir('*water_mask1*.mat');
%% Extract water masks
for i=1:length(Oshanas)
    filename = strcat('\your folder path here\',Oshanas(i).name);
    I=geotiffread(filename);
    maskname=masks(i).name;
    load(maskname)
    [VH_water_flt1] = Preprocess_train(I,water_masks);
    figure,imshow(VH_water_flt1)  
end
%% Plot PDF (without title)
for k=1:length(Oshanas)
    filename = strcat('\your folder path here\',Oshanas(k).name);
    I=geotiffread(filename);
    maskname=masks(k).name;
    load(maskname)
    [VH_water_mask_counts, VH_water_mask_centers,VH_no_water_mask_counts, VH_no_water_mask_centers]=Distrib(I, water_masks)
    figure
    plot(VH_water_mask_centers, VH_water_mask_counts/max(VH_water_mask_counts), 'r-', 'Linewidth', 2);
    grid 
    hold on
    plot(VH_no_water_mask_centers,VH_no_water_mask_counts/max(VH_no_water_mask_counts), 'k-', 'Linewidth', 2);
end
%% Extract number of water_covered pixels
for l=1:length(Oshanas)
    filename = strcat('\your folder path here\',Oshanas(l).name);
    I=geotiffread(filename);
    maskname=masks(l).name;
    load(maskname)
    [VH_water_flt1] = Preprocess_train(I,water_masks);
    total_pixels(l)=Areas(VH_water_flt1);
    fprintf('Water-covered pixels for month #%d : %d\n',...
    l,total_pixels(l));
end
%% Plot and save PDF (with title)
s={'25th of May 2017','18th of June 2017','24th of July 2017','29th of August 2017','22nd of September 2017','28th of October 2017',...
    '21st of November 2017','27th of December 2017','20th of January 2018','25th of February 2018','21st of March 2018','26th of April 2018'};
for m=1:length(Oshanas)
    filename = strcat('\your folder path here\',Oshanas(m).name);
    I=geotiffread(filename);
    maskname=masks(m).name;
    load(maskname)
    [VH_water_mask_counts, VH_water_mask_centers,VH_no_water_mask_counts, VH_no_water_mask_centers]=Distrib(I, water_masks)
    h=figure
    plot(VH_water_mask_centers, VH_water_mask_counts/max(VH_water_mask_counts), 'r-', 'Linewidth', 2);
    grid 
    hold on
    plot(VH_no_water_mask_centers,VH_no_water_mask_counts/max(VH_no_water_mask_counts), 'k-', 'Linewidth', 2);
    legend({'water mask', 'no water mask'}, 'Fontsize', 14)
    xlabel('S1 Sigma0-VH', 'Fontsize',12)
    ylabel('max. normalized occurrences', 'Fontsize', 12)
    title(s(m))
    saveas(h,sprintf('Fig%d.png',m));
end
%% Extract and save water masks
for p=1:length(Oshanas)
    filename = strcat('\your folder path here\',Oshanas(p).name);
    I=geotiffread(filename);
    maskname=masks(p).name;
    load(maskname)
    [VH_water_flt1] = Preprocess_train(I,water_masks);
    y=figure
    imshow(VH_water_flt1)
    file_name=strcat('watermask_',num2str(p),'.tif');
    imwrite(VH_water_flt1,file_name,'tif')
end
%% Read images and test ROI variables (mat files)
testmasks =dir('*test_masks*.mat');
%% Extract test masks
for r=1:length(Oshanas)
    filename = strcat('\your folder path here\',Oshanas(r).name);
    I=geotiffread(filename);
    testname=testmasks(r).name;
    load(testname)
    [VH_test_flt1] = Preprocess_test(I,test_masks);
    figure,imshow(VH_test_flt1)  
end
