
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

if type == "rect"
    [time_vector, signal] = generate_rect(T_0, fs, T_s);
elseif type == "tone"
    [time_vector, signal] = generate_sinusoid(freqs(1), fs, T_s);
elseif type == "tone-complex"
    [time_vector, signal] = generate_tone_complex(freqs, fs, T_s);
elseif type == "noise"
    [time_vector, signal] = generate_noise(fs, T_s);
end



%% Functions

function [time_vector, signal] = generate_rect(T_0, fs, T_s)
%fs = sampling frequency in Hz
%T_s = total duration in s
%T_0 = duration of period T0 in s

time_vector = 1/fs:1/fs:T_s;
signal = [];

for i = 1:floor(T_s/T_0)
    square_on = ones(1,floor(fs*T_0/2));
    square = [square_on zero_pad(ceil(fs*T_0/2))];
    signal = [signal square];
end

i = mod(T_s,T_0);

if i < T_0
    square_on = ones(1,i);
    signal = [signal square_on];
else
    square_on = ones(1,fs*T_0/2);
    square = [square_on zero_pad(i - T_0/2)];
    signal = [signal square];
end

end

function [time_vector, signal] = generate_sinusoid(f, fs, T_s)
% f = frequency of sinusoid
% fs = sampling frequency
% T_s = total duration in s

time_vector = 1/fs:1/fs:T_s;
signal = sin(2*pi*f*time_vector);

end

function [time_vector, signal] = generate_tone_complex(freqs, fs, T_s)
% freqs = frequencies of desired sinusoids
% fs = sampling frequency
% T_s = total duration in s

time_vector = 1/fs:1/fs:T_s;

signal = sin(2*pi*freqs(1)*time_vector);
for i = 2:length(freqs)
    signal = signal + sin(2*pi*freqs(i)*time_vector);
end

end

function [time_vector, signal] = generate_noise(fs, T_s)
% fs = sampling frequency
% T_s = total duration in s

time_vector = 1/fs:1/fs:T_s;
signal = rand(1,length(time_vector));

end

function [x] = zero_pad(N)
% N = number of zeroes

x = zeros(1,fix(N));

end