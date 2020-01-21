%% function
% get the LOADCASE & Load from mgt file
%
% Xu Yi, 2020

%%
function [LoadCase, Load] = getLoad(MGTstr, UNITtrans)
LoadCase = [];
Load = [];
i = find1Word(MGTstr, '*STLDCASE', 1);
char1 = ' ';
Word2 = ' ';
D = 'D'; L = 'L'; W = 'W';
Dname = []; Lname = []; Wname = [];
while char1 ~= '*'
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

i = 1; % line index
while i ~= length(MGTstr)
    i = find1Word(MGTstr, '*USE-STLD,', i);
    Word2 = strSplit(MGTstr, i, 2);
    j = 1;
    while ~strcmp( Word2, LoadCase(j,2) )
        j = j+1;
    end
    i = find1Word(MGTstr, '*CONLOAD', i);
    char1 = ' ';
    while char1 ~= '*' % '*' is the head of next part
        char1 = str2char1(i, MGTstr);
        if char1 == ';' || isempty(char1)
            i = i+1;
        else
            NLstr = split( MGTstr(i) );
            for NLi = 1:length(NLstr)
                NLstrTemp = NLstr(NLi);
                NLstr(NLi) = NLstrTemp(1:(end-1)); % dump the last ','
            end
            NLstr = str2double(NLstr);
            NLstr(2:end) = NLstr(2:end) * UNITtrans;
            LoadTemp = [LoadTemp; NLstr];
            i = i+1;
        end
    end
    Load(j,:) = LoadTemp;
end
end
