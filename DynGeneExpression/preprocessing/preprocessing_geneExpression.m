%% Allen samples match to Glasser360
clear,clc
cd M:\Dynamic\Dyn_geneExpression\preprocessing\
V = spm_vol('M:\Dynamic\Glasser360.nii');
[Y,XYZ] = spm_read_vols(V);
ind_Y(:,1)=find(Y~=0)';
ind_Y(:,2)=Y(find(Y~=0)');
ind=XYZ(:,find(Y~=0))';

sample_1=xlsread('M:\Allen\9861\SampleAnnot.csv',1,'K2:M947');
sample_1=round(sample_1);
node_ind=zeros(size(sample_1,1),1);
for j=1:length(sample_1)
    clear D
    D=pdist2(sample_1(j,:),ind,'euclidean');
    if min(D)<5
        [a min_ind]=min(D);
        node_ind(j,1)=ind_Y(min_ind,2);
    end
end
save('sample_9861_glasserlabel.mat','node_ind');

sample_1=xlsread('M:\Allen\10021\SampleAnnot.csv',1,'K2:M894');
sample_1=round(sample_1);
node_ind=zeros(size(sample_1,1),1);
 for j=1:length(sample_1)
    clear D
    D=pdist2(sample_1(j,:),ind,'euclidean');
    if min(D)<5
        [a min_ind]=min(D);
        node_ind(j,1)=ind_Y(min_ind,2);
    end
 end
save('sample_10021_glasserlabel.mat','node_ind');

sample_1=xlsread('M:\Allen\12876\SampleAnnot.csv',1,'K2:M364');
sample_1=round(sample_1);
node_ind=zeros(size(sample_1,1),1);
for j=1:length(sample_1)
    clear D
    D=pdist2(sample_1(j,:),ind,'euclidean');
    if min(D)<5
        [a min_ind]=min(D);
        node_ind(j,1)=ind_Y(min_ind,2);
    end
end
save('sample_12876_glasserlabel.mat','node_ind');

sample_1=xlsread('M:\Allen\14380\SampleAnnot.csv',1,'K2:M530');
sample_1=round(sample_1);
node_ind=zeros(size(sample_1,1),1);
for j=1:length(sample_1)
    clear D
    D=pdist2(sample_1(j,:),ind,'euclidean');
    if min(D)<5
        [a min_ind]=min(D);
        node_ind(j,1)=ind_Y(min_ind,2);
    end
end
node_ind([93 164])=0;
save('sample_14380_glasserlabel.mat','node_ind');

sample_1=xlsread('M:\Allen\15496\SampleAnnot.csv',1,'K2:M471');
sample_1=round(sample_1);
node_ind=zeros(size(sample_1,1),1);
for j=1:length(sample_1)
    clear D
    D=pdist2(sample_1(j,:),ind,'euclidean');
    if min(D)<5
        [a min_ind]=min(D);
        node_ind(j,1)=ind_Y(min_ind,2);
    end
end
save('sample_15496_glasserlabel.mat','node_ind');

sample_1=xlsread('M:\Allen\15697\SampleAnnot.csv',1,'K2:M502');
sample_1=round(sample_1);
node_ind=zeros(size(sample_1,1),1);
for j=1:length(sample_1)
    clear D
    D=pdist2(sample_1(j,:),ind,'euclidean');
    if min(D)<5
        [a min_ind]=min(D);
        node_ind(j,1)=ind_Y(min_ind,2);
    end
end
node_ind([8,40])=0;
save('sample_15697_glasserlabel.mat','node_ind');

tot_sample=zeros(6,360);
for i=1:6
    sample_ID =[9861;10021;12876;14380;15496;15697];
    temp=importdata(['M:\Dynamic\Dyn_geneExpression\preprocessing\sample_' num2str(sample_ID(i)) '_glasserlabel.mat']);
    for j=1:360
        tot_sample(i,j)=length(find(temp==j));
    end
end
tot_sample(6,8)=0;
tot_sample(6,40)=0;
tot_sample(4,93)=0;
tot_sample(4,164)=0;
sample_glasser=sum(tot_sample,1)';

load M:\Dynamic\four nodes\R1R2_ind.mat
for i=1:4
   num_sample(i)=sum(sample_glasser(find(R1R2_ind==i)));
   num_regions(i)=length(find(sample_glasser(find(R1R2_ind==i))~=0));
end
save('M:\Dynamic\Dyn_geneExpression\preprocessing\sample_match.mat','num_regions','num_sample','sample_glasser','tot_sample');

%% probe selection
clear,clc
sample_ID =[9861;10021;12876;14380;15496;15697];
for j=1:length(sample_ID)
   input_tmp=['M:\Allen\' num2str(sample_ID(j)) '\PACall.csv'];
   name_call=xlsread(input_tmp,1,'A1:A58692');
   tmp_call=xlsread(input_tmp,1,'B1:AJK58692');
   node_ind=importdata(['M:\Dynamic\Dyn_geneExpression\preprocessing\sample_' num2str(sample_ID(j)) '_glasserlabel.mat']);
   call(:,j)=sum(tmp_call(:,find(node_ind)),2);
end
save('M:\Dynamic\Dyn_geneExpression\preprocessing\call.mat','call');

% table from Allen brain 
probe_id=xlsread('M:\Allen\10021\Probes.csv',1,'A2:A58693');
[~,probe_name,~]=xlsread('M:\Allen\10021\Probes.csv',1,'B2:B58693');
gene_id=xlsread('M:\Allen\10021\Probes.csv',1,'C2:C58693');
[~,gene_sym,~]=xlsread('M:\Allen\10021\Probes.csv',1,'D2:D58693');
entrez_id=xlsread('M:\Allen\10021\Probes.csv',1,'F2:F58693');

% table from re-annotation software
[~,re_probe,~]=xlsread('M:\Dynamic\Dyn_geneExpression\preprocessing\AllenBrain_reAnnotation.xlsx',2,'B2:B56490');
mismatch=xlsread('M:\Dynamic\Dyn_geneExpression\preprocessing\AllenBrain_reAnnotation.xlsx',2,'E2:E56490');
[~,re_gene_sym,~]=xlsread('M:\Dynamic\Dyn_geneExpression\preprocessing\AllenBrain_reAnnotation.xlsx',2,'M2:M56490');
entrez_id(57860:58692)=NaN;

% read files with probes call information in different sample
load M:\Dynamic\Dyn_geneExpression\preprocessing\call.mat
load M:\Dynamic\Dyn_geneExpression\preprocessing\sample_match.mat
num_total_samples=sum(num_sample);

% probes call at least in 50% of cerebral cortex (Glasser360)
select_probes_entrez_id=entrez_id(intersect(find(~isnan(entrez_id)),find(sum(call,2)>num_total_samples*0.5)));
select_probes_id=probe_id(intersect(find(~isnan(entrez_id)),find(sum(call,2)>num_total_samples*0.5)));
select_probes_name=probe_name(intersect(find(~isnan(entrez_id)),find(sum(call,2)>num_total_samples*0.5)));
select_probes_name(:,2)=gene_sym(intersect(find(~isnan(entrez_id)),find(sum(call,2)>num_total_samples*0.5)));

% organized the re-annotation of probes
for i=1:length(select_probes_id)
    i
    if sum(strcmp(re_probe,select_probes_name{i,1}))==1
        re_anno(i,1)=re_probe(find(strcmp(re_probe,select_probes_name{i,1})));
        re_anno(i,2)=re_gene_sym(find(strcmp(re_probe,select_probes_name{i,1})));
    elseif sum(strcmp(re_probe,select_probes_name{i,1}))>1
        temp=find(strcmp(re_probe,select_probes_name{i,1}));
        re_anno(i,1)=re_probe(temp(1));
        re_anno(i,2)=re_gene_sym(temp(1));
    else
        re_anno{i,1}=[];
        re_anno{i,2}=[];
    end
end

% compare final re-annotation probe list with Allen Human Brain Atlas
for i=1:length(select_probes_name)
    if findstr(re_anno{i,2},select_probes_name{i,2})>0
        compare_probe(i,1)=1;
    else
        compare_probe(i,1)=0;
    end
end
length(select_probes_name)-length(find(compare_probe)) % number of probes with annotation different from AIBS

% excluded empty one
for i=1:length(re_anno)
 ind(i)=isempty(re_anno{i,1});
end
re_anno(ind,:)=[];
select_probes_entrez_id(ind,:)=[];
% get final probe list
select_probes_name(ind,:)=[];
select_probes_id(ind,:)=[];
length(find(ind))

save('M:\Dynamic\Dyn_geneExpression\preprocessing\final_probes.mat','select_probes_entrez_id','select_probes_id','select_probes_name','re_anno');

%% averaged probes for same gene
clear,clc
load M:\Dynamic\Dyn_geneExpression\preprocessing\final_probes.mat

% get the unique final gene list
% unique_gene=unique(re_anno(:,2));
[~,unique_gene,~]=xlsread('M:\Dynamic\Dyn_geneExpression\preprocessing\uniquegene.xlsx',1,'I1:I16392');

% read gene expression file for each donor 
% averaged probes for the same gene within each donor
% z-score normalization across regions for each gene within each donor
sample_ID =[9861;10021;12876;14380;15496;15697];
for j=1:length(sample_ID)
    j
    name_expre=xlsread(['M:\Allen\' num2str(sample_ID(j)) '\MicroarrayExpression.csv'],1,'A1:A58692');
    tmp_expre=xlsread(['M:\Allen\' num2str(sample_ID(j)) '\MicroarrayExpression.csv'],1,'B1:AJK58692');
    ind=zeros(length(select_probes_id),1);
    for i=1:length(select_probes_id)
        ind(i,1)=find(name_expre==select_probes_id(i));
    end
    node_ind=importdata(['M:\Dynamic\Dyn_geneExpression\preprocessing\sample_' num2str(sample_ID(j)) '_glasserlabel.mat']);
    clear express
    express=tmp_expre(ind,find(node_ind));
    clear mean_probe_express
    for l=1:length(unique_gene)
        mean_probe_express(l,:)=mean(express(find(strcmp(re_anno(:,2),unique_gene(l))),:),1);
    end
    all_donor{j}=mean_probe_express;
    z_mean_probe_express=(mean_probe_express-repmat(mean(mean_probe_express,2),1,size(mean_probe_express,2)))./(repmat(std(mean_probe_express,1,2),1,size(mean_probe_express,2)));
    z_all_donor{j}=z_mean_probe_express;
end
save('M:\Dynamic\Dyn_geneExpression\preprocessing\donor_expression.mat','all_donor','z_all_donor');

% averaged gene expression across samples within the same region within each donor
for j=1:6
    mean_probe_express=z_all_donor{j};
    node_ind=importdata(['M:\Dynamic\Dyn_geneExpression\preprocessing\sample_' num2str(sample_ID(j)) '_glasserlabel.mat']);
    mean_express=zeros(size(z_all_donor{j},1),360);
    tmp_ind=find(node_ind);
    for i=1:360
        temp_ind=node_ind(tmp_ind);
        if find(temp_ind==i)
            mean_express(:,i)=mean(mean_probe_express(:,temp_ind==i),2);
        end
    end
    express_gene_glasser{j}=mean_express;
end

% averaged expression across donor for each brain region
clear temp tmp
for j=1:6
    temp(:,:,j)=express_gene_glasser{j};
end
tmp=reshape(temp(1,:,:),360,6);

for i=1:360
group_express(:,i)=sum(temp(:,i,:),3)/length(find(temp(1,i,:)));
end
group_express(isnan(group_express))=0;

region_ind=find(group_express(1,:));
group_express=group_express(:,region_ind);
save('M:\Dynamic\Dyn_geneExpression\preprocessing\region_ind.mat','region_ind');
save('M:\Dynamic\Dyn_geneExpression\preprocessing\group_express.mat','group_express');