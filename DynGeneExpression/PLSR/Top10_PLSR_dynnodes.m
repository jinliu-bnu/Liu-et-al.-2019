 %% top 10 gene expression
clear,clc
top = 0.10
 
top_ind1_all=xlsread('M:\Dynamic\Dyn_geneExpression\PLSR\PLS1_geneWeights.csv',1,'B1:B16386');
ind = round(length(top_ind1_all)*top);
top_ind1 = top_ind1_all(1:ind);
top_ind2_all=xlsread('M:\Dynamic\Dyn_geneExpression\PLSR\PLS2_geneWeights.csv',1,'B1:B16386');
ind = round(length(top_ind2_all)*top);
top_ind2 = top_ind2_all(1:ind);

load M:\Dynamic\Dyn_geneExpression\preprocessing\group_express.mat
top_pls1=mean(group_express(top_ind1,:))';
top_pls2=mean(group_express(top_ind2,:))';
load M:\Dynamic\four nodes\R1R2_ind.mat
load M:\Dynamic\Dyn_geneExpression\preprocessing\region_ind.mat
tmp_ind=R1R2_ind(region_ind);

for i=1:4
    E(i,1)=mean(top_pls1(find(tmp_ind==i)));
    E(i,2)=mean(top_pls2(find(tmp_ind==i)));
    E(i,3)=std(top_pls1(find(tmp_ind==i)))/sqrt(length(find(tmp_ind==i))); 
    E(i,4)=std(top_pls2(find(tmp_ind==i)))/sqrt(length(find(tmp_ind==i)));
end
clear temp region_ind R1R2_ind i 

% permutation test
for i=1:10000
    ind_rank=tmp_ind(randperm(size(tmp_ind,1)));
    for j=1:4
        for k=1:4
            E_rand1(j,k,i)=mean(top_pls1(find(ind_rank==j)))-mean(top_pls1(find(ind_rank==k)));
            E_rand2(j,k,i)=mean(top_pls2(find(ind_rank==j)))-mean(top_pls2(find(ind_rank==k)));
        end
    end
end

for j=1:4
    for k=1:4
        p1(j,k)=length(find(E_rand1(j,k,:)>(E(j,1)-E(k,1))))/10000;
        p2(j,k)=length(find(E_rand2(j,k,:)>(E(j,2)-E(k,2))))/10000;
    end
end
% save('M:\Dynamic\Dyn_geneExpression\PLSR\top_ind_perm.mat','E','E_rand1','E_rand2','p1','p2');

%% pics
% gii1 = gifti('PLS1_ROIscores_360.L.func.gii');
% gii2 = gifti('PLS1_ROIscores_360.R.func.gii');
% a = double([gii1.cdata;gii2.cdata]);
% save('PLS1_scores.txt','a','-ascii');
% BrainNet_MapCfg('FSaverage_inflated_32K.nv','PLS1_scores.txt','option_score.mat','PLS1_score.jpg');
% 
% gii1 = gifti('PLS2_ROIscores_360.L.func.gii');
% gii2 = gifti('PLS2_ROIscores_360.R.func.gii');
% a = double([gii1.cdata;gii2.cdata]);
% save('PLS2_scores.txt','a','-ascii');
% BrainNet_MapCfg('FSaverage_inflated_32K.nv','PLS2_scores.txt','option_score.mat','PLS2_score.jpg');
% 
% clear,clc
% load M:\Dynamic\Dyn_geneExpression\preprocessing\region_ind.mat
% load('PLS1_ROIscore.mat');
% load('PLS2_ROIscore.mat');
% load('response_var_file.mat');
% pls1_301=PLS1_ROIscores_360(region_ind);
% pls2_301=PLS2_ROIscores_360(region_ind);
% z_tot=zscore(response_var_file(:,1));
% z_mod=zscore(response_var_file(:,2));
% 
% [fitresult, gof] = sandian1(z_tot, pls1_301,'.','Global Variability','PLS1 Scores', [204 204 255]/255, [153 153 204]/255, 'M:\Dynamic\Dyn_geneExpression\PLSR\pls1_tot.tiff')
% [fitresult, gof] = sandian1(z_mod, pls1_301,'.','Modular Variability','PLS1 Scores', [204 204 255]/255, [153 153 204]/255, 'M:\Dynamic\Dyn_geneExpression\PLSR\pls1_mod.tiff')
% [fitresult, gof] = sandian1(z_tot, pls2_301,'.','Global Variability','PLS2 Scores', [158 249 255]/255, [0 223 237]/255, 'M:\Dynamic\Dyn_geneExpression\PLSR\pls2_tot.tiff')
% [fitresult, gof] = sandian1(z_mod, pls2_301,'.','Modular Variability','PLS2 Scores', [158 249 255]/255, [0 223 237]/255, 'M:\Dynamic\Dyn_geneExpression\PLSR\pls2_mod.tiff')

% E=load('M:\Dynamic\Dyn_geneExpression\PLSR\top_ind_perm.mat','E')
% E=E.E;
% E=E([3,1,4,2],:);
% bartu(E,'.',['Shaker  Stablizer  Synthesis  Switcher'],'Gene Expression',[204 204 255]/255,[158 249 255]/255,'M:\Dynamic\Dyn_geneExpression\PLSR\dynamic_diff.tiff')
% 
% clear,clc
% p1=load('M:\Dynamic\Dyn_geneExpression\PLSR\top_ind_perm.mat','p1');
% p1=p1.p1;
% ind = find(p1>0.95)
% if sum(ind)>0
%    p1(ind)=1-p1(ind);
% end
% p1=p1([3 1 4 2],[3 1 4 2]);
% p1(find(p1>0.05))=4;
% p1(find(p1>0.01 & p1<0.05))=3;
% p1(find(p1>0.001 & p1<0.01))=2;
% p1(find(p1<0.001))=1;
% p1(find(diag(diag(p1))))=4;
% juzhen(p1,'PLS1 Scores',[153 153 204]/255,'M:\Dynamic\Dyn_geneExpression\PLSR\pls1_diff.tiff')
% 
% p2=load('M:\Dynamic\Dyn_geneExpression\PLSR\top_ind_perm.mat','p2');
% p2=p2.p2;
% ind = find(p2>0.95)
% if sum(ind)>0
%    p2(ind)=1-p2(ind);
% end
% p2=p2([3 1 4 2],[3 1 4 2]);
% p2(find(p2>0.05))=4;
% p2(find(p2>0.01 & p2<0.05))=3;
% p2(find(p2>0.001 & p2<0.01))=2;
% p2(find(p2<0.001))=1;
% p2(find(diag(diag(p2))))=4;
% juzhen(p2,'PLS2 Scores',[0 223 237]/255,'M:\Dynamic\Dyn_geneExpression\PLSR\pls2_diff.tiff')