% 2014-09-03, Xuhong Liao

%% Generate the dynamic FC using sliding window approach
clear
N_sub = 681;
session = 'REST1_LR'

% dir0 = 'D:\Liujin\HCPQ2\REST1';  % Input directory
dir_out = ['M:\Dynamic\Dyn\Glasser360\' session];        % Output directory
Len_win = 139; % 100s
delta = 1;
nT = 1200;      % time point number in total
N_win = floor((nT-Len_win)/delta)+1;    % maximum number of time windows

% load([dir0 filesep 'MTC90.mat']);
load M:\Dynamic\participants\list681.mat

tic
for i=1:N_sub
    temp=(['M:\Dynamic\Dyn\MTC\Glasser360\FunTC_rfMRI_' session '\' num2str(list681(i,1)) '_Glasser360_WGSR_TC.txt']);
    Timeseries=load(temp);
    [FC_dyn, ~] = Liao_FC_dyn_windows(Timeseries,Len_win,delta);
    tmp=[dir_out, filesep, 'Dyn_Glasser360_WGSR_' num2str(list681(i,1)) '.mat']
    save(tmp, 'FC_dyn');
end
toc
