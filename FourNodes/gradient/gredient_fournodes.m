clear,clc

%pic for gredient
% temp=spm_vol('M:\Dynamic\Glasser360.nii')
% [Y,XYZ]=spm_read_vols(temp);
% temp=spm_vol('M:\Dynamic\four nodes\gradient\volume.grad_1.MNI2mm.nii')
% [Y1,XYZ1]=spm_read_vols(temp);
% grad_glasser360=zeros(360,1);
% for i=1:360
%         grad_glasser360(i)=mean(Y1(find(Y==i)));
% end
% GetSurf(grad_glasser360, 'grad_glasser360')
% save('grad360.mat','grad_glasser360');
% 
% gii1 = gifti('grad_glasser360.L.func.gii');
% gii2 = gifti('grad_glasser360.L.func.gii');
% a = double([gii1.cdata;gii2.cdata]);
% save('graident_margulies.txt','a','-ascii');
% BrainNet_MapCfg('FSaverage_inflated_32K.nv','graident_margulies.txt','option_mye.mat','grad_marg_360.jpg');

% diff of gradient within four types of nodes
load('M:\Dynamic\four nodes\R1R2_ind.mat')
load('M:\Dynamic\four nodes\gradient\grad360.mat')
% Y = cell(1,4);
% Y{1} = grad_glasser360(R1R2_ind==3);
% Y{2} = grad_glasser360(R1R2_ind==1);
% Y{3} = grad_glasser360(R1R2_ind==4);
% Y{4} = grad_glasser360(R1R2_ind==2);
% [h ,l]=violin(Y,'facecolor', [255 213 79;79 195 247;255 138 128;156 204 101]/255,'medc','','facealpha',1,'plotlegend',0);
% set(gca,'XTick',1:4);
% set(gca,'XTickLabel',{'Shaker','Stablizer','Synthesis','Switcher'});
% set(gca,'YLim',[-7 18],'YTick',[0 5 15],'box','off');
% set(gca,'FontSize',10);
% % set(gca,'XTickLabelRotation',60);
% set(gca,'linewidth',2);
% set(gcf, 'PaperPositionMode', 'manual');
% % set(gcf, 'PaperUnits', 'centimeters');
% set(gcf,'unit','centimeters','position',[5 5 15 15]);
% set(gcf,'Paperposition',[1 1 5 5]);
% print(gcf,'grad_violin.tif','-dtiff','-r600')
% saveas(gcf,'M:\Dynamic\four nodes\gradient\gra_nodes.jpg')

% calculating the difference of gradient content between four dynamic nodes 
for i=1:4
    for j=1:4
        myeline_360_diff(i,j)=mean(grad_glasser360(find(R1R2_ind==i)))-mean(grad_glasser360(find(R1R2_ind==j)));
    end
end

% examing the significance of gradient differences using permutation test
for k=1:10000
     k
    rand_file=['M:\Dynamic\permutation\ROI_PermLabel\Rand_roi_' sprintf('%05d.mat',k)];
    load(rand_file);
    rand_R1R2_ind=Rand_label;
    for i=1:4
        for j=1:4
            diff_rand(i,j,k)=mean(grad_glasser360(find(rand_R1R2_ind==i)))-mean(grad_glasser360(find(rand_R1R2_ind==j)));
        end
    end
end
for i=1:4
    for j=1:4
p_overlap(i,j)=length(find(diff_rand(i,j,:)>myeline_360_diff(i,j)))/10000;
    end
end
