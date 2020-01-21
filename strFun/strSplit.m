%% function
% get the indexWord word of indexLine line in FILEstr
%
% Xu Yi, 2020

%%
function keyWord = strSplit(FILEstr, indexLine, indexWord)
stringSplit = split( FILEstr(indexLine) );
if length(stringSplit) < indexWord
    keyWord = '';
else
    keyWord = stringSplit(indexWord);
end
end
