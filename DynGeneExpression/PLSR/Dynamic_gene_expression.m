clear,clc
load M:\Dynamic\Dyn_geneExpression\preprocessing\group_express.mat
load M:\Dynamic\Dyn_geneExpression\preprocessing\region_ind.mat
load M:\Dynamic\Dyn_geneExpression\preprocessing\unique_gene.mat

load M:\Dynamic\measurement\R1_mod_tot_681.mat
g_mod(:,:,1)=mod;
g_tot(:,:,1)=tot;
load M:\Dynamic\measurement\R2_mod_tot_681.mat
g_mod(:,:,2)=mod;
g_tot(:,:,2)=tot;

g_mod=mean(g_mod,3);
g_mod=mean(g_mod,2);
g_mod=g_mod(region_ind);

g_tot=mean(g_tot,3);
g_tot=mean(g_tot,2);
g_tot=g_tot(region_ind);

predictor_var_file=group_express';
save('M:\Dynamic\Dyn_geneExpression\PLSR\predictor_var_file.mat','predictor_var_file');
response_var_file=[g_tot g_mod];
save('M:\Dynamic\Dyn_geneExpression\PLSR\response_var_file.mat','response_var_file');
output_dir = 'M:\Dynamic\Dyn_geneExpression\PLSR\'
clear mod tot g_tot g_mod 

PLS_calculate_stats_Jin(response_var_file, predictor_var_file, output_dir)
PLS_bootstrap_Jin(response_var_file, predictor_var_file,region_ind, output_dir)


