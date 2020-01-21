%% function
% check unit part
% if there is no first word 'N' in the unit part
% UNITtrans is default assigned as 1/1000
% Xu Yi, 2020

%%
function UNITtrans = checkUNIT(MGTstr)
% *UNIT    ; Unit System
% ; FORCE, LENGTH, HEAT, TEMPER
%    N    , MM, J, C
i = find1Word(MGTstr, '*UNIT', 1);
if i == length(MGTstr) % no '*UNIT' in MGTstr
    disp("no '*UNIT' in MGT");
else
    strTempEnd1 = '';
    strTempEnd2 = '';
    while ~strcmp( strTempEnd1, 'N' ) || ~strcmp( strTempEnd2, 'N' )
        i = i+1;
        strTemp = str1Temp(i, MGTstr);
        if isempty(strTemp)
            continue
        elseif strTemp(1) == '*' % no 'N' in the unit part
            break
        else
            strTempEnd1 = strTemp(end);
            if length(strTemp) == 1
                strTempEnd2 = '';
            else
                strTempEnd2 = strTemp(end-1);
            end
        end
    end
end
if strTemp(1) == 'N' % N
    UNITtrans = 1/1000; % N => kN
else % kN <= MST default unit
    UNITtrans = 1;
end
end
