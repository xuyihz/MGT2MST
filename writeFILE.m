%% function
%
% write FILEstr into a new file
% Xu Yi, 2020

%%
function writeFILE(FILEstr, FILEfilename, prefix, suffix)
for i = 1:length(FILEfilename)
    if strcmp(FILEfilename(end+1-i), '\' )
        prefixStart = length(FILEfilename)+1-i;
        break
    end
end
newFILEfilename = [ FILEfilename(1:prefixStart), prefix,...
    FILEfilename(prefixStart+1:end-4), suffix, '.mgt' ];
fileID = fopen(newFILEfilename,'w'); % Open or create new file for writing. Discard existing contents, if any.
for i = 1:length(FILEstr)
    fprintf(fileID, '%s\n', FILEstr(i));
end
fclose('all');
end