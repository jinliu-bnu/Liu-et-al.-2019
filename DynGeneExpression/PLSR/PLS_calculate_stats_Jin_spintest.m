clear,clc
load response_var_file.mat
load predictor_var_file.mat

%import predictor variables
MRIdata=response_var_file;
GENEdata=predictor_var_file;
clear response_var_file predictor_var_file
geneindex=1:size(GENEdata,2);

%DO PLS in 2 dimensions (with 2 components) 
Y=zscore(MRIdata);
dim=2;
[XL,YL,XS,YS,BETA,PCTVAR,MSE,stats]=plsregress(GENEdata,Y,dim,'CV',dim);
 temp=cumsum(100*PCTVAR(2,1:dim));
 Rsquared = temp(dim);

%calculate correlations of PLS components with MRI variables
[R1,p1]=corr(XS(:,1),MRIdata);
[R2,p2]=corr(XS(:,2),MRIdata);
a=[R1',p1',R2',p2'];

load region_ind.mat
load Perm_Mod_Tot.mat

%assess significance of PLS result
for j=1:10000
    j
    temp1=zscore(AllPerm_tot(j,:));
    temp2=zscore(AllPerm_mod(j,:));
    Yp=[temp1(region_ind);temp2(region_ind)]';
    [XLr,YLr,XSr,YSr,BETAr,PCTVARr,MSEr,statsr]=plsregress(GENEdata,Yp,dim);
     PCTVARrand(j,:)=PCTVARr(2,:);
     temp=cumsum(100*PCTVARr(2,1:dim));
     Rsq(j) = temp(dim);
end
p_cum=length(find(Rsq>=Rsquared))/j;

% plot histogram
% hist(Rsq,10)
% hold on
% plot(Rsquared,20,'.r','MarkerSize',15)
% set(gca,'Fontsize',14)
% xlabel('R squared','FontSize',14);
% ylabel('Permuted runs','FontSize',14);
% title('p<0.0001')

%save stats
myStats=[PCTVAR; p_single];
csvwrite(fullfile(output_dir,'PLS_stats.csv'),myStats);
