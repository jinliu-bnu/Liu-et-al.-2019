install_neuro_tools;

clear
load list681.mat
pre='REST1_LR/'
path = ['/HeLabData2/jinjin/Dyn/Glasser360/' pre]
out_path = ['/HeLabData2/jinjin/measurements/dyn_ci/' pre 'Win_Ci_'];

num_sub = 681;

Opt.mode = 'qsub';
Opt.max_queued = 681;
Opt.flag_pause = false;
%Opt.flag_short_job_names = false;ccc
Opt.path_logs='/HeLabData2/jinjin/log';

for n=1:num_sub
    Job_name = ['Ci_' num2str(n)];
    name = [num2str(list681(n))];
    path1=[path 'Dyn_Glasser360_WGSR_' num2str(list681(n)) '.mat'];
    Outputname=[out_path num2str(list681(n)) '.mat'];
    pipeline.(Job_name).command = 'infomap_detection_jin(opt.path1,opt.thr,opt.outputname,opt.name)';
    pipeline.(Job_name).opt.path1 = path1;
    pipeline.(Job_name).opt.thr = 0.15;
    pipeline.(Job_name).opt.outputname = Outputname;
    pipeline.(Job_name).opt.name = name;
end

psom_run_pipeline(pipeline,Opt);

