% Load file
FilePath = fullfile('..', "global_specs.txt");
F = fopen(FilePath,"r");

% Get input type
Input = GetNextLine(F);

if Input == "wav"
    % Get filename and it's sampling frequency
    FileName = GetNextLine(F);
    Fs = double(GetNextLine(F));
    GetNextLine(F);GetNextLine(F);GetNextLine(F);
    GetNextLine(F);GetNextLine(F);
else
    % Get signal generator variables
    GetNextLine(F); GetNextLine(F);
    Type = GetNextLine(F);
    Fs = double(GetNextLine(F));
    Ts = double(GetNextLine(F));
    T0 = double(GetNextLine(F));
    Freqs = regexp(GetNextLine(F),', ','split');
    Freqs = double(string(cell2mat(Freqs(:))));
end

% Frequency analysis
SpectralResolution = double(GetNextLine(F));
WindowType = GetNextLine(F);
Overlap =double(GetNextLine(F));

% Filtering
ResponseType = GetNextLine(F);
FilterOrder = double(GetNextLine(F));
ApproxMethod = GetNextLine(F);
FilterType = GetNextLine(F);
Fb = regexp(GetNextLine(F),', ','split');
Fb = double(string(cell2mat(Fb(:))));

% Plotting
XLimTime = zeros(2,1);
YLimTime = zeros(2,1);
XLimTime(2) = double(GetNextLine(F));
YLimTime(2) = double(GetNextLine(F));
YLimTime(1) = -YLimTime(2);
AxisTypeX = GetNextLine(F);
AxisTypeY = GetNextLine(F);
XLimFrequency = zeros(2,1);
YLimFrequency = zeros(2,1);
XLimFrequencyCopy = GetNextLine(F);

if XLimFrequencyCopy == "nyquist"
    XLimFrequency(2) = Fs/2;
else
    XLimFrequency(2) = double(XLimFrequencyCopy);
end

YLimFrequency(2) = double(GetNextLine(F));
YLimFrequency(1) = -YLimFrequency(2);

fclose(F);

function L = GetNextLine(F)
    L = fgetl(F);
    while L(1) == "%"
        L = fgetl(F);
    end
    L = string(L);
end