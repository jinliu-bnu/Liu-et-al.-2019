% InfoMap method from (Roswall and Bergstrom, 2008)
%
% Input
%   - adj: adjacency matrix
%
% Output
%   - com: communities (listed for each node)
%
% Author: Erwan Le Martelot
% Date: 16/06/11

function [com] = infomap(adj,name)

    % Set the path and command line name
    dir_path = 'C:\msys\home\liuji\code\infomap_undir\'; %'~/Documents/Dev/infomap_undir/';
    command = 'infomap';

    
    command = [dir_path,command];
    command = [command,' ',num2str(randi(99999999)), ' ',name, '.net',' 100'];

    % Get edges list and output to file
    adj2pajek(adj,name,'.');
 
    % Call community detection algorithm
    %tic;
    system(command);
    %toc;
    
    % Load data and create data structure
    fid = fopen([name '.clu'],'rt');
    com = textscan(fid,'%f','Headerlines',1);
    fclose(fid);
    com = com{1};

    % Delete files
%     delete([name '.net']);
%     delete([name '_map.net']);
%     delete([name '_map.vec']);
%     delete([name '.clu']);
%     delete([name '.map']);
%     delete([name '.tree']);

end
