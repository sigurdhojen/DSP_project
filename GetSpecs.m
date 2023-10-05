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
ApproxMethod = GetNextLine(F);
filterType = GetNextLine(F);
fb = regexp(GetNextLine(F),', ','split');
fb = double(string(cell2mat(fb(:))));

% Plotting
Xlim = zeros(2,1);
Ylim = zeros(2,1);
Xlim(1) = double(GetNextLine(F));
Ylim(1) = double(GetNextLine(F));
axisTypeX = GetNextLine(F);
axisTypeY = GetNextLine(F);
XlimCopy = GetNextLine(F);

if XlimCopy == "nyquist"
    Xlim(2) = fs/2;
else
    Xlim(2) = double(XlimCopy);
end

Ylim(2) = double(GetNextLine(F));

fclose(F);

function L = GetNextLine(F)
    L = fgetl(F);
    while L(1) == "%"
        L = fgetl(F);
    end
    L = string(L);
end