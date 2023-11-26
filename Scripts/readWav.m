%%Script to read .wav file

%Requires .wav file in current folder and set variables:
%   filename = name of file ending in .wav

%Asserts new variables:
%   signal_read = signal read from .wav file
%   fs_read = sampling frequency of read signal

Path2WAV = fullfile('..', FileName);
[SignalRead, FsRead] = audioread(Path2WAV);

if iscolumn(SignalRead)
    SignalRead = transpose(SignalRead);
end