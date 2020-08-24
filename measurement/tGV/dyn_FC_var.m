function dyn_var_sub=dyn_FC_var(FC_dyn,Num_nodes,Num_windows,ind,Outputname)

%==========================================================================
% This function is used to calulate the dynamic functional connectivity
% variablity for each participant. 
%
% Inputs:
%       FC_dyn:
%                   The cell array with ach cell having 3D (M*M*T) 
%                   connectivity matrices (dynamic functional connectivity 
%                   matrice after sliding time-window analysis) for each 
%                   subject. M = number of nodes, T = number of windows
%  
%       Num_nodes:
%                   The number of nodes in FC_dyn   
%
%       Num_windows:
%                   The number of dynamic windows in FC_dyn   
%
%       ind:
%                   The threshold point in frequency specturm, this  
%                   parameter could be used in dyn_FC_var.
%
% Outputs:
%       dyn_var_sub:
%                   The vector (M*1) of global variability of
%                   connectivity 
%
% Jin Liu, 2016/11/14
%==========================================================================

temp=LJ_Reshape(FC_dyn,Num_nodes,Num_windows);
dyn_var_sub=LJ_ALFF(temp,Num_nodes,ind);
tot_var=sum(dyn_var_sub,2);
save(Outputname,'tot_var');
