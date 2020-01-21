%% function
% import file to string-Matrix
%
% Xu Yi, 2020

%%
function FILEstr = loadFile2Str(filename)
i = 1; % initialize
fileID = fopen(filename);

while ~feof(fileID) % Test for end-of-file.
    FILEstr(i,1) = string(fgetl(fileID)); % fgetl Read line from file, discard newline character.
    i = i+1;
end

end