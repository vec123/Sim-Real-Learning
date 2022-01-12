% Walking Robot -- DDPG Agent Training Script (2D)
% Copyright 2019 The MathWorks, Inc.

%% SET UP ENVI7RONMENT
Ts = 0.004; % Agent sample time
Tf = 2;    % Simulation end time
batch_size=Tf/Ts 
% Speedup options
useFastRestart = false;
useGPU = true;
useParallel = false;

% Create the observation infonumObs = 2;
numObs=2;

observationInfo = rlNumericSpec([numObs 1]);
observationInfo.Name = 'observations';

% create the action info
numAct = 1;
actionInfo = rlNumericSpec([numAct 1],'LowerLimit',0 ,'UpperLimit', 1);
actionInfo.Name = 'sine_amplitude';

% Environment
mdl = 'Train_local_R2021a';
load_system(mdl);
blk = [mdl,'/Agent'];
env = rlSimulinkEnv(mdl,blk,observationInfo,actionInfo);
%env.ResetFcn = @(in)walkerResetFcn(in,upper_leg_length/100,lower_leg_length/100,h/100,'2D');
%if ~useFastRestart
%   env.UseFastRestart = 'off';
%end

%% CREATE NEURAL NETWORKS
createDDPGNetworks_sigmoid;
                     
%% CREATE AND TRAIN AGENT
episodes = 3;
%%for i = 1:episode
createDDPGOptions;
agent = rlDDPGAgent(actor,critic,agentOptions);
trainingResults = train(agent,env,trainingOptions)
%%end

%features = ["actions","states" ,"rewards" , "sines"]
%for episode = 1:episodes
% mat_to_ws(features,episode );
%end

%% SAVE AGENT
reset(agent); % Clears the experience buffer
curDir = pwd;
saveDir = 'local\savedAgents';
cd(saveDir)
save(['Agent'],'agent','trainingResults');
cd(curDir)

