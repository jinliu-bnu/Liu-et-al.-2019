%% hierarchy
clear,clc
load M:\Dynamic\four nodes\hier\hier360.mat
load M:\Dynamic\four nodes\R1R2_ind.mat

% cd M:\Dynamic\four nodes\hier\
% gii1 = gifti('final_hier_360.L.func.gii');
% gii2 = gifti('final_hier_360.R.func.gii');
% a = double([gii1.cdata;gii2.cdata]);
% a(find(a~=1))=0;
% save('M:\Dynamic\four nodes\hier\pic_hier_1.txt','a','-ascii');
% BrainNet_MapCfg('FSaverage_inflated_32K.nv','pic_hier_1.txt','yellow.mat','hier_1.jpg');
% 
% gii1 = gifti('final_hier_360.L.func.gii');
% gii2 = gifti('final_hier_360.R.func.gii');
% a = double([gii1.cdata;gii2.cdata]);
% a(find(a~=2))=0;
% save('M:\Dynamic\four nodes\hier\pic_hier_2.txt','a','-ascii');
% BrainNet_MapCfg('FSaverage_inflated_32K.nv','pic_hier_2.txt','blue.mat','hier_2.jpg');
% 
% gii1 = gifti('final_hier_360.L.func.gii');
% gii2 = gifti('final_hier_360.R.func.gii');
% a = double([gii1.cdata;gii2.cdata]);
% a(find(a~=3))=0;
% save('M:\Dynamic\four nodes\hier\pic_hier_3.txt','a','-ascii');
% BrainNet_MapCfg('FSaverage_inflated_32K.nv','pic_hier_3.txt','pink.mat','hier_3.jpg');
% 
% gii1 = gifti('final_hier_360.L.func.gii');
% gii2 = gifti('final_hier_360.R.func.gii');
% a = double([gii1.cdata;gii2.cdata]);
% a(find(a~=4))=0;
% save('M:\Dynamic\four nodes\hier\pic_hier_4.txt','a','-ascii');
% BrainNet_MapCfg('FSaverage_inflated_32K.nv','pic_hier_4.txt','green.mat','hier_4.jpg');
% 
% cd M:\Dynamic\four nodes\hier
% gii1 = gifti('M:\Dynamic\four nodes\R1R2_ind.L.func.gii');
% gii2 = gifti('M:\Dynamic\four nodes\R1R2_ind.R.func.gii');
% a = double([gii1.cdata;gii2.cdata]);
% a(find(a~=1))=0;
% save('M:\Dynamic\four nodes\hier\R1R2_ind_1.txt','a','-ascii');
% BrainNet_MapCfg('FSaverage_inflated_32K.nv','M:\Dynamic\four nodes\hier\R1R2_ind_1.txt','blue.mat','R1R2_ind_1.jpg');
% 
% gii1 = gifti('M:\Dynamic\four nodes\R1R2_ind.L.func.gii');
% gii2 = gifti('M:\Dynamic\four nodes\R1R2_ind.R.func.gii');
% a = double([gii1.cdata;gii2.cdata]);
% a(find(a~=2))=0;
% save('R1R2_ind_2.txt','a','-ascii');
% BrainNet_MapCfg('FSaverage_inflated_32K.nv','R1R2_ind_2.txt','green.mat','R1R2_ind_2.jpg');
% 
% gii1 = gifti('M:\Dynamic\four nodes\R1R2_ind.L.func.gii');
% gii2 = gifti('M:\Dynamic\four nodes\R1R2_ind.R.func.gii');
% a = double([gii1.cdata;gii2.cdata]);
% a(find(a~=3))=0;
% save('R1R2_ind_3.txt','a','-ascii');
% BrainNet_MapCfg('FSaverage_inflated_32K.nv','R1R2_ind_3.txt','yellow.mat','R1R2_ind_3.jpg');
% 
% gii1 = gifti('M:\Dynamic\four nodes\R1R2_ind.L.func.gii');
% gii2 = gifti('M:\Dynamic\four nodes\R1R2_ind.R.func.gii');
% a = double([gii1.cdata;gii2.cdata]);
% a(find(a~=4))=0;
% save('R1R2_ind_4.txt','a','-ascii');
% BrainNet_MapCfg('FSaverage_inflated_32K.nv','R1R2_ind_4.txt','pink.mat','R1R2_ind_4.jpg');

%% overlap calculation
load M:\Dynamic\four nodes\R1R2_ind.mat
load M:\Dynamic\four nodes\hier\hier360.mat
for i=1:4
    for j=1:4
    overlap_hier_nodes(i,j)=length(intersect(find(R1R2_ind==i),find(final_hier_360==j)))/length(find(final_hier_360==j));
    end
end

for k=1:10000
    rand_file=['M:\Dynamic\permutation\ROI_PermLabel\Rand_roi_' sprintf('%05d.mat',k)];
    load(rand_file);
    rand_R1R2_ind=Rand_label;
for i=1:4
    for j=1:4
    overlap_hier_rand(i,j,k)=length(intersect(find(rand_R1R2_ind==i),find(final_hier_360==j)))/length(find(final_hier_360==j));
    end
end
end

for i=1:4
    for j=1:4
p_overlap(i,j)=length(find(overlap_hier_rand(i,j,:)>overlap_hier_nodes(i,j)))/10000;
    end
end

% ind = [3, 1, 4, 2];
% overlap_hier_nodes1=overlap_hier_nodes(ind,:);
% 
% x=[1 2 3 4];
% y1=overlap_hier_nodes1(:,1);
% y2=overlap_hier_nodes1(:,2);
% y3=overlap_hier_nodes1(:,3);
% y4=overlap_hier_nodes1(:,4);
% plot(x,y1,'k-o','linewidth',2.5,'MarkerEdgeColor',[255 213 79]/255,'color',[255 213 79]/255);
% hold on 
% plot(x,y2,'k-o','linewidth',2.5,'MarkerEdgeColor',[79 195 247]/255,'color',[79 195 247]/255);
% plot(x,y3,'k-o','linewidth',2.5,'MarkerEdgeColor',[255 138 128]/255,'color',[255 138 128]/255);
% plot(x,y4,'k-o','linewidth',2.5,'MarkerEdgeColor',[156 204 101 ]/255,'color',[156 204 101 ]/255);
% axis([0.5 4.5 0 0.66])
% set(gca,'FontSize',15);
% set(gca,'linewidth',2);
% set(gca,'YTick',0.2:0.2:0.6);
% set(gca,'XTick',1:1:4);
% set(gca,'XTicklabel',{'Shaker','Stabilizer','Synthesis','Switcher'});
% legend('Primary','Unimodal','Heteromodal','Paralimbic/limbic','Location','NorthEastOutside');
% set(gcf,'unit','centimeters','position',[5 5 20 10]);
% % set(gca,'Position',[10 10 10 5]);
% set(gcf,'Paperposition',[1 1 10 5]);
% 
% print(gcf,'overlap_hier.tif','-dtiff','-r600')

