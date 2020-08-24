clear,clc
load M:\Dynamic\participants\list681.mat

%% read measurements
session = {'REST1_LR','REST1_RL','REST2_LR','REST2_RL'};
for j=1:4
    for i=1:length(list681)
        temp =  ['M:\Dynamic\measurement\Glasser360\Glasser360_WGSR_' session{j} '\tot_var\tot_var_' num2str(list681(i)) '.mat'];
        tot_var(:,i)=importdata(temp);
        temp =  ['M:\Dynamic\measurement\Glasser360\Glasser360_WGSR_' session{j} '\mod_var\flex_' num2str(list681(i)) '.mat'];
        tmp=importdata(temp);
        mod_var(:,i)=tmp.V_wei;
    end
    file_name = ['M:\Dynamic\measurement\Glasser360\' session{j} '_tot_var.mat' ];
    save(file_name,'tot_var')
    file_name = ['M:\Dynamic\measurement\Glasser360\' session{j} '_mod_var.mat' ];
    save(file_name,'mod_var')
end

%% re-organize R1
session = 'REST1_LR';
mod_var_L=importdata(['M:\Dynamic\measurement\Glasser360\' session '_mod_var.mat']);
tot_var_L=importdata(['M:\Dynamic\measurement\Glasser360\' session '_tot_var.mat']);

session = 'REST1_RL';
mod_var_R=importdata(['M:\Dynamic\measurement\Glasser360\' session '_mod_var.mat']);
tot_var_R=importdata(['M:\Dynamic\measurement\Glasser360\' session '_tot_var.mat']);

mod(:,:,1)=mod_var_L;
mod(:,:,2)=mod_var_R;
mod=mean(mod,3);

tot(:,:,1)=tot_var_L;
tot(:,:,2)=tot_var_R;
tot=mean(tot,3);

save('M:\Dynamic\measurement\R1_mod_tot_681.mat','tot','mod');

group_mod_var=mean(mod,2);
group_tot_var=mean(tot,2);

save('M:\Dynamic\four nodes\group_R1_mod.mat','group_mod_var');
save('M:\Dynamic\four nodes\group_R1_tot.mat','group_tot_var');

z_group_mod_var=zscore(group_mod_var);
z_group_tot_var=zscore(group_tot_var);

save('M:\Dynamic\four nodes\z_group_R1_mod.mat','z_group_mod_var');
save('M:\Dynamic\four nodes\z_group_R1_tot.mat','z_group_tot_var');

%% re-organize R2
session = 'REST2_LR';
mod_var_L=importdata(['M:\Dynamic\measurement\Glasser360\' session '_mod_var.mat']);
tot_var_L=importdata(['M:\Dynamic\measurement\Glasser360\' session '_tot_var.mat']);

session = 'REST2_RL';
mod_var_R=importdata(['M:\Dynamic\measurement\Glasser360\' session '_mod_var.mat']);
tot_var_R=importdata(['M:\Dynamic\measurement\Glasser360\' session '_tot_var.mat']);

mod(:,:,1)=mod_var_L;
mod(:,:,2)=mod_var_R;
mod=mean(mod,3);

tot(:,:,1)=tot_var_L;
tot(:,:,2)=tot_var_R;
tot=mean(tot,3);

save('M:\Dynamic\measurement\R2_mod_tot_681.mat','tot','mod');

group_mod_var=mean(mod,2);
group_tot_var=mean(tot,2);

save('M:\Dynamic\four nodes\group_R2_mod.mat','group_mod_var');
save('M:\Dynamic\four nodes\group_R2_tot.mat','group_tot_var');

z_group_mod_var=zscore(group_mod_var);
z_group_tot_var=zscore(group_tot_var);

save('M:\Dynamic\four nodes\z_group_R2_mod.mat','z_group_mod_var');
save('M:\Dynamic\four nodes\z_group_R2_tot.mat','z_group_tot_var');