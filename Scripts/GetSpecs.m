% Load file and discard the first line
F = fopen("global_specs.txt","r");

% Get input type
input = GetNextLine(F);

if input == "wav"
    % Get filename and it's sampling frequency
    filename = GetNextLine(F);
    fs = double(GetNextLine(F));
    GetNextLine(F);GetNextLine(F);GetNextLine(F);GetNextLine(F);GetNextLine(F);
else
    % Get signal generator variables
    GetNextLine(F); GetNextLine(F);
    type = GetNextLine(F);
    fs = double(GetNextLine(F));
    T_s = double(GetNextLine(F));
    T_0 = double(GetNextLine(F));
    freqs = regexp(GetNextLine(F),', ','split');
    freqs = double(string(cell2mat(freqs(:))));
end

% Frequency analysis
spectralResolution = double(GetNextLine(F));
windowType = GetNextLine(F);
overlap =double(GetNextLine(F));

% Filtering
responseType = GetNextLine(F);
filterOrder = GetNextLine(F);
approxMethod = GetNextLine(F);
filterType = GetNextLine(F);
fb = regexp(GetNextLine(F),', ','split');
fb = double(string(cell2mat(fb(:))));

% Plotting
xLimTime = zeros(2,1);
yLimTime = zeros(2,1);
xLimTime(2) = double(GetNextLine(F));
yLimTime(2) = double(GetNextLine(F));
axisTypeX = GetNextLine(F);
axisTypeY = GetNextLine(F);
xLimFrequency = zeros(2,1);
yLimFrequency = zeros(2,1);
xLimFrequencyCopy = GetNextLine(F);

if xLimFrequencyCopy == "nyquist"
    xLimFrequency(2) = fs/2;
else
    xLimFrequency(2) = double(XlimCopy);
end

yLimFrequency(2) = double(GetNextLine(F));

fclose(F);

function L = GetNextLine(F)
    L = fgetl(F);
    while L(1) == "%"
        L = fgetl(F);
    end
    L = string(L);
end