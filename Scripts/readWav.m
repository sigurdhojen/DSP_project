
%%Script to read .wav file

%Requires .wav file in current folder and set variables:
%   filename = name of file ending in .wav

%Asserts new variables:
%   signal_read = signal read from .wav file
%   fs_read = sampling frequency of read signal

path_2_wav = [pwd, filesep];
[signal_read, fs_read] = audioread([path_2_wav, filename]);
