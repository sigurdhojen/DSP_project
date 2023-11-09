
type = "noise";
fs = 20000;
T_s = 3;
T_0 = 0.5;
freqs = [5,7];
responseType = "fir";
approxMethod = "butterworth";
filterOrder = 7;
filterType = "lp";
cutoff = [50];
xLimFrequency = fs/2;

run('Scripts/generateSignal.m');

%run('Scripts/generateFilter.m');

figure('Name','Generated Signal')
plot(time_vector, signal)

%figure('Name', 'impz')
%impz(b, a)

%figure('Name', 'freqz')
%freqz(b, a);

%figure('Name','Filtered Signal')
%plot(time_vector, output)


