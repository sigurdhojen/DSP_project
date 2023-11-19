% Test signal
% Fs = 10e3;
% T = 0:1/Fs:4;
% Signal = vco(sin(2*pi*T),[0.1 0.4]*Fs,Fs);

NSignal = length(Signal);
NWindow = floor(2*Fs/100); % 100 Hz spectral resolution for STFT
NOverlap = floor(NWindow * (Overlap / 100) );
NFFT = max(256,2^nextpow2(NWindow));

% Cut or zeropad signal
NRequired = floor((Fs/2)/SpectralResolution);

if NSignal >= NRequired
    FFTSignal = Signal(1:NRequired);
else
    FFTSignal = [Signal(1:end), zeros(1,NRequired-NSignal)];
end

if WindowType == "hann"
    FFTSignal = FFTSignal.*hann(length(FFTSignal));
    Window = hann(NWindow);
elseif WindowType == "hamming"
    FFTSignal = FFTSignal.*hamming(length(FFTSignal));
    Window = hamming(NWindow);
else
    Window = rectwin(NWindow);
end

FFTSignal = fft(FFTSignal);
% F = ( Fs/2/length(FFTSignal) ) : ( Fs/2/length(FFTSignal) ) : ( Fs/2 );
% plot(F,20*log10(FFTSignal));
% xlim([20 Fs/2]);

[SpectrogramS, SpectrogramF, SpectrogramT] = ...
        spectrogram(Signal,'yaxis',Window,NOverlap,NFFT);
