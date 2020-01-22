%% function
% write the LOAD data into LOGstr
%
% Xu Yi, 2020

%%
function LOGstr = addLoadData(LOGstr, LoadCase, Load)
% LoadCase = [LoadCase; X,Xname(i)];
% Load(j,:) = LoadTemp;
blank = '        ';
i = 1; % line index
while i ~= length(LOGstr)
    WordSuffix = ' ';
    while  ~strcmp( WordSuffix, 'LOAD') % identify LOAD part
        i = find1Word(LOGstr, '##', i);
        if i == length(LOGstr)
            break
        end
        i = i+1;
        Word1 = strSplit(LOGstr, i, 1);
        Word1 = char(Word1);
        if length(Word1) < 9
            WordSuffix = ' ';
        else
            WordSuffix = Word1(6:9); % magic line
        end
    end
    char2 = Word1(2); % D / L / W
    indexLCStart = 1;
    flag = 0;
    while ~strcmp(char2, LoadCase(indexLCStart,1))
        indexLCStart = indexLCStart+1;
        if indexLCStart > length(LoadCase)
            flag = 1; % magic line
            break
        end
    end
    if flag == 1
       break 
    end
    indexLCEnd = indexLCStart;
    while strcmp(char2, LoadCase(indexLCEnd,1))
        indexLCEnd = indexLCEnd+1;
        if indexLCEnd > length(LoadCase)
            break
        end
    end
    indexLCEnd = indexLCEnd-1;
    for j = indexLCStart:indexLCEnd
        if char2 == LoadCase(1,1) % DeadLoad has no indexLoad
            indexLoad = '';
        else
            indexLoadTemp = j - indexLCStart + 1;
            indexLoad = int2str(indexLoadTemp);
        end
        LoadTemp = Load{j};
        for k = 1:length(LoadTemp)
            LoadLOGstr(k,1) = sprintf("%s%s%d%s%f%s%f%s%f%s%f%s%f%s%f",...
                indexLoad,blank,... % index in specific Load
                LoadTemp(k,1),blank,... % Node index
                LoadTemp(k,2),blank,LoadTemp(k,3),blank,LoadTemp(k,4),blank,...
                LoadTemp(k,5),blank,LoadTemp(k,6),blank,LoadTemp(k,7));...
                % Load, x/y/z/mx/my/mz
        end
        LOGstr = [ LOGstr(1:i); LoadLOGstr; LOGstr(i+1:end) ];
        i = i + length(LoadLOGstr);
    end
end
end
