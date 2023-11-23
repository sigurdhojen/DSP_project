
%% Script to generate signals based on given specs
% run('Scripts/generateSignal.m');

%Requires set variables:
%   type = signal type, either "rect", "tone", "tone-complex", "noise"
%   fs = sampling frequency of signal
%   T_s = signal duration
%   T_0 = periodicity for rect signal
%   freqs = array of frequencies for tone complex (tone only uses first)

%Asserts new variables:
%   signal = generated signal
%   time_vector = time vector for generated signal

if Type == "rect"
    [TimeVector, Signal] = GenerateRect(T0, Fs, Ts);
elseif Type == "tone"
    [TimeVector, Signal] = GenerateSinusoid(Freqs(1), Fs, Ts);
elseif Type == "tone-complex"
    [TimeVector, Signal] = GenerateToneComplex(Freqs, Fs, Ts);
elseif Type == "noise"
    [TimeVector, Signal] = GenerateNoise(Fs, Ts);
end



%% Functions

function [TimeVector, Signal] = GenerateRect(T0, Fs, Ts)
%fs = sampling frequency in Hz
%T_s = total duration in s
%T_0 = duration of period T0 in s

TimeVector = 1/Fs:1/Fs:Ts;
Signal = [];

for i = 1:floor(Ts/T0)
    SquareOn = ones(1,floor(Fs*T0/2));
    Square = [SquareOn ZeroPad(ceil(Fs*T0/2))];
    Signal = [Signal Square];
end

i = mod(Ts,T0);

if i < T0
    SquareOn = ones(1,Fs*i);
    Signal = [Signal SquareOn];
else
    SquareOn = ones(1,Fs*T0/2);
    Square = [SquareOn ZeroPad(i - T0/2)];
    Signal = [Signal Square];
end

end

function [TimeVector, Signal] = GenerateSinusoid(F, Fs, Ts)
% f = frequency of sinusoid
% fs = sampling frequency
% T_s = total duration in s

TimeVector = 1/Fs:1/Fs:Ts;
Signal = sin(2*pi*F*TimeVector);

end

function [TimeVector, Signal] = GenerateToneComplex(Freqs, Fs, Ts)
% freqs = frequencies of desired sinusoids
% fs = sampling frequency
% T_s = total duration in s

TimeVector = 1/Fs:1/Fs:Ts;

Signal = sin(2*pi*Freqs(1)*TimeVector);
for i = 2:length(Freqs)
    Signal = Signal + sin(2*pi*Freqs(i)*TimeVector);
end

end

function [TimeVector, Signal] = GenerateNoise(Fs, Ts)
% fs = sampling frequency
% T_s = total duration in s

TimeVector = 1/Fs:1/Fs:Ts;
Signal = rand(1,length(TimeVector));

end

function [X] = ZeroPad(N)
% N = number of zeroes

X = zeros(1,fix(N));

end