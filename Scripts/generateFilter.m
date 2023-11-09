
%% Script to generdenome filter based on given specs
% run('Scripts/generateFilter.m');

%Requires set variables:
%   responseType = whether the filter is IIR or FIR, either "fir" or "iir"
%   approxMethod = approximation method, either "butterworth", "chebychevI", "chebychevII", "cauer"
%   filterOrder = filter order
%   filterType = filter type, either "lp", "hp", "bp", "bs"
%   cutoff = cutoff frequencies, array of up to two values
%   xLimFrequency = frequency limit for normalizing cutoff frequency
%   fs = sampling frequency
%   signal = signal to be filtered

%Asserts new variables:
%  Output = the filtered signal

%Define type
if filterType == "lp"
    ftype = 'low';
elseif filterType == "hp"
    ftype = 'high';
elseif filterType == "bp"
    ftype = 'bandpass';
elseif filterType == "bs"
    ftype = 'stop';
end

%Define ripple thresholds
Rs = 32;
Rp = 0.2;

%Define filter from type
if approxMethod == "butterworth"
    [num, denom] = butter(filterOrder, cutoff/xLimFrequency, ftype);
elseif approxMethod == "chebychevI"
    [num, denom] = cheby1(filterOrder, Rp, cutoff/xLimFrequency, ftype);
elseif approxMethod == "chebychevII"
    [num, denom] = cheby2(filterOrder, Rs, cutoff/xLimFrequency, ftype);
elseif approxMethod == "cauer"
    [num, denom] = ellip(filterOrder, Rp, Rs, cutoff/xLimFrequency, ftype);
end

%Apply response type
if responseType == "fir"
    [h, t] = impz(num, denom, [], fs);
    
    b = [];
    a = 1;
    for i = 1:(filterOrder*10)
    b = [b ; h(floor(length(h)/(filterOrder*10))*i)];
    end
elseif responseType == "iir"
    b = num;
    a = denom;
end

%Filter
output = filter(b, a, signal);
