%% function
% get the 1st word in 'i' line of FILEstr.
% 
% Xu Yi, 2020

%%
function stringTemp = str1Temp(i, FILEstr)
stringTemp = sscanf(FILEstr(i),'%s',1);
end
