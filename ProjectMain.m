clear;
run('Scripts/GetSpecs.m');

if Input == "wav"
    run('Scripts/ReadWav.m');
    run('Scripts/ResampleCheck.m');
else
    run('Scripts/GenerateSignal.m');
end

run('Scripts/GenerateFilter.m');
run('Scripts/FrequencyAnalyser.m');
run('Scripts/GeneratePlots.m');
run('Scripts/Export.m');
