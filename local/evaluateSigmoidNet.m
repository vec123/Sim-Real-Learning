function action1 = evaluateSigmoidNet(observation1)
%#codegen

% Reinforcement Learning Toolbox
% Generated on: 15-Dec-2021 23:54:43

action1 = localEvaluate(observation1);
end
%% Local Functions
function action1 = localEvaluate(observation1)
persistent policy
if isempty(policy)
	policy = coder.loadDeepLearningNetwork('agentData.mat','policy');
end
observation1 = observation1(:)';
action1 = predict(policy, observation1);
end