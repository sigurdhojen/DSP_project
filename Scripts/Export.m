% Route to Outputs folder
FilePath = fullfile('..', "/Outputs");
cd(FilePath);

FC = [num; denom];
% Save signals and filter coefficients
save('RawData.mat', 'Signal');
save('ProcessedData.mat', 'Output');
save('FilterCoefficients.mat', 'FC');

% Save plots
print(TimePlot, 'PlotTime', '-dpdf', '-fillpage');
print(ImpulseResponsePlot, 'PlotImpulseResponse', '-dpdf', '-fillpage');
print(BodePlot, 'PlotBodePlot', '-dpdf', '-fillpage');
print(RIFFTPlot, 'PlotRIFFT', '-dpdf', '-fillpage');
print(FFTPlot, 'PlotFFT', '-dpdf', '-fillpage');
print(PoleZeroPlot, 'PlotPoleZero', '-dpdf', '-fillpage');
print(SpectrogramPlot, 'PlotSpectrogram', '-dpdf', '-fillpage');

cd('..');