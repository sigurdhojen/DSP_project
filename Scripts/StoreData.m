% Route to Outputs folder
FilePath = fullfile('..', "/Outputs");
cd(FilePath);

% Save signals and filter coefficients
matlab.io.saveVariablesToScript('RawData.m', 'Signal');
matlab.io.saveVariablesToScript('ProcessedData.m', 'Output');
matlab.io.saveVariablesToScript('FilterCoefficients.m', ['num';'denom']);

% Save plots
saveas(TimePlot,            'TimePlot.pdf')
saveas(ImpulseResponsePlot, 'ImpulseResponsePlot.pdf')
saveas(BodePlot,            'BodePlot.pdf')
saveas(RIFFTPlot,           'RIFFTPlot.pdf')
saveas(FFTPlot,             'FFTplot.pdf')
saveas(PoleZeroPlot,        'PoleZeroPlot.pdf')