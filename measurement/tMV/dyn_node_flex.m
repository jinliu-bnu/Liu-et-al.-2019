function V_wei=dyn_node_flex(input_path,output_path)

Ci_win=importdata(input_path);
Ci_win = Ci_win.Com';
%module flexibility
%  FC_dyn=load(Inputpath);
%  FC_dyn=FC_dyn.FC_dyn;
% 
% for k=1:size(FC_dyn,3)
% W = FC_dyn(:,:,k);
% 
% Ci=modularity_louvain_und_sign_jin(W);
% 
% Ci_win(k,:)=Ci;
% 
% end 
[V_wei, ~, ~] = scaled_inclusivity_wei(Ci_win, 3);

save(output_path,'V_wei','Ci_win');



