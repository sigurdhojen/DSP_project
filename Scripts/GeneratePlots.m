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
SysTF = tf(num, denom);
DeltaF = Fs/2 / length(FFTSignal);
FreqVector = DeltaF:DeltaF:Fs/2;      % we'll hit fs/2

%Time plots
TimePlot = figure("Units", "centimeters", ...
                  "Position", [0, 0, 15, 10], ...
                  "PaperSize", [15 10]);
grid on
hold on;
plot(TimeVector, Signal, TimeVector, Output);
xlim(XLimTime);
ylim(YLimTime);
title TimeSignal;
TimePlot.Visible = "Off";
hold off;

%"ImpResp"
ImpulseResponsePlot = figure("Units", "centimeters", ...
                             "Position", [0, 0, 15, 10], ...
                             "PaperSize", [15 10]);
hold on;
if ResponseType == "iir"
    impz(num, denom);
elseif ResponseType == "fir"
    stem(h);
end

title "ImpulseResponse";
ImpulseResponsePlot.Visible = "off";
hold off;

%"BodePLot"
BodePlot = figure("Units", "centimeters", ...
                  "Position", [0, 0, 15, 10], ...
                  "PaperSize", [15 10]);
hold on;
title BodePlot;

if ResponseType == "iir"
     Options = bodeoptions;
     Options.Grid = 'on';
    if AxisTypeX == "lin"
        Options.FreqScale = 'Linear';
    end
     bode(SysTF,Options,{XLimFrequency(1),XLimFrequency(2)});
elseif ResponseType == "fir"
     %freqz(h,1,526,Fs);
     %if AxisTypeX == "log"
     %   ax = findall(gcf, 'Type', 'axes');
     %   set(ax, 'XScale', 'log')
     %end
     [FreqzResonse,FreqzFrequency] = freqz(h,1,[],Fs);
     subplot(2,1,1)
     if AxisTypeX == "log"
        semilogx(FreqzFrequency,20*log10(abs(FreqzResonse)))
     else
        plot(FreqzFrequency,20*log10(abs(FreqzResonse)))
     end
     xlabel('Frequency [Hz]');
     ylabel('Gain [dB]');
     subplot(2,1,2)
     if AxisTypeX == "log"
        semilogx(FreqzFrequency,unwrap(angle(FreqzResonse))*180/pi)
     else
        plot(FreqzFrequency,unwrap(angle(FreqzResonse))*180/pi)
     end
     xlabel('Frequency [Hz]');
     ylabel('Gain [dB]');
end

BodePlot.Visible = "off";
hold off;

% RealImg
RIFFTPlot = figure("Units", "centimeters", ...
                   "Position", [0, 0, 15, 10], ...
                   "PaperSize", [15 10]);
hold on;
title "ComplexFFT";
if AxisTypeX == "lin"
    if AxisTypeY == "lin"
        subplot(2,1,1)
        plot(FreqVector, real(FFTSignal));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        grid on
        subtitle "Reals";
        subplot(2,1,2)
        plot(FreqVector, imag(FFTSignal));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        grid on
        subtitle "Imaginary";
    elseif AxisTypeY == "log"
        subplot(2,1,1)
        plot(FreqVector, 20*log10(abs(real(FFTSignal))));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        grid on
        subtitle "Reals";
        subplot(2,1,2)
        plot(FreqVector, 20*log10(abs(imag(FFTSignal))));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        grid on
        subtitle "Imaginary";
    end
elseif AxisTypeX == "log"
    if AxisTypeY == "lin"
        subplot(2,1,1)
        semilogx(FreqVector, real(FFTSignal));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        grid on
        subtitle "Reals";
        subplot(2,1,2)
        semilogx(FreqVector, imag(FFTSignal));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        grid on
        subtitle "Imaginary";
    elseif AxisTypeY == "log"
        subplot(2,1,1)
        semilogx(FreqVector, 20*log10(abs(real(FFTSignal))));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        grid on
        subtitle "Reals";
        subplot(2,1,2)
        semilogx(FreqVector, 20*log10(abs(imag(FFTSignal))));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        subtitle "Imaginary";
    end
end
RIFFTPlot.Visible = "off";
hold off;

% FFT
FFTPlot = figure("Units", "centimeters", ...
                 "Position", [0, 0, 15, 10], ...
                 "PaperSize", [15 10]);
hold on;
title "FFT";
if AxisTypeX == "lin"
    if AxisTypeY == "lin"
        subplot(2,1,1)
        plot(FreqVector, abs(FFTSignal));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        grid on;
        subplot(2,1,2)
        plot(FreqVector, abs(FFTOutput));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        grid on;
    elseif AxisTypeY == "log"
        subplot(2,1,1)
        plot(FreqVector, 20*log10(abs(FFTSignal)));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        grid on;
        subplot(2,1,2)
        plot(FreqVector, 20*log10(abs(FFTOutput)));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        grid on;
    end
elseif AxisTypeX == "log"
    if AxisTypeY == "lin"
        subplot(2,1,1)
        plot(FreqVector, abs(FFTSignal));
        set(gca, 'xScale', 'log')
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        grid on;
        subplot(2,1,2)
        plot(FreqVector, abs(FFTOutput));
        set(gca, 'xScale', 'log')
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        grid on;
    elseif AxisTypeY == "log"
        subplot(2,1,1)
        plot(FreqVector, 20*log10(abs(FFTSignal)));
        set(gca, 'xScale', 'log')
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        grid on;
        subplot(2,1,2)
        plot(FreqVector, 20*log10(abs(FFTOutput)));
        set(gca, 'xScale', 'log')
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        grid on;
    end
end
FFTPlot.Visible = "off";
hold off;

% PoleZero
PoleZeroPlot = figure("Units", "centimeters", ...
                      "Position", [0, 0, 15, 10], ...
                      "PaperSize", [15 10]);
hold on
pzplot(SysTF)
title Pole-Zero Plot
grid on
PoleZeroPlot.Visible = "off";
hold off

% Spectrogram
SpectrogramPlot = figure("Units", "centimeters", ...
                         "Position", [0, 0, 15, 10], ...
                         "PaperSize", [15 10]);
hold on
nexttile
mesh(SpectrogramT, SpectrogramF, abs(SpectrogramS).^2);
view(2), axis tight
title Spectrogram
SpectrogramPlot.Visible = "off";
hold off