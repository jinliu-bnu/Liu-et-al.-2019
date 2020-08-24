%% node definition
clear,clc
load M:\Dynamic\four nodes\z_group_R1_mod.mat
load M:\Dynamic\four nodes\z_group_R1_tot.mat
group_mod_var1=z_group_mod_var;
group_tot_var1=z_group_tot_var;
ind=zeros(length(group_mod_var1),1);
for i=1:length(group_mod_var1)
    if group_mod_var1(i) > 0 & group_tot_var1(i) >0
    ind(i)=4; % bi-active
    elseif group_mod_var1(i) < 0 & group_tot_var1(i) > 0
    ind(i)=3; % shaker
    elseif group_mod_var1(i) > 0 & group_tot_var1(i) < 0
    ind(i)=2; % switcher
    elseif group_mod_var1(i) < 0 & group_tot_var1(i) < 0
    ind(i)=1; % stabilizer
    end
end
R1_ind=ind;

load M:\Dynamic\four nodes\z_group_R2_mod.mat
load M:\Dynamic\four nodes\z_group_R2_tot.mat
group_mod_var2=z_group_mod_var;
group_tot_var2=z_group_tot_var;
ind=zeros(length(group_mod_var2),1);
for i=1:length(group_mod_var2)
    if group_mod_var2(i) > 0 & group_tot_var2(i) >0
    ind(i)=4; % bi-active
    elseif group_mod_var2(i) <0 & group_tot_var2(i) > 0
    ind(i)=3; % shaker
    elseif group_mod_var2(i) > 0 & group_tot_var2(i) < 0
    ind(i)=2; % switcher
     elseif group_mod_var2(i) < 0 & group_tot_var2(i) < 0
    ind(i)=1; % stabilizer
    end
end
R2_ind=ind;

for k=1:4
    tmp1{k,1}=find(R1_ind==k);
    tmp2{k,1}=find(R2_ind==k);
end
nmi_R1R2=gretna_NMI(tmp1,tmp2)

[r p]=corr(group_mod_var1,group_mod_var2)
[r p]=corr(group_tot_var1,group_tot_var2)

save('M:\Dynamic\four nodes\R1_ind.mat','R1_ind');
save('M:\Dynamic\four nodes\R2_ind.mat','R2_ind');

%% hub definition with combining R1 and R2
clear,clc
load M:\Dynamic\measurement\R1_mod_tot_681.mat
all_tot(:,:,1)=tot;
all_mod(:,:,1)=mod;
load M:\Dynamic\measurement\R2_mod_tot_681.mat
all_tot(:,:,2)=tot;
all_mod(:,:,2)=mod;
for i=1:size(all_mod,2)
    sub_r_tot(i,1)=corr(all_tot(:,i,1),all_tot(:,i,2));
    sub_r_mod(i,1)=corr(all_mod(:,i,1),all_mod(:,i,2));
end
all_tot=mean(all_tot,3);
all_mod=mean(all_mod,3);
group_mod_var=mean(all_mod,2);
group_tot_var=mean(all_tot,2);


group_mod_var=zscore(group_mod_var);
group_tot_var=zscore(group_tot_var);
save('M:\Dynamic\four nodes\z_group_R1R2_mod.mat','group_mod_var');
save('M:\Dynamic\four nodes\z_group_R1R2_tot.mat','group_tot_var');

ind=zeros(length(group_mod_var),1);
for i=1:length(group_mod_var)
    if group_mod_var(i) > 0 & group_tot_var(i) >0
    ind(i)=4; % bi-active
    elseif group_mod_var(i) <0 & group_tot_var(i) > 0
    ind(i)=3; % shaker
    elseif group_mod_var(i) > 0 & group_tot_var(i) < 0
    ind(i)=2; % switcher
     elseif group_mod_var(i) < 0 & group_tot_var(i) < 0
    ind(i)=1; % stabilizer
    end
end
R1R2_ind=ind;
save('M:\Dynamic\four nodes\R1R2_ind.mat','R1R2_ind');

%% draw pics
% cd M:\Dynamic\four nodes\
% gii1 = gifti('z_group_R1R2_tot.L.func.gii');
% gii2 = gifti('z_group_R1R2_tot.R.func.gii');
% a = double([gii1.cdata;gii2.cdata]);
% save('R1R2_tot.txt','a','-ascii');
% BrainNet_MapCfg('FSaverage_inflated_32K.nv','R1R2_tot.txt','option_meas.mat','R1R2_tot.jpg');
% 
% gii1 = gifti('z_group_R1R2_mod.L.func.gii');
% gii2 = gifti('z_group_R1R2_mod.R.func.gii');
% a = double([gii1.cdata;gii2.cdata]);
% save('R1R2_mod.txt','a','-ascii');
% BrainNet_MapCfg('FSaverage_inflated_32K.nv','R1R2_mod.txt','option_meas.mat','R1R2_mod.jpg');
% 
% gii1 = gifti('R1R2_ind.L.func.gii');
% gii2 = gifti('R1R2_ind.R.func.gii');
% a = double([gii1.cdata;gii2.cdata]);
% save('R1R2_ind.txt','a','-ascii');
% BrainNet_MapCfg('FSaverage_inflated_32K.nv','R1R2_ind.txt','option_ind.mat','R1R2_ind.jpg');

