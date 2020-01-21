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
    i = find1Word(LOGstr, '##', i);
    i = i+1;
    Word1 = strSplit(LOGstr, i, 1);
    char2 = Word1(2); % D / L / W
    indexLCStart = 1;
    while char2 ~= LoadCase(indexLCStart,1)
        indexLCStart = indexLCStart+1;
    end
    indexLCEnd = indexLCStart;
    while char2 == LoadCase(indexLCEnd,1)
        indexLCEnd = indexLCEnd+1;
    end
    indexLCEnd = indexLCEnd-1;
    for j = indexLCStart:indexLCEnd
        if char2 == LoadCase(1,1) % DeadLoad has no indexLoad
            indexLoad = '';
        else
            indexLoadTemp = j - indexLCStart + 1;
            indexLoad = int2str(indexLoadTemp);
        end
        for k = 1:length(Load(j,:))
            LoadLOGstr(k,1) = sprintf("%s%s%d%s%f%s%f%s%f%s%f%s%f%s%f",...
                indexLoad,blank,... % index in specific Load
                Load(j,k,1),blank,... % Node index
                Load(j,k,2),blank,Load(j,k,3),blank,Load(j,k,4),blank,...
                Load(j,k,5),blank,Load(j,k,6),blank,Load(j,k,7));...
                % Load, x/y/z/mx/my/mz
        end
        LOGstr = [ LOGstr(1:i); LoadLOGstr; LOGstr(i+1:end) ];
        i = i + length(LoadLOGstr);
    end
end
end
