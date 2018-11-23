cd H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\scripts\Kmeans_batch_processing\VH\VH_kmeans15
%%
Oshanas=dir('H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\scripts\Kmeans_batch_processing\VH\VH_kmeans15\VH_kmeans15_water_41e4_*.tif');
%% plot water bodies
cd H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\scripts\Kmeans_batch_processing\VH\VH_kmeans15
AvgSize=0;
for x=1:length(Oshanas)
    filename = Oshanas(x).name;
    [I,R]=geotiffread(filename);
    stats=regionprops('table',I,'Area');
    u=figure
    plot(stats.Area./1e4)%convert to square km
    xtickangle(45)
    xlabel('Number of water bodies');
    ylabel('Square kilometers');
    title(sprintf('Oshana sizes for %s',Oshanas(x).name(24:29)))
    meanSize(x)=mean([stats.Area])./1e4;    
    fprintf('The average size for month %s is %.2f square km\n',Oshanas(x).name(24:29),...
        meanSize(x));
    AvgSize=AvgSize+meanSize(x);
    fprintf('Average for %d months is %.2f square km\n',x,AvgSize/x);
    %saveas(u,sprintf('Water_size_distribution_%s.png',Oshanas(x).name(24:29)));
end
%%
AvgSize_all=AvgSize/24;