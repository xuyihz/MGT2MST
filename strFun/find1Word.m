%% function
% find Word1 in the FILEstr, output the Line index
% Word1 must be the 1st word in the line
% Xu Yi, 2020

%%
function Line = find1Word(FILEstr, Word1, LineStart)
Line = LineStart;
while ~strcmp( str1Temp(Line, FILEstr), Word1) %
    if Line == length(FILEstr) % no Word1 in FILEstr
        break
    end
    Line = Line+1;
end
end
