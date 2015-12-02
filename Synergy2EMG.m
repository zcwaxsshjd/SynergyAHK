function [EMG,Synergy,t1,t2,t3,t4] = Synergy2EMG(Synergy,S,L,Ch_name,Ch_name2,N_ch)
%% reconstruct EMG
[m,n] = size(Synergy.W);
l = length(Synergy.H(1,:));
EMG.EMG1 = zeros(m,l);
for i = 1:n
    EMG_temp = Synergy.W(:,i)*Synergy.H(i,:)*S(i);
    EMG.EMG1 = EMG.EMG1 + EMG_temp;
end
%% reshape EMG
R = length(EMG.EMG1(:,1));
N_trial = R/N_ch;

if N_trial == 1
    EMG.EMG1_ave = EMG.EMG1;
    Synergy.W_ave = Synergy.W;
else
    for j = 1:N_ch
        EMG.EMG1_ave(j,:) = mean( EMG.EMG1(N_ch*((1:N_trial)-1)+j,:) );
        Synergy.W_ave(j,:) = mean( Synergy.W(N_ch*((1:N_trial)-1)+j,:) );
    end
end

[EMG.EMG2,t1,t2,t3,t4] = ReshapingEMG(EMG.EMG1_ave);

% % a = 15/(2*max(max(EMG.EMG1_ave))-min(min(EMG.EMG1_ave))); 
% % b = 10 - a*min(min(EMG.EMG1_ave));
% % 以上两行作调试用，只有在将主程序S(1)、S(2)均设为1后计算a、b的值时用到
% a = 68.4226;
% b = 9.9734;
% a = 10/max(max(EMG.EMG1_ave));
a = 91.0686;
b = 5;
EMG.output = EMG.EMG2*a+b;
t_temp = min(t1);
for i = 1:N_ch
    display(Ch_name(i));
    display(['t1: ' num2str(((L*t1(i))/100) - ((t_temp)/100)) 's, EMG: 0mA']);
    display(['t2: ' num2str(((L*t2(i))/100) - ((t_temp)/100)) 's, EMG: ' num2str(max(EMG.output(i,:))) 'mA']);
    display(['t3: ' num2str(((L*t3(i))/100) - ((t_temp)/100)) 's, EMG: ' num2str(max(EMG.output(i,:))) 'mA']);
    display(['t4: ' num2str(((L*t4(i))/100) - ((t_temp)/100)) 's, EMG: 0mA']);
end
CreateAHK3(L,t_temp,t1,t2,t3,t4,EMG.output,Ch_name2);
end