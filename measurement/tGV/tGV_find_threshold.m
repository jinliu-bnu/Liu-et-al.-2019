function [mean_Fre_R1 X ind Hz]=tGV_find_threshold(FC_dyn,Num_nodes,Num_windows,power_threshold,meanFre_Output)

%==========================================================================
% This function is used to find the low-frequency threshold (corresponding 
% to 80% energy of the frequency spectrum) for the temporal global 
% variability of functional connectivity for each subject. 
%
% Inputs:
%
%       FC_dyn:
%                   The cell array with each cell having 3D (M*M*T) 
%                   connectivity matrices (dynamic network matrice) for 
%                   each subject. 
%                   M = number of nodes, T = number of windows
%
%       Num_nodes:
%                   The number of nodes in FC_dyn   
%
%       Num_windows:
%                   The number of dynamic windows in FC_dyn   
%
%       power_threshold:
%                   The threshold of power in frequency spectrum    
%                   for example, 0.8 means 80% energy of the frequency
%                   spectrum
%
%       meanFre_Output:
%                   The output path/name for the mean frequency specturm
%
% Outputs:
%       mean_Fre_R1:
%                   The mean frequency specturm
%
%       X:
%                   HZ
%
%
%       ind:
%                   The threshold point in frequency specturm, this  
%                   parameter could be used in dyn_tGV.
%                  
%       Hz:
%                   The Hz corresponding to the threshold point in  
%                   frequency specturm
%
%
% Jin Liu, 2016/11/14
%==========================================================================

temp=LJ_Reshape(FC_dyn, Num_nodes, Num_windows); 
[tmp X]=LJ_ALFF_threshold(temp);
clear temp
mean_Fre_R1=mean(tmp,2);
clear tmp
mean_Fre_R1_sum=cumsum(mean_Fre_R1(2:end));
ind=min(find(mean_Fre_R1_sum>(sum(mean_Fre_R1(2:end)).*power_threshold)));
Hz=X(ind);
save(meanFre_Output,'mean_Fre_R1');
