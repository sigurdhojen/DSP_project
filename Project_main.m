
clear;

type = "tone-complex";
fs = 20000;
T_s = 0.01;
T_0 = 0.5;
freqs = [1000, 5000, 9000]; %[2500, 7500];
responseType = "fir";
approxMethod = "butterworth";
filterOrder = 5;
filterType = "bp";
cutoff = [2500, 7500];
xLimFrequency = fs/2;

run('Scripts/generateSignal.m');

run('Scripts/generateFilter.m');

figure('Name','Generated Signal')
plot(time_vector, signal)

figure('Name','Filtered Signal')
plot(time_vector, output)

FFT = fft(output);
FFT = FFT/length(FFT);

T0 = length(signal)/fs;
delta_f = 1/T0;

f_pos = 0:delta_f:fs/2;
f_neg = -fs/2+delta_f:delta_f:-delta_f;

freq_vector = [f_pos f_neg];

figure('Name','Linear Signal Spectrum')
subplot(2,1,1)
plot(freq_vector, abs(FFT))
xlim([0, fs/2])
subplot(2,1,2)
plot(freq_vector, angle(FFT))
xlim([0, fs/2])
