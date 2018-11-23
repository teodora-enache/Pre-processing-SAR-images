%% PLOT AREAS AGAINST TIME FROM EXCEL DOC
[num,txt,raw]=xlsread("H:\Sentinel_1\1B\Slice_Assembly\corrected\subsets\subsets_of_subsets\scripts\Kmeans_batch_processing\VH\AuxData\Evaluation_kmeans15_24images.xlsx"); 
time=raw(2:25);
time=time';
areas=raw(2:25,7);
time=cell2mat(time);
areas=cell2mat(areas);
formatIn='dd-mm-yy';
time_conv=datenum(time,formatIn);
plot(time_conv,areas,'-s','LineWidth',2)
datetick('x','mm/yy','keeplimits');
xlim([time_conv(1) time_conv(end)]);
xtickangle(45)
xlabel('Date');
ylabel('Square kilometers');
title({'Water extent derived from Sentinel 1 data','September 2016-August 2018'});
set(gcf,'Position', [489 278.6000 741.6000 483.2000]);
legend('km^2');
%% final step to include all months:
xticklabels({'25/05/2017', '18/06/2017', '24/07/2017', '29/08/2017', '22/09/2017', '28/10/2017',...
    '21/11/2017', '27/12/2017', '20/01/2018', '25/02/2018', '21/03/2018', '26/04/2018'});
datetick('x','mm/yy','keeplimits');
saveas(gcf,'Water_cover_evolution_kmeans15_2yrs.png');
