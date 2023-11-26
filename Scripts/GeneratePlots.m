% Make frequency vector for FFT
DeltaF = Fs/2 / length(FFTSignal);
FreqVector = DeltaF:DeltaF:Fs/2;      % we'll hit fs/2

% Time plot
TimePlot = figure("Units", "centimeters", ...
                  "Position", [0, 0, 15, 10], ...
                  "PaperSize", [15 10]);
hold on;
grid on;
plot(TimeVector, Signal, TimeVector, Output);
xlim(XLimTime);
ylim(YLimTime);
xlabel('Time [s]');
ylabel('Amplitude');
legend('Input Signal','Output Signal');
title('Signals in Time');
TimePlot.Visible = "Off";
hold off;

% Impulse Response Plot
ImpulseResponsePlot = figure("Units", "centimeters", ...
                             "Position", [0, 0, 15, 10], ...
                             "PaperSize", [15 10]);
hold on;

if ResponseType == "iir"
    impz(num, denom);
elseif ResponseType == "fir"
    stem(h, "filled");
    xlabel('n (samples)');
    ylabel('Amplitude');
end

title('Filter Impulse Response');
ImpulseResponsePlot.Visible = "off";
hold off;

% BodePlot
BodePlot = figure("Units", "centimeters", ...
                  "Position", [0, 0, 15, 10], ...
                  "PaperSize", [15 10]);
hold on;

if ResponseType == "iir"
     [FreqzResonse,FreqzFrequency] = freqz(num,denom,[],Fs);

     subplot(2,1,1)
     if AxisTypeX == "log"
        semilogx(FreqzFrequency,20*log10(abs(FreqzResonse)))
     else
        plot(FreqzFrequency,20*log10(abs(FreqzResonse)))
     end
     title('BodePlot of Filter');
     xlim(XLimFrequency)
     xlabel('Frequency [Hz]');
     ylabel('Magnitude [dB]');

     subplot(2,1,2)
     if AxisTypeX == "log"
        semilogx(FreqzFrequency,unwrap(angle(FreqzResonse))*180/pi)
     else
        plot(FreqzFrequency,unwrap(angle(FreqzResonse))*180/pi)
     end
     xlim(XLimFrequency)
     xlabel('Frequency [Hz]');
     ylabel('Phase [Degree]');
elseif ResponseType == "fir"
     [FreqzResonse,FreqzFrequency] = freqz(h,1,[],Fs);

     subplot(2,1,1)
     if AxisTypeX == "log"
        semilogx(FreqzFrequency,20*log10(abs(FreqzResonse)))
     else
        plot(FreqzFrequency,20*log10(abs(FreqzResonse)))
     end
     title('BodePlot of Filter');
     xlim(XLimFrequency)
     xlabel('Frequency [Hz]');
     ylabel('Magnitude [dB]');

     subplot(2,1,2)
     if AxisTypeX == "log"
        semilogx(FreqzFrequency,unwrap(angle(FreqzResonse))*180/pi)
     else
        plot(FreqzFrequency,unwrap(angle(FreqzResonse))*180/pi)
     end
     xlim(XLimFrequency)
     xlabel('Frequency [Hz]');
     ylabel('Phase [Degree]');
end

BodePlot.Visible = "off";
hold off;

% Real- and Imaginary part of FFT before and after filtering
RIFFTPlot = figure("Units", "centimeters", ...
                   "Position", [0, 0, 15, 10], ...
                   "PaperSize", [15 10]);
hold on;
if AxisTypeX == "lin"
    if AxisTypeY == "lin"
        subplot(2,2,1)
        plot(FreqVector, real(FFTSignal));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        xlabel('Frequency [Hz]');
        ylabel('Amplitude');
        grid on
        title('FFT of Input Signal');
        subtitle('Real Part');

        subplot(2,2,2)
        plot(FreqVector, real(FFTOutput));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        xlabel('Frequency [Hz]');
        ylabel('Amplitude');
        grid on
        title('FFT of Output Signal');
        subtitle('Real Part');

        subplot(2,2,3)
        plot(FreqVector, imag(FFTSignal));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        xlabel('Frequency [Hz]');
        ylabel('Amplitude');
        grid on
        subtitle('Imaginary Part');

        subplot(2,2,4)
        plot(FreqVector, imag(FFTOutput));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        xlabel('Frequency [Hz]');
        ylabel('Amplitude');
        grid on
        subtitle('Imaginary Part');
    elseif AxisTypeY == "log"
        subplot(2,2,1)
        plot(FreqVector, 20*log10(abs(real(FFTSignal))));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        xlabel('Frequency [Hz]');
        ylabel('Amplitude [dB]');
        grid on
        title('FFT of Input Signal');
        subtitle('Real Part');

        subplot(2,2,2)
        plot(FreqVector, 20*log10(abs(real(FFTOutput))));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        xlabel('Frequency [Hz]');
        ylabel('Amplitude [dB]');
        grid on
        title('FFT of Output Signal');
        subtitle('Real Part');

        subplot(2,2,3)
        plot(FreqVector, 20*log10(abs(imag(FFTSignal))));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        xlabel('Frequency [Hz]');
        ylabel('Amplitude [dB]');
        grid on
        subtitle('Imaginary Part');

        subplot(2,2,4)
        plot(FreqVector, 20*log10(abs(imag(FFTOutput))));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        xlabel('Frequency [Hz]');
        ylabel('Amplitude [dB]');
        grid on
        subtitle('Imaginary Part');
    end
elseif AxisTypeX == "log"
    if AxisTypeY == "lin"
        subplot(2,2,1)
        semilogx(FreqVector, real(FFTSignal));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        xlabel('Frequency [Hz]');
        ylabel('Amplitude');
        grid on
        title('FFT of Input Signal');
        subtitle('Real Part');

        subplot(2,2,2)
        semilogx(FreqVector, real(FFTOutput));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        xlabel('Frequency [Hz]');
        ylabel('Amplitude');
        grid on
        title('FFT of Output Signal');
        subtitle('Real Part');

        subplot(2,2,3)
        semilogx(FreqVector, imag(FFTSignal));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        xlabel('Frequency [Hz]');
        ylabel('Amplitude');
        grid on
        subtitle('Imaginary Part');

        subplot(2,2,4)
        semilogx(FreqVector, imag(FFTOutput));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        xlabel('Frequency [Hz]');
        ylabel('Amplitude');
        grid on
        subtitle('Imaginary Part');
    elseif AxisTypeY == "log"
        subplot(2,2,1)
        semilogx(FreqVector, 20*log10(abs(real(FFTSignal))));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        xlabel('Frequency [Hz]');
        ylabel('Amplitude [dB]');
        grid on
        title('FFT of Input Signal');
        subtitle('Real Part');

        subplot(2,2,2)
        semilogx(FreqVector, 20*log10(abs(real(FFTOutput))));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        xlabel('Frequency [Hz]');
        ylabel('Amplitude [dB]');
        grid on
        title('FFT of Input Signal');
        subtitle('Real Part');

        subplot(2,2,3)
        semilogx(FreqVector, 20*log10(abs(imag(FFTSignal))));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        xlabel('Frequency [Hz]');
        ylabel('Amplitude [dB]');
        grid on
        subtitle('Imaginary Part');

        subplot(2,2,4)
        semilogx(FreqVector, 20*log10(abs(imag(FFTOutput))));
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        xlabel('Frequency [Hz]');
        ylabel('Amplitude [dB]');
        grid on
       subtitle('Imaginary Part');
    end
end
RIFFTPlot.Visible = "off";
hold off;

% FFT
FFTPlot = figure("Units", "centimeters", ...
                 "Position", [0, 0, 15, 10], ...
                 "PaperSize", [15 10]);
hold on;
if AxisTypeX == "lin"
    if AxisTypeY == "lin"
        subplot(2,1,1)
        plot(FreqVector, abs(FFTSignal));
        title('FFT of Input Signal');
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        xlabel('Frequency [Hz]');
        ylabel('Amplitude');
        grid on;

        subplot(2,1,2)
        plot(FreqVector, abs(FFTOutput));
        title('FFT of Output Signal');
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        xlabel('Frequency [Hz]');
        ylabel('Amplitude');
        grid on;
    elseif AxisTypeY == "log"
        subplot(2,1,1)
        plot(FreqVector, 20*log10(abs(FFTSignal)));
        title('FFT of Input Signal');
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        xlabel('Frequency [Hz]');
        ylabel('Amplitude [dB]');
        grid on;

        subplot(2,1,2)
        plot(FreqVector, 20*log10(abs(FFTOutput)));
        title('FFT of Output Signal');
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        xlabel('Frequency [Hz]');
        ylabel('Amplitude [dB]');
        grid on;
    end
elseif AxisTypeX == "log"
    if AxisTypeY == "lin"
        subplot(2,1,1)
        plot(FreqVector, abs(FFTSignal));
        set(gca, 'xScale', 'log')
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        xlabel('Frequency [Hz]');
        ylabel('Amplitude');
        title('FFT of Input Signal');
        grid on;

        subplot(2,1,2)
        plot(FreqVector, abs(FFTOutput));
        set(gca, 'xScale', 'log')
        xlabel('Frequency [Hz]');
        ylabel('Amplitude');
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        title('FFT of Output Signal');
        grid on;
    elseif AxisTypeY == "log"
        subplot(2,1,1)
        plot(FreqVector, 20*log10(abs(FFTSignal)));
        set(gca, 'xScale', 'log')
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        xlabel('Frequency [Hz]');
        ylabel('Amplitude [dB]');
        title('FFT of Input Signal');
        grid on;

        subplot(2,1,2)
        plot(FreqVector, 20*log10(abs(FFTOutput)));
        set(gca, 'xScale', 'log')
        xlim(XLimFrequency);
        ylim(YLimFrequency);
        xlabel('Frequency [Hz]');
        ylabel('Amplitude [dB]');
        title('FFT of Output Signal');
        grid on;
    end
end
FFTPlot.Visible = "off";
hold off;

% PoleZero
PoleZeroPlot = figure("Units", "centimeters", ...
                      "Position", [0, 0, 15, 10], ...
                      "PaperSize", [15 10]);
hold on;
zplane(num, denom);
if ResponseType == "fir"
    title('Pole-Zero Plot of Prototype Filter');
else
    title('Pole-Zero Plot');
end
PoleZeroPlot.Visible = "off";
hold off;

% Spectrogram
SpectrogramPlot = figure("Units", "centimeters", ...
                         "Position", [0, 0, 15, 10], ...
                         "PaperSize", [15 10]);
hold on;
spectrogram(Signal, Window, NOverlap, NFFT, Fs, "yaxis");
title('Spectrogram');
SpectrogramPlot.Visible = "off";
hold off;