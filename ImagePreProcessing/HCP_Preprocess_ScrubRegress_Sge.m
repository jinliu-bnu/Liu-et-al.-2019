install_neuro_tools % Add GRETNA, DPABI, PSOM and spm into Matlab Path
fid=fopen('rfMRI_REST1_LR_Dir.list', 'r');
addpath /HeLabData2/HCP1200/Script/
tmp=textscan(fid, '%s\n');
PDirCell=tmp{1};

% Option
Opt.mode               = 'qsub'; % qsub session
Opt.max_queued         = 96;
Opt.flag_verbose       = true;
Opt.flag_pause         = false;
Opt.flag_update        = false;
Opt.time_between_checks=30;

Pl=[];
[~, ITag]=fileparts(PDirCell{1});
ITag=ITag(end-13:end);
Opt.path_logs=fullfile(pwd, [ITag, '_ScrubRegress_PreprocessLogs']);

AtlasList=cell(1, 1);
AtlasList{1}=fullfile('/PublicData/HCP/Script', 'Glasser360.nii'); % Volume-based Glasser-360
for i=1:numel(PDirCell)
    [~, Tag]=fileparts(fileparts(fileparts(fileparts(PDirCell{i}))));
    Pl.(sprintf('PTask%s_WGSR', Tag)).command=...
        'HCP_Preprocess_ScrubRegress(opt.IDir, opt.ITag, opt.IsGSR, opt.TR, opt.Band, opt.AtlasList)';
    Pl.(sprintf('PTask%s_WGSR', Tag)).opt.IDir=PDirCell{i};
    Pl.(sprintf('PTask%s_WGSR', Tag)).opt.ITag=ITag;
    Pl.(sprintf('PTask%s_WGSR', Tag)).opt.IsGSR=1;
    Pl.(sprintf('PTask%s_WGSR', Tag)).opt.TR=0.72;
    Pl.(sprintf('PTask%s_WGSR', Tag)).opt.Band=[0.01, 0.1];
    Pl.(sprintf('PTask%s_WGSR', Tag)).opt.AtlasList=AtlasList;
    
    %Pl.(sprintf('PTask%s_NGSR', Tag)).command=...
    %    'HCP_Preprocess_ScrubRegress(opt.IDir, opt.ITag, opt.IsGSR, opt.TR, opt.Band, opt.AtlasList)';
    %Pl.(sprintf('PTask%s_NGSR', Tag)).opt.IDir=PDirCell{i};
    %Pl.(sprintf('PTask%s_NGSR', Tag)).opt.ITag=ITag;
    %Pl.(sprintf('PTask%s_NGSR', Tag)).opt.IsGSR=0;
    %Pl.(sprintf('PTask%s_NGSR', Tag)).opt.TR=0.72;
    %Pl.(sprintf('PTask%s_NGSR', Tag)).opt.Band=[0.01, 0.1];
    %Pl.(sprintf('PTask%s_NGSR', Tag)).opt.AtlasList=AtlasList;    
end

psom_run_pipeline(Pl, Opt);
