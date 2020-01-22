%% function
% get the LOADCASE & Load from mgt file
%
% Xu Yi, 2020

%%
function [LoadCase, Load] = getLoad(MGTstr, UNITtrans)
LoadCase = [];
i = find1Word(MGTstr, '*STLDCASE', 1);
char1 = ' ';
Word2 = ' ';
D = 'D'; L = 'L'; W = 'W';
Dname = []; Lname = []; Wname = [];
while ~strcmp( char1, '*')
    Word1 = strSplit(MGTstr, i, 2); % empty blank counts 1?
    Word1 = char(Word1);
    Word1 = Word1(1:(end-1)); % delete ','
    Word1 = string(Word1);
    switch Word2
        case D
            Dname = [Dname, Word1];
        case L
            Lname = [Lname, Word1];
        case W
            Wname = [Wname, Word1];
        otherwise
            
    end
    i = i+1;
    char1 = str2char1(i, MGTstr);
    % charTemp1 = str2char1(i, MGTstr);
    Word2 = strSplit(MGTstr, i, 3);
    % keyWord = strSplit(FILEstr, indexLine, indexWord);
end
for i = 1:length(Dname)
    LoadCase = [LoadCase; D,Dname(i)];
end
for i = 1:length(Lname)
    LoadCase = [LoadCase; L,Lname(i)];
end
for i = 1:length(Wname)
    LoadCase = [LoadCase; W,Wname(i)];
end
% D,L,W

Load = cell(length(LoadCase),1);
i = 1; % line index
while i ~= length(MGTstr)
    i = find1Word(MGTstr, '*USE-STLD,', i);
    if i == length(MGTstr)
        break
    end
    Word2 = strSplit(MGTstr, i, 2);
    j = 1;
    while ~strcmp( Word2, LoadCase(j,2) )
        j = j+1;
    end
    i = find1Word(MGTstr, '*CONLOAD', i);
    i = i+1;
    char1 = ' ';
    LoadTemp = [];
    while char1 ~= '*' % '*' is the head of next part
        char1 = str2char1(i, MGTstr);
        if isempty(char1)
            i = i+1;
        elseif char1 == ';'
            i = i+1;
        else
            NLstr = split( MGTstr(i) );
            NLstr = NLstr(2:(end-1)); % magic line
            for NLi = 1:length(NLstr)
                NLstrTemp = char(NLstr(NLi));
                NLstr(NLi) = string(NLstrTemp(1:(end-1))); % dump the last ','
            end
            NLstr = str2double(NLstr);
            NLstr(2:end) = NLstr(2:end) * UNITtrans;
            LoadTemp = [LoadTemp; NLstr'];
            i = i+1;
        end
    end
    Load{j} = LoadTemp;
end
LCempty = [];
for i = 1:length(LoadCase)
    if isempty(Load{i})
        LCempty = [LCempty, i];
    end
end
for i = 1:length(LCempty)
    temp = LCempty(i);
    LCempty = LCempty-1;
    LoadCase = [LoadCase(1:(temp-1),:); LoadCase((temp+1):end,:)];
    Load = {Load{1:(temp-1)}, Load{(temp+1):end}};
end
end
