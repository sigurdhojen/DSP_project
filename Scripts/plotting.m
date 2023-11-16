%axisTypeX
%axisTypeY
%xLimTime
%yLimTime
%xLimFrequency
%yLimFrequency
%xLimFrequencyCopy
%testing
fs = 10000;             % sampling frequency
T = 1;   % duration in time (which we'll calculate below to check)
A = 1;
freq = 500;
phas = 0;
[time_vector, signal] = generate_sin(fs,T,A,freq,phas);
axisTypeX = "log";
axisTypeY = "log";
xLimTime = [0,0.01];
yLimTime = [0,1];
xLimFrequency = [0,fs/2];
yLimFrequency = [0,200];
a = [2 5 1];
b = [1 3 5];
sysTF=tf(a,b);
FFTSignal = fft(signal);

%Time plots
figure(1);
grid on
hold on;
plot(time_vector, signal);
xlim(xLimTime);
ylim(yLimTime);
title TimeSignal;
hold off;

% %*"MagPhase_TimeDomain"
% hold on;
% title TimeSignal;
% subplot(2,1,1);
% plot(time_vector,20*log10(signal));
% xlim(xLimTime);
% ylim(yLimTime);
% subtitle Magnitude
% subplot(2,1,2);
% plot(time_vector, angle(signal));
% xlim(xLimTime);
% subtitle Phase
% hold off;

%"ImpResp"
figure(2);
hold on;
%plot(time_vector,impulse(sysTF));
impulse(sysTF);
%xlim(xLimTime);
%ylim(yLimTime);
title "ImpulseResponse";
hold off;

%Frequency plots
delta_f = fs/2 / length(FFTSignal);
freq_vector = delta_f:delta_f:fs/2;      % we'll hit fs/2

%"BodePLot"
figure(3);
opt = bodeoptions;
opt.Grid = 'on';
if axisTypeX == "lin"
    opt.FreqScale = 'Linear';
else     
end
hold on;
title BodePlot;
bode(sysTF,opt,{xLimFrequency(1),xLimFrequency(2)});
hold off;

%"RealImg"
% delta_f = fs/2 / length(FFTSignal);
% freq_vector = delta_f:delta_f:fs/2;
figure(4);
if axisTypeX == "lin"
    if axisTypeY == "lin"
        hold on;
        title "TimeSignal";
        subplot(2,1,1)
        plot(freq_vector, real(FFTSignal));
        xlim(xLimFrequency);
        ylim(yLimFrequency);
        grid on
        subtitle "Reals";
        subplot(2,1,2)
        plot(freq_vector, imag(FFTSignal));
        xlim(xLimFrequency);
        ylim(yLimFrequency);
        grid on
        subtitle "Imaginary";
        hold off;
    elseif axisTypeY == "log"
        hold on;
        title "TimeSignal";
        subplot(2,1,1)
        plot(freq_vector, real(20*log10(FFTSignal)));
        xlim(xLimFrequency);
        ylim(yLimFrequency);
        grid on
        subtitle "Reals";
        subplot(2,1,2)
        plot(freq_vector, imag(20*log10(FFTSignal)));
        xlim(xLimFrequency);
        ylim(yLimFrequency);
        grid on
        subtitle "Imaginary";
        hold off;
    end
elseif axisTypeX == "log"
    if axisTypeY == "lin"
        hold on;
        title "TimeSignal";
        subplot(2,1,1)
        semilogx(freq_vector, real(FFTSignal));
        xlim(xLimFrequency);
        ylim(yLimFrequency);
        grid on
        subtitle "Reals";
        subplot(2,1,2)
        semilogx(freq_vector, imag(FFTSignal));
        xlim(xLimFrequency);
        ylim(yLimFrequency);
        grid on
        subtitle "Imaginary";
        hold off;
    elseif axisTypeY == "log"
        hold on;
        title "TimeSignal";
        subplot(2,1,1)
        semilogx(freq_vector, real(20*log10(FFTSignal)));
        xlim(xLimFrequency);
        ylim(yLimFrequency);
        grid on
        subtitle "Reals";
        subplot(2,1,2)
        semilogx(freq_vector, imag(20*log10(FFTSignal)));
        xlim(xLimFrequency);
        ylim(yLimFrequency);
        grid on
        subtitle "Imaginary";
        hold off;
    end
end

%FFT
% delta_f = fs/2 / length(FFTSignal);
% freq_vector = delta_f:delta_f:fs/2;
% logfreq_vector = logspace(delta_f,fs/2,delta_f);
figure(5);
if axisTypeX == "lin"
    if axisTypeY == "lin"
        hold on;
        title "FFT1";
        plot(freq_vector, FFTSignal);
        xlim(xLimFrequency);
        ylim(yLimFrequency);
        grid on
        hold off;
    elseif axisTypeY == "log"
        hold on;
        title "FFT2";
        plot(freq_vector, 20*log10(FFTSignal));
        xlim(xLimFrequency);
        ylim(yLimFrequency);
        grid on
        hold off;
    end
elseif axisTypeX == "log"
    if axisTypeY == "lin"
        hold on;
        title "FFT3";
        semilogx(freq_vector, FFTSignal);
        xlim(xLimFrequency);
        ylim(yLimFrequency);
        grid on
        hold off;
    elseif axisTypeY == "log"
        hold on;
        title "FFT4";
        semilogx(freq_vector, 20*log10(FFTSignal));
        xlim(xLimFrequency);
        ylim(yLimFrequency);
        grid on
        hold off;
    end
end

%"PoleZero"
figure(6);
hold on
pzplot(sysTF)
title Pole-Zero Plot
grid on
hold off
% 
function [time_vector, signal] = generate_sin(fs,T_tot, A, freq, phas)
    time_vector = 1/fs:1/fs:T_tot;
    signal = A*sin(2*pi*freq*time_vector+2*pi*phas);
end

