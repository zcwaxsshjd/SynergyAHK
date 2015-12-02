%%

%%

function plot_normal(EMG,Synergy_temp,Ch_name,N_ch,Syn_num)

EMGColor        =   [   0.08	0.17	0.55;   % dark blue
                        0       0.4     0;      % dark green
                        0.6     0.2     0;      % dark red
                        0.04	0.52	0.78;   % dark cyan
                        0.75	0       0.75;	% dark magenta
                        0.68	0.47	0;      % dark yellow
                        0.37    0.15    0.07];  % dark brown

SynColor        =   [   0.08	0.07	0.95;   % blue
                        0       0.8     0;      % green
                        0.9     0.1     0;      % red
                        0.04	0.82	0.88;   % cyan
                        0.95	0       0.95;	% magenta
                        0.78	0.77	0;      % yellow
                        0.5     0.12    0.12];  % brown

c_grey = [0.7 0.7 0.7];
Fig_Name = [pwd '\'];
%% plot Synergy_temp.W_ave for checking
C = length(Synergy_temp.W_ave(1,:));

hfig1           =   figure;
set(gcf,'Position', get(0,'ScreenSize')),

% plot Synergy_temp.W_ave
for j = 1:C
    subplot(C,1,j)
    barh(flipud(Synergy_temp.W_ave(:,j)),'FaceColor',SynColor(j,:),'EdgeColor','w'),
    axis([0 1.2*max(max(Synergy_temp.W_ave)) 0.5 N_ch+0.5]),
    set(gca,'YTick',1:N_ch,'YTickLabel',fliplr(Ch_name)),
    box off,
end
set(gcf,'PaperPositionMode','auto');
print(hfig1,'-dpng',[Fig_Name 'Reshaping_EMG_Averaged_' Syn_num]);
%% plot averaged EMG and the reshaped EMG
hfig2           =   figure;
set(gcf,'Position', get(0,'ScreenSize')),
% plot EMG
for j = 1:N_ch
    subplot(N_ch,2,2*j-1)
    hold on, plot([0 0],[0 0], 'Color',EMGColor(j,:),'LineWidth',2)
    hold on, plot([0 0],[0 0], 'Color',c_grey,'LineWidth',1)
    hold on, plot(EMG.EMG1_ave(j,:), 'Color',EMGColor(j,:),'LineWidth',2)
    legend1 = [Ch_name(j) ' Reconstruct'];
    legend2 = [Ch_name(j) ' Original'];
    legend( legend1, legend2 )
    set(legend,'Box','off'),
end

% plot reshaped EMG
for j = 1:N_ch
    subplot(N_ch,2,2*j)
    hold on, plot([0 0],[0 0], 'Color',EMGColor(j,:),'LineWidth',2)
    hold on, plot([0 0],[0 0], 'Color',c_grey,'LineWidth',1)    
    hold on, plot(EMG.EMG2(j,:), 'Color',EMGColor(j,:),'LineWidth',2)
    legend1 = [Ch_name(j) ' Reshape'];
    legend2 = [Ch_name(j) ' Original'];
    legend( legend1, legend2 )
    set(legend,'Box','off'),
end

set(gcf,'PaperPositionMode','auto');
print(hfig2,'-dpng',[Fig_Name 'Reshaping_EMG_Averaged_' Syn_num]);
% close(hfig2);
