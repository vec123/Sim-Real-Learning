% Walking Robot -- DDPG Agent Training Script (2D)
% Copyright 2019 The MathWorks, Inc.

%% SET UP ENVIRONMENT
Ts = 0.004; % Agent sample time
Tf = 2;    % Simulation end time
batch_size=Tf/Ts;   
episodes = 1;


% Speedup options
useFastRestart = false;
useGPU = true;
useParallel = false;

% Create the observation info
numObs = 2;
observationInfo = rlNumericSpec([numObs 1]);
observationInfo.Name = 'observations';

% create the action info
numAct = 1;
actionInfo = rlNumericSpec([numAct 1],'LowerLimit',0 ,'UpperLimit', 1);
actionInfo.Name = 'sine_amplitude';

% Environment
%mdl_execute = 'Execute_on_hardware';
mdl_execute = 'raspberry_net_test_R2021a';
mdl_train = 'Train_with_data_R2021a';

load_system(mdl_train);
blk = [mdl_train,'/Agent'];
env_train = rlSimulinkEnv(mdl_train,blk,observationInfo,actionInfo);
%env.ResetFcn = @(in)walkerResetFcn(in,upper_leg_length/100,lower_leg_length/100,h/100,'2D');
%if ~useFastRestart
%   env.UseFastRestart = 'off';
%end
%execute on Model


%% CREATE NEURAL NETWORKS
%%createDDPGNetworks_sigmoid;
                     
%% CREATE AND TRAIN AGENT
%%createDDPGOptions;
agentOptions.MiniBatchSize = batch_size;
trainingOptions.MaxEpisodes = 1;
agent = rlDDPGAgent(actor,critic,agentOptions);
  
for episode = 1:episodes
    episode
    features = ["actions","states" ,"rewards" , "sines"];    
    [observation_sgnls, action_sgnls]=mat_to_ws(mdl_execute,'SimulationData',episode);
    
    set_param(sprintf('%s/From File',mdl_train),'filename','train/SimulationData/observations.mat')
    paramValue = get_param(sprintf('%s/From File',mdl_train),'filename')

    
    trainingResults = train(agent,env_train,trainingOptions);

end
%% SAVE AGENT
%%reset(agent); % Clears the experience buffer
%%curDir = pwd;
%%saveDir = 'Agents';
%%cd(saveDir)
%%save(['SineAgent' datestr(now,'mm_DD_YYYY_HHMM')],'agent','trainingResults');
%%cd(curDir)