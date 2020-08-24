install_neuro_tools;
clear,clc
load list681.mat

pre='REST1_LR/'
path = ['/HeLabData2/jinjin/measurements/dyn_ci/' pre]
out_path = ['/HeLabData2/jinjin/measurements/' pre 'flex_']
num_sub = 681;

Opt.mode = 'qsub';
Opt.max_queued = 681;
Opt.flag_pause = false;
%Opt.flag_short_job_names = false;
Opt.path_logs='/HeLabData2/jinjin/log';

for n=1:num_sub
    Job_name = ['flex_' num2str(list681(n))];
    path1=[path 'Win_Ci_' num2str(list681(n)) '.mat'];
    Outputname=[out_path num2str(list681(n)) '.mat'];
    pipeline.(Job_name).command = 'dyn_node_flex(opt.input_path,opt.output_path)';
    pipeline.(Job_name).opt.input_path = path1;
    pipeline.(Job_name).opt.output_path= Outputname;
end

psom_run_pipeline(pipeline,Opt);

