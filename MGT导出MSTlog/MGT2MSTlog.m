%% Generate MST log file
% from MGT file exported by 3d3s
% 
% Xu Yi, 2020

%%
close all; clear; clc;
addpath(genpath('F:\MATLAB\MGT2MST')) % 搜索路径中加入文件夹及其下所有文件夹

%% load the mgt & log file
MGTfilename = 'C:\Users\Administrator\Desktop\曲棍球馆x.mgt';
LOGfilename = 'C:\Users\Administrator\Desktop\曲棍球馆x.log';
MGTstr = loadFile2Str(MGTfilename);
LOGstr = loadFile2Str(LOGfilename); LOGstrOriginal = LOGstr;

%% check the format of the selfweight lines
UNITtrans = checkUNIT(MGTstr);

%% get the LOADCASE & Load from mgt file
[LoadCase, Load] = getLoad(MGTstr, UNITtrans);

%% write the LOAD data into LOGstr
LOGstr = addLoadData(LOGstr, LoadCase, Load);

%% write LOGstr into a new log file
prefix = ''; % prefix of the new log file
suffix = '2'; % suffix of the new log file
writeFILE(LOGstr, LOGfilename, prefix, suffix);
