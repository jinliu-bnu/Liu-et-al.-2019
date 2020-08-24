function HCP_Preprocess_ScrubRegress(IDir, ITag, IsGSR, TR, Band, AtlasList)
%-------------------------------------------------------------------------%
if IsGSR
    Prefix='cWGSR_ScrubRegress_';
else
    Prefix='cNGSR_ScrubRegress_';
end
InputFile=fullfile(IDir, [ITag, '.nii']);
OutputFile=gretna_FUN_GetOutputFile(InputFile, Prefix);

[Data, Vox, FileList, Header]=y_ReadAll(InputFile);

TP=size(Data, 4);
NumSli=size(Data, 3);
NumRow=size(Data, 1);
NumCol=size(Data, 2);

Data=reshape(Data, [], TP);
% Global Signal Mask
if IsGSR
    Y_GSMsk=y_ReadRPI(fullfile(IDir, 'brainmask_fs.2.nii'));
    Y_GSMsk=reshape(Y_GSMsk, [], 1);
    
    Y_ImgCovMsk=logical(Y_GSMsk);
    
    ImgCov=mean(Data(Y_ImgCovMsk, :), 1)';
else
    ImgCov=[];
end


% Image Covariates
WmCov=load(fullfile(IDir, [ITag, '_WM.txt']));
CsfCov=load(fullfile(IDir, [ITag, '_CSF.txt']));

ImgCov=[ImgCov, WmCov, CsfCov];

% Head Motion
Rp=load(fullfile(IDir, 'Movement_Regressors.txt'));
Rp=Rp(:, 1:6);
%% Convert Degree to Radian
Rp(:, 4:6)=Rp(:, 4:6).*(pi/180);

%% Calculate Friston-24 Regressor
Pre=[zeros(1,6);Rp(1:end-1, :)];
HMCov=[Rp, Pre, Rp.^2, Pre.^2];

%% Calculate Power's FD
RpDiff=diff(Rp);
RpDiff=[zeros(1, 6); RpDiff];
RpDiffSphere=RpDiff;
RpDiffSphere(:, 4:6)=RpDiffSphere(:, 4:6)*50;
FD_Power=sum(abs(RpDiffSphere), 2);
save(fullfile(IDir, [ITag, '_PowerFD.txt']), 'FD_Power', '-ASCII', '-TABS', '-DOUBLE');

%% Generate FD Badpoints Regressor
FD_Thrd=0.5;
NumPre=1;
NumPost=2;
FD_Ind=find(FD_Power>FD_Thrd);
NumBP=length(FD_Ind);
BadPointCov=zeros(TP, NumBP);
for i=1:NumBP
	ind=FD_Ind(i);
	if ind-NumPre<1
		pre=1;
	else
		pre=ind-NumPre;
	end
	if ind+NumPost>TP
		post=TP;
	else
		post=ind+NumPost;
	end
	BadPointCov(pre:post, i)=1;
end

% Regressor
Rgr=ones(TP, 1);
Rgr=[Rgr, ImgCov, HMCov, BadPointCov, (1:TP)'];

for i=1:NumSli*NumRow*NumCol
    OneTc=Data(i, :);
    if any(OneTc)
        [b, r]=gretna_regress_ss(OneTc', Rgr);
        Data(i, :)=r';
    end
end

Data=reshape(Data, [NumRow, NumCol, NumSli, TP]);
y_Write(Data, Header, OutputFile);

% Bandpass
OutputFile=gretna_FUN_GetOutputFile(OutputFile, 'b');

Data=reshape(Data, [], TP);
for i=1:NumSli*NumRow*NumCol
    OneTc=Data(i, :);
    if any(OneTc)
        Mean=mean(OneTc);
        OneTc=OneTc-Mean;
        F=gretna_filtering(OneTc, TR , Band);
        Data(i, :)=F+Mean;
    end
end

Data=reshape(Data, [NumRow, NumCol, NumSli, TP]);
y_Write(Data, Header, OutputFile);

% FC
for a=1:numel(AtlasList)
	AtlasFile=AtlasList{a};
	[~, AtlasName, ~]=fileparts(AtlasFile);
	AtlasLab=y_ReadRPI(AtlasFile);
	AtlasLab=reshape(AtlasLab, [], 1);
	
    if IsGSR
        AtlasTag=[AtlasName, '_WGSR_ScrubRegress'];
    else
        AtlasTag=[AtlasName, '_NGSR_ScrubRegress'];
    end
    
	Data=reshape(Data, [], TP);
	
	U=unique(AtlasLab);
	U=U(2:end);
	TC=zeros(TP, numel(U));
	
	for i=1:numel(U)
	    Ind=(AtlasLab==U(i));
	    Tmp=Data(Ind, :);
	    TC(:, i)=mean(Tmp, 1)';
	end
	
	TCFile=fullfile(IDir, [AtlasTag, '_TC.txt']);
	save(TCFile, 'TC', '-ASCII', '-DOUBLE','-TABS');
	
	R=corr(TC, 'type', 'Pearson');
	R=(R+R')/2;%Add by Sandy
	R(isnan(R))=0;
	R=R-diag(diag(R));
	FCFile=fullfile(IDir, [AtlasTag, '_StaticFC.txt']);
	save(FCFile, 'R', '-ASCII', '-DOUBLE','-TABS');
	
	UFile=fullfile(IDir, [AtlasTag, '_NodalIndex.txt']);
	save(UFile, 'U', '-ASCII', '-DOUBLE','-TABS')
end
