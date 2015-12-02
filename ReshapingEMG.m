function [EMG2,t1,t2,t3,t4] = ReshapingEMG(EMG1)
%% reshape EMG
[m,n] = size(EMG1);
EMG2 = zeros(m,n);
t1 = zeros(1,m);
t2 = zeros(1,m);
t3 = zeros(1,m);
t4 = zeros(1,m);
for i = 1:m
    EMG_temp = EMG1(i,:)-min(EMG1(i,:));
    list1 = find(EMG_temp >= 0.1*max(EMG1(i,:)));
    list2 = find(EMG_temp >= 0.8*max(EMG1(i,:)));
    list3 = find((EMG1(i,:) >= (mean(EMG1(i,end-50:end))+0.1*(max(EMG1(i,:))-mean(EMG1(i,end-50:end))))));
    t1(i) = max(list1(1)-10,2);
    t2(i) = list2(1);
    t3(i) = list2(end);
    t4(i) = min(list3(end)+10,n);
    EMG2(i,1:t1(i)-1) = 0;
    EMG2(i,t1(i):t2(i)) = 0:(max(EMG1(i,:))/(t2(i)-t1(i))):max(EMG1(i,:));
    EMG2(i,t2(i):t3(i)) = max(EMG1(i,:));
    EMG2(i,t3(i):t4(i)) = max(EMG1(i,:)):(0-max(EMG1(i,:))/(t4(i)-t3(i))):0;
    EMG2(i,t4(i):n) = 0;
end
end