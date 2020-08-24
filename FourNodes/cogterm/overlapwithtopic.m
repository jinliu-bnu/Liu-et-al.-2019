% overlap between four nodes and cognitive topic maps
clear,clc
% calculating overlapping 
load M:\Dynamic\four nodes\R1R2_ind.mat
temp=spm_vol('M:\Dynamic\four nodes\cogterm\2mm_Glasser360_6mmFromMidthickness.nii')
[Y1,XYZ1]=spm_read_vols(temp);

node = {'shaker';'stablizer';'biactive';'switcher'}
file_path='M:\Dynamic\four nodes\cogterm\'
for i=1:4
    mask = [file_path 'mask_' node{i} '.nii']
    temp=spm_vol(mask)
    [Y1,XYZ1]=spm_read_vols(temp);
    
    topic_file=dir([file_path, 'topicmaps/']);
    topic_file(1:5,:)=[];
    
    for j=1:length(topic_file)
    V=spm_vol([file_path, 'topicmaps/', topic_file(j).name]);
    [Y,XYZ]=spm_read_vols(V);

    overlap_topic(j,i)=sum(Y(find(Y1~=0 & Y>0)))/length(find(Y(Y1~=0 & Y>0)~=0));
    percentage_overlap(j,i)= length(find(Y(find(Y1~=0 & Y>0))~=0))/length(find(Y1~=0));
    end  
end
% generating figure
term_name={'fear'; 'inhibition';'number'; 'action';'cognitive control'; 'spatial';'emotion'; 'social empathy';'decision making';'pain';'memory';'language';'semantic'; 'face';'imagery';'visual';'eye gaze'; 'motion';'attention';  'auditory';'reward'; 'social cognition';'working memory'}; 
overlap_topic_z=percentage_overlap;
[overlap_topic_z_rank,term_rank]=sortrows(overlap_topic_z,[-1,-2,3,4]);
topic_file_rank=topic_file(term_rank);
term_name_rank=term_name(term_rank)
pic_term(overlap_topic_z_rank,term_name_rank,'cog_23_nodes.tif');