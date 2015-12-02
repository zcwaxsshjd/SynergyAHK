function CreateAllAHK(L,t_temp,t1,t2,t3,t4,EMG,Ch_name)
N = length(Ch_name);
fp = fopen('AllChannel.ahk','w');
fprintf(fp,'%s\r\n','^J::');
i = 1;
for a = 1:N
    if strcmp(Ch_name{a},'xxx')
        fprintf(fp,'%s\r\n','send, +{Tab}');
    else
        fprintf(fp,'%s\r\n','myArray := []');
        fprintf(fp,'%s\r\n',['myArray.insert("' num2str(((L*t1(i))/100) - ((t_temp)/100)) '")']);
        fprintf(fp,'%s\r\n',['myArray.insert("' num2str(0) '")']);
        fprintf(fp,'%s\r\n',['myArray.insert("' num2str(((L*t2(i))/100) - ((t_temp)/100)) '")']);
        fprintf(fp,'%s\r\n',['myArray.insert("' num2str(max(EMG(i,:))) '")']);
        fprintf(fp,'%s\r\n',['myArray.insert("' num2str(((L*t3(i))/100) - ((t_temp)/100)) '")']);
        fprintf(fp,'%s\r\n',['myArray.insert("' num2str(max(EMG(i,:))) '")']);
        fprintf(fp,'%s\r\n',['myArray.insert("' num2str(((L*t4(i))/100) - ((t_temp)/100)) '")']);
        fprintf(fp,'%s\r\n',['myArray.insert("' num2str(0) '")']);
        fprintf(fp,'%s\r\n','For each, value in myArray');
        fprintf(fp,'%s\r\n','send, %value% {Tab}');
        fprintf(fp,'%s\r\n','Loop, 9');
        fprintf(fp,'%s\r\n','{');
        fprintf(fp,'%s\r\n','send, +{Tab}');
        fprintf(fp,'%s\r\n','}');
        i = i+1;
    end
    fprintf(fp,'%s\r\n','send, {Down} {Tab}');
end
fprintf(fp,'%s\r\n','exitapp');
fprintf(fp,'%s\r\n','return');
fclose(fp);
end