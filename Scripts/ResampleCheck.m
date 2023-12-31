%%Script to check if read .wav file should be resampled based on given
%%sampling frequency

%Requires that readWav.m has been run successfully and set variables:
%   signal_read = signal from .wav file
%   fs_read = original sampling frequency read from .wav file
%   fs = desired sampling frequency of signal

%Asserts new variables:
%   signal = read signal at desired sampling frequency

if FsRead == Fs
    Signal = SignalRead;
else
    Signal = resample(SignalRead, FsRead, Fs);
end

TimeVector = 1/Fs:1/Fs:length(Signal)/Fs;
