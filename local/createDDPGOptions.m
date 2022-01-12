% Create DDPG agent and training options for walking robot example
%
% Copyright 2019 The MathWorks, Inc.

%% DDPG Agent Options
agentOptions = rlDDPGAgentOptions;
agentOptions.SampleTime = Ts;
agentOptions.DiscountFactor = 0.99;
agentOptions.MiniBatchSize = 512;
agentOptions.ExperienceBufferLength = 1e6;
agentOptions.TargetSmoothFactor = 1e-3;
agentOptions.NoiseOptions.MeanAttractionConstant = 5;
agentOptions.NoiseOptions.Variance = 0.4;
agentOptions.NoiseOptions.VarianceDecayRate = 1e-5;

%% Training Options
trainingOptions = rlTrainingOptions;
trainingOptions.MaxEpisodes = 3;
trainingOptions.MaxStepsPerEpisode = Tf/Ts;
trainingOptions.ScoreAveragingWindowLength = 100;
trainingOptions.StopTrainingCriteria = 'EpisodeCount';
trainingOptions.StopTrainingValue = trainingOptions.MaxEpisodes;
trainingOptions.SaveAgentCriteria = 'EpisodeCount';
trainingOptions.SaveAgentValue = 1;
trainingOptions.Plots = 'training-progress';
trainingOptions.Verbose = true;
%%trainingOptions.ExecutionEnvironment = 'gpu'
if useParallel
    trainingOptions.Parallelization = 'async';
    trainingOptions.ParallelizationOptions.StepsUntilDataIsSent = 32;
end