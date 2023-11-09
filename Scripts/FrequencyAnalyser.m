NSignal = length(Signal);
NWindow = floor(2*Fs/(SpectralResolution));
NOverlap = floor(NWindow * (Overlap / 100) );
NFFT = max(256,2^nextpow2(NWindow));

if windowType == "rect"
    windowedSignal = Signal;
elseif windowType == "hann"
    windowedSignal = Signal.*hann(length(Signal));
elseif windowType == "hamming"
    windowedSignal = Signal.*hamming(length(Signal));
end

FFTSignal = fft(windowedSignal);
[SSpectrogram, FSpectrogram, TSpectrogram] = ...
        spectrogram(Signal,'yaxis',hann(NWindow),NOverlap,NFFT);
