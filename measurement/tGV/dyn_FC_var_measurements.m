%% dynamic measurement 
clear,clc
load M:\Dynamic\participants\list681.mat
session=['REST1_LR'; 'REST1_RL'; 'REST2_LR'; 'REST2_RL'];

%% temporal Global Variability
% setting the low-frequency threshold
power_threshold = 0.8;
Num_node = 360;
Num_win = 1062;

for i=1:681
    path_name =['mean_Fre_' num2str(list681(i)) '.mat'];
    % the frequency spectrum can obtained by using tGV_find_threshold.m
    temp=load(path_name);
    group_Fre(:,i)=temp.mean_Fre_R1;
end
mean_Fre_R1=mean(group_Fre,2);
mean_Fre_R1_sum=cumsum(mean_Fre_R1(2:end));
ind=min(find(mean_Fre_R1_sum>=(sum(mean_Fre_R1(2:end)).*power_threshold)));%ind=124 
Hz=X(ind);
clear path_name temp tmp X group_Fre mean_Fre_R1_sum mean_Fre_R1 power_threshold 

for k=1:4
    for i=1:length(list681)
        temp=['M:\Dynamic\Dyn\Glasser360\' session(k,:) '\Dyn_Glasser360_WGSR_' num2str(list681(i)) '.mat'];
        FC_dyn=importdata(temp);
        tmp=['M:\Dynamic\measurement\Glasser360\Glasser360_WGSR_' session(k,:) '\tot_var\tot_var_' num2str(list681(i))  '.mat'];
        dyn_var_sub=dyn_FC_var(FC_dyn,Num_node,Num_win,ind,tmp);
    end
end
