%axisTypeX
%axisTypeY
%xLimTime
%yLimTime
%xLimFrequency
%yLimFrequency
%xLimFrequencyCopy
%testing
% fs = 10000;             % sampling frequency
% T = 1;   % duration in time (which we'll calculate below to check)
% A = 1;
% freq = 500;
% phas = 0;
% [time_vector, signal] = generate_sin(fs,T,A,freq,phas);
% axisTypeX = "l";
% axisTypeY = "log";
% xLimTime = [0,1];
% yLimTime = [-2,2];
% xLimFrequency = [0,fs/2];
% yLimFrequency = [0,200];
% a = [1 10];
% b = [2 10 100];
% sysTF=tf(a,b);
% FFTSignal = fft(signal);

%Frequency plots
delta_f = fs/2 / length(FFTSignal);
freq_vector = delta_f:delta_f:fs/2;      % we'll hit fs/2

%Time plots
time_signal = signal;
if axisTypeX == "log"
    time_signal = 20*log10(signal);
end
TimePlot = figure("Units", "centimeters", ...
           "Position", [0, 0, 15, 10], ...
           "PaperSize", [15 10]);
grid on
hold on;
plot(time_vector, time_signal);
xlim(xLimTime);
ylim(yLimTime);
title TimeSignal;
TimePlot.Visible = "Off";
hold off;

%"ImpResp"
ImpulseResponsePlot = figure("Units", "centimeters", ...
                             "Position", [0, 0, 15, 10], ...
                             "PaperSize", [15 10]);
hold on;
%plot(time_vector,impulse(sysTF));
impulse(sysTF);
impulseresponseplot = gca;
xlim(xLimTime);
ylim(yLimTime);
title "ImpulseResponse";
ImpulseResponsePlot.Visible = "off";
hold off;

%"BodePLot"
BodePlot = figure("Units", "centimeters", ...
                  "Position", [0, 0, 15, 10], ...
                  "PaperSize", [15 10]);
opt = bodeoptions;
opt.Grid = 'on';
if axisTypeX == "lin"
    opt.FreqScale = 'Linear';
else
end
hold on;
title BodePlot;
bode(sysTF,opt,{xLimFrequency(1),xLimFrequency(2)});
BodePlot.Visible = "off";
hold off;

%"RealImg"
RIFFTPlot = figure("Units", "centimeters", ...
                   "Position", [0, 0, 15, 10], ...
                   "PaperSize", [15 10]);
hold on;
title "ComplexFFT";
if axisTypeX == "lin"
    if axisTypeY == "lin"
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
    elseif axisTypeY == "log"
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
    end
elseif axisTypeX == "log"
    if axisTypeY == "lin"
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
    elseif axisTypeY == "log"
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
        subtitle "Imaginary";
    end
end
RIFFTPlot.Visible = "on";
hold off;

%FFT
FFTPlot = figure("Units", "centimeters", ...
                 "Position", [0, 0, 15, 10], ...
                 "PaperSize", [15 10]);
if axisTypeX == "lin"
    if axisTypeY == "lin"
        hold on;
        title "FFT";
        plot(freq_vector, FFTSignal);
        xlim(xLimFrequency);
        ylim(yLimFrequency);
        grid on
    elseif axisTypeY == "log"
        hold on;
        title "FFT";
        plot(freq_vector, 20*log10(FFTSignal));
        xlim(xLimFrequency);
        ylim(yLimFrequency);
        grid on
    end
elseif axisTypeX == "log"
    if axisTypeY == "lin"
        hold on;
        title "FFT";
        semilogx(freq_vector, FFTSignal);
        xlim(xLimFrequency);
        ylim(yLimFrequency);
        grid on
    elseif axisTypeY == "log"
        hold on;
        title "FFT";
        semilogx(freq_vector, 20*log10(FFTSignal));
        xlim(xLimFrequency);
        ylim(yLimFrequency);
        grid on
    end
end
FFTPlot.Visible = "off";
hold off;

%"PoleZero"
PoleZeroPlot = figure("Units", "centimeters", ...
                      "Position", [0, 0, 15, 10], ...
                      "PaperSize", [15 10]);
hold on
pzplot(sysTF)
PZplot = gca;
title Pole-Zero Plot
grid on
PoleZeroPlot.Visible = "off";
hold off
% 

function [time_vector, signal] = generate_sin(fs,T_tot, A, freq, phas)
    time_vector = 1/fs:1/fs:T_tot;
    signal = A*sin(2*pi*freq*time_vector+2*pi*phas);
end

