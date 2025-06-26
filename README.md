# 25hz-DLC-free-behavior-analysis-code

This is basic code to analyze 25hz egg laying tracking using DeepLabCut. It can obviously be used for tracking at other speeds (may need to change some fixed parameters in the code). 

Typical use would be to first assemble the data:

csv{1} = 'fly3_ALL_ffmpegDeepCut_resnet50_GPU_07232019Jul23shuffle1_1030000.csv';
csv{2} = 'fly5_ALL_ffmpegDeepCut_resnet50_GPU_07232019Jul23shuffle1_1030000.csv';
csv{3} = 'fly6_ALL_ffmpegDeepCut_resnet50_GPU_07232019Jul23shuffle1_1030000.csv';
csv{4} = 'fly7_ALL_ffmpegDeepCut_resnet50_GPU_07232019Jul23shuffle1_1030000.csv';
csv{5} = 'fly8_ALL_ffmpegDeepCut_resnet50_GPU_07232019Jul23shuffle1_1030000.csv';
lengths_to_use = [inf,inf,295000,355500, 175200];
[eggs, trx] = assemble_data_global_DLC(csv, egg, 0, 0, 0, 30, inf,lengths_to_use);

The .csv files are output from running DeepLabCut.

Typical DLC models used are:
1) GPU_07232019-Vikram-2019-07-23
2) GPU_07232019-Vikram-2019-07-23_thorax
3) GPU_07232019-Vikram-2019-07-23_thorax_noegg

The models are slightly different in how they annotate positions on the fly body. In the end the 1st model is the one I typically use (iteration 2). I have used model 3 (iteration 8) for speed of the fly using the head position.


This takes the "trx" from Ctrax and a matrix of eggs (each column is filled with the egg-laying frame times of the corresponding fly in trx) and creates a new "trx" as well as a egg" structure. These structures have a lot of parameters about each individual egg that are calculated from the data. 

See "plotting_scripts.m" for unorganized sample plots that you can make from these structures. Note you can also look at "streamlined_analysis.m" for more sample plots (from the 2hz tracking code, see other repository). The data structures are nearly identical.
