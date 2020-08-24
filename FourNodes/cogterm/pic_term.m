function pic_term(cdata1,term_name_rank,output)
%CREATEFIGURE(CDATA1)
%  CDATA1:  image cdata

%  Auto-generated by MATLAB on 21-Aug-2019 15:42:12

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create image
image(cdata1,'Parent',axes1,'CDataMapping','scaled');

% Create xlabel
xlabel('Shakers     Stablizers     Bi-active     Switchers');
caxis([0 0.1])
%% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[0.5 4.5]);
%% Uncomment the following line to preserve the Y-limits of the axes
ylim(axes1,[0.5 23.5])
box(axes1,'on');
axis(axes1,'ij');
% Set the remaining axes properties
set(axes1,'Layer','top','YTick',...
    [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23],...
    'YTickLabel',...
    {term_name_rank{1},term_name_rank{2},term_name_rank{3},term_name_rank{4},term_name_rank{5},term_name_rank{6},term_name_rank{7},term_name_rank{8},term_name_rank{9},term_name_rank{10},term_name_rank{11},term_name_rank{12},term_name_rank{13},term_name_rank{14},term_name_rank{15},term_name_rank{16},term_name_rank{17},term_name_rank{18},term_name_rank{19},term_name_rank{20},term_name_rank{21},term_name_rank{22},term_name_rank{23}});
% Create colorbar
colorbar('peer',axes1);
print(gcf,output,'-dtiff','-r600')

