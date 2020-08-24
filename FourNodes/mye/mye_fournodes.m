%% myelination 
% cd M:\Dynamic\four nodes\mye
% gii1 = gifti('M:\Dynamic\four nodes\mye\mye_360.L.func.gii');
% gii2 = gifti('M:\Dynamic\four nodes\mye\mye_360.R.func.gii');
% a = double([gii1.cdata;gii2.cdata]);
% save('mye360.txt','a','-ascii');
% BrainNet_MapCfg('FSaverage_inflated_32K.nv','mye360.txt','option_mye.mat','mye360.jpg');

load M:\Dynamic\four nodes\R1R2_ind.mat
load M:\Dynamic\four nodes\mye\myelin_360.mat
% Y = cell(1,4);
% Y{1} = myeline_360(R1R2_ind==3);
% Y{2} = myeline_360(R1R2_ind==1);
% Y{3} = myeline_360(R1R2_ind==4);
% Y{4} = myeline_360(R1R2_ind==2);
% [h ,l]=violin(Y,'facecolor', [255 213 79;79 195 247;255 138 128;156 204 101]/255,'medc','','facealpha',1,'plotlegend',0);
% set(gca,'XTick',1:4);
% set(gca,'XTickLabel',{'Shaker','Stablizer','Synthesis','Switcher'});
% set(gca,'YLim',[0.9 2.1],'YTick',[1 1.5 2],'box','off');
% set(gca,'FontSize',10);
% % set(gca,'XTickLabelRotation',60);
% set(gca,'linewidth',2);
% set(gcf, 'PaperPositionMode', 'manual');
% % set(gcf, 'PaperUnits', 'centimeters');
% set(gcf,'unit','centimeters','position',[5 5 15 15]);
% set(gcf,'Paperposition',[1 1 5 5]);
% print(gcf,'myelin_violin.tif','-dtiff','-r600')
% saveas(gcf,'M:\Dynamic\four nodes\mye\mye_ind.jpg')


for i=1:4
    for j=1:4
        myelin_360_diff(i,j)=mean(myeline_360(find(R1R2_ind==i)))-mean(myeline_360(find(R1R2_ind==j)));
    end
end
for k=1:10000
    rand_file=['M:\Dynamic\permutation\ROI_PermLabel\Rand_roi_' sprintf('%05d.mat',k)];
    load(rand_file);
    rand_R1R2_ind=Rand_label;
    for i=1:4
        for j=1:4
            diff_rand(i,j,k)=mean(myeline_360(find(rand_R1R2_ind==i)))-mean(myeline_360(find(rand_R1R2_ind==j)));
        end
    end
end
for i=1:4
    for j=1:4
p_overlap(i,j)=length(find(diff_rand(i,j,:)>myelin_360_diff(i,j)))/10000;
    end
end