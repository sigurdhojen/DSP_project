% Route to Outputs folder
FilePath = fullfile('..', "/Outputs");
cd(FilePath);

FC = [num; denom];
% Save signals and filter coefficients
save('RawData.mat', 'Signal');
save('ProcessedData.mat', 'Output');
save('FilterCoefficients.mat', 'FC');

% Save plots
print(TimePlot, 'TimePlot', '-dpdf', '-fillpage');
print(ImpulseResponsePlot, 'ImpulseResponsePlot', '-dpdf', '-fillpage');
print(BodePlot, 'BodePlot', '-dpdf', '-fillpage');
print(RIFFTPlot, 'RIFFTPlot', '-dpdf', '-fillpage');
print(FFTPlot, 'FFTplot', '-dpdf', '-fillpage');
print(PoleZeroPlot, 'PoleZeroPlot', '-dpdf', '-fillpage');
print(SpectrogramPlot, 'SpectrogramPlot', '-dpdf', '-fillpage');

cd('..');