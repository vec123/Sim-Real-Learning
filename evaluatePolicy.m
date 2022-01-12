function action1 = evaluatePolicy(observation1)
%#codegen

% Reinforcement Learning Toolbox
% Generated on: 08-Jan-2022 17:51:18

action1 = localEvaluate(observation1);
end
%% Local Functions
function action1 = localEvaluate(observation1)
persistent policy
if isempty(policy)
	policy = coder.loadDeepLearningNetwork('remote\policy.mat','policy');
end
observation1 = observation1(:)';
action1 = predict(policy, observation1);
end