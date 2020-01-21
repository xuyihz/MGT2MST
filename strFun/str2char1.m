%% function
% get the 1st character in 'i' line of FILEstr.
% 
% Xu Yi, 2020

%%
function charTemp1 = str2char1(i, MGTstr)
charTemp = str1Temp(i, MGTstr);
if isempty(charTemp)
    charTemp1 = [];
else
    charTemp1 = charTemp(1);
end
end
