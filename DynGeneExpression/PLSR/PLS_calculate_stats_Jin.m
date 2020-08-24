function PLS_calculate_stats_Jin(response_var_file, predictor_var_file, output_dir)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define the PLS calculate stats function with the following arguments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% response_var_file ------ full path to the PLS_MRI_response_vars.csv file
%%%                           that is created by the NSPN_CorticalMyelination 
%%%                           wrapper script
%%% predictor_var_file ----- full path to the PLS_gene_predictor_vars.csv file
%%%                           that is provided as raw data
%%% output_dir ------------- where to save the PLS_stats file (for PLS1 and PLS2 together)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Re-run PLS to get explained variance and associated stats')

%import response variables
% importdata(response_var_file);

%and store the response variables in matrix Y
MRIdata=response_var_file;

%import predictor variables
% importdata(predictor_var_file);
GENEdata=predictor_var_file;
geneindex=1:size(GENEdata,2);
load M:\Dynamic\Dyn_geneExpression\preprocessing\unique_gene.mat

%DO PLS in 2 dimensions (with 2 components) 
Y=zscore(MRIdata);
dim=10;
[XL,YL,XS,YS,BETA,PCTVAR,MSE,stats]=plsregress(GENEdata,Y,dim,'CV',dim);
 temp=cumsum(100*PCTVAR(2,1:dim));
 Rsquared = temp(dim);

%align PLS components with desired direction%
[R1,p1]=corr([XS(:,1),XS(:,2)],MRIdata);
if R1(1,1)<0
    XS(:,1)=-1*XS(:,1);
end
if R1(2,2)<0
    XS(:,2)=-1*XS(:,2);
end

%calculate correlations of PLS components with MRI variables
[R1,p1]=corr(XS(:,1),MRIdata);
[R2,p2]=corr(XS(:,2),MRIdata);
a=[R1',p1',R2',p2'];

%assess significance of PLS result
% load tGV and tMV from permutation
load M:\Dynamic\Dyn_geneExpression\preprocessing\region_ind.mat
load M:\Dynamic\SpinTest\Perm_Mod_Tot.mat
for j=1:10000
    temp1=zscore(AllPerm_tot(j,:));
    temp2=zscore(AllPerm_mod(j,:));
    Yp=[temp1(region_ind);temp2(region_ind)]';
    [XLr,YLr,XSr,YSr,BETAr,PCTVARr,MSEr,statsr]=plsregress(GENEdata,Yp,dim);
     PCTVARrand(j,:)=PCTVARr(2,:);
     temp=cumsum(100*PCTVARr(2,1:dim));
     Rsq(j) = temp(dim);
end
p_cum=length(find(Rsq>=Rsquared))/j;


