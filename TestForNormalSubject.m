clear;
clc;
close all;
%% load file
load([pwd '\C01_Synergy_Temporal\Trigger_Syn_Temp_Control_01.mat']);
Synergy_temp = Synergy(1,2);
S(1) = 2;
S(2) = 2;
L = 1;    
display(['S(1): ' num2str(S(1))]);
display(['S(2): ' num2str(S(2))]);
display(['L: ' num2str(L)]);
% L为时间缩放系数。
% E = W1*H1*S(1)+W2*H2*S(2);
% a*E+b = I;
% 其中S(1)与S(2)为可调参数，a、b为固定系数。
% S(1)、S(2)均为2时Imax达到最大值（25mA），
% 经计算得到a = 91.0686;b = 5;
%% analysis
% Ch_name = { 'PC', 'DA', 'DP', 'BI', 'Tlh', 'BR', 'Tlt'};
Ch_name = { 'Tlt', 'BR', 'Tlh', 'BI', 'DP', 'DA', 'PC'};
Ch_name2 = { 'Tlt', 'BR', 'xxx','Tlh',  'BI', 'DP', 'DA', 'PC'};
N_ch = 7;
[M,N] = size(Synergy_temp);
EMG = cell(M,N);
for i = 1:M
    for j = 1:N
        [EMG{i,j},Synergy_temp,t1,t2,t3,t4] = Synergy2EMG(Synergy_temp(i,j),S,L,Ch_name,Ch_name2,N_ch);
    end
end
%% plotting
% for i = 1:1
%     for j = 1:N
%         Syn_num = [num2str(j) '_Synergy_pattens_'];
%         plot_normal(EMG{i,j},Synergy_temp,Ch_name,N_ch,Syn_num);
%     end
% end