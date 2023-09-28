% Load file and discard the first line
F = fopen("global_specs.txt","r");

% Get input type
input = GetNextLine(F);

if input == "wav"
    % Get filename and it's sampling frequency
    filename = GetNextLine(F);
    fs = GetNextLine(F);
    GetNextLine(F);GetNextLine(F);GetNextLine(F);GetNextLine(F);GetNextLine(F);
else
    % Get signal generator variables
    GetNextLine(F); GetNextLine(F);
    type = GetNextLine(F);
    fs = GetNextLine(F);
    duration = GetNextLine(F);
    periodicity = GetNextLine(F);
    frequencies = regexp(GetNextLine(F),', ','split');
    frequencies = double(string(cell2mat(frequencies(:))));
end

%Frequency analysis

fclose(F);

function L = GetNextLine(F)
    L = fgetl(F);
    while L(1) == "%"
        L = fgetl(F);
    end
end