% Test signal
% Fs = 10e3;
% T = 0:1/Fs:4;
% Signal = vco(sin(2*pi*T),[0.1 0.4]*Fs,Fs);

NSignal = length(Signal);
NWindow = floor(2*Fs/100); % 100 Hz spectral resolution for STFT
NOverlap = floor(NWindow * (Overlap / 100) );
NFFT = max(256,2^nextpow2(NWindow));

% Cut or zeropad signal
NRequired = floor((Fs)/SpectralResolution);

if NSignal >= NRequired
    FFTSignal = Signal(1:NRequired);
    FFTOutput = Output(1:NRequired);
else
    FFTSignal = [Signal(1:end), zeros(1,NRequired-NSignal)];
    FFTOutput = [Output(1:end), zeros(1,NRequired-NSignal)];
end

if WindowType == "hann"
    FFTSignal = FFTSignal.*hann(length(FFTSignal));
    FFTOutput = FFTOutput.*hann(length(FFTOutput));
    Window = hann(NWindow);
elseif WindowType == "hamming"
    FFTSignal = FFTSignal.*hamming(length(FFTSignal));
    FFTOutput = FFTOutput.*hamming(length(FFTOutput));
    Window = hamming(NWindow);
else
    Window = rectwin(NWindow);
end

% Make onesided FFT
FFTSignal = fft(FFTSignal);
FFTSignal = FFTSignal(1:length(FFTSignal)/2+1);
FFTSignal(2:end) = 2*FFTSignal(2:end);

FFTOutput = fft(FFTOutput);
FFTOutput = FFTOutput(1:length(FFTOutput)/2+1);
FFTOutput(2:end) = 2*FFTOutput(2:end);

% Moved to GeneratePlots
%[SpectrogramS, SpectrogramF, SpectrogramT] = ...
%        spectrogram(Signal, Window, NOverlap, NFFT, Fs, "yaxis");
