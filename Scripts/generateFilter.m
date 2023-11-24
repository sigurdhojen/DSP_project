
%% Script to generdenome filter based on given specs
% run('Scripts/generateFilter.m');

%Requires set variables:
%   ResponseType = whether the filter is IIR or FIR, either "fir" or "iir"
%   ApproxMethod = approximation method, either "butterworth", "chebychevI", "chebychevII", "cauer"
%   FilterOrder = filter order
%   FilterType = filter type, either "lp", "hp", "bp", "bs"
%   Fb = cutoff frequencies, array of up to two values
%   XLimFrequency = frequency limit for normalizing cutoff frequency
%   Fs = sampling frequency
%   Signal = signal to be filtered

%Asserts new variables:
%  Output = the filtered signal

%Define type
if FilterType == "lp"
    ftype = 'low';
elseif FilterType == "hp"
    ftype = 'high';
elseif FilterType == "bp"
    ftype = 'bandpass';
elseif FilterType == "bs"
    ftype = 'stop';
end

%Define ripple thresholds
Rs = 32;
Rp = 0.2;

%Define filter from type
if ResponseType == "fir"
    nFilter = 15;
elseif ResponseType == "iir"
    nFilter = FilterOrder;
end

if ApproxMethod == "butterworth"
    [num, denom] = butter(nFilter, Fb/XLimFrequency(2), ftype);
elseif ApproxMethod == "chebychevI"
    [num, denom] = cheby1(nFilter, Rp, Fb/XLimFrequency(2), ftype);
elseif ApproxMethod == "chebychevII"
    [num, denom] = cheby2(nFilter, Rs, Fb/XLimFrequency(2), ftype);
elseif ApproxMethod == "cauer"
    [num, denom] = ellip(nFilter, Rp, Rs, Fb/XLimFrequency(2), ftype);
end

%Apply response type and filter
if ResponseType == "fir"
    [h,~] = impz(num, denom, ceil(FilterOrder/2));
    h = [flip(h(1+mod(FilterOrder,2):end)); h];
    Output = conv(h, Signal);
    Output = Output(1:length(Signal));
elseif ResponseType == "iir"
    Output = filter(num, denom, Signal);
end


