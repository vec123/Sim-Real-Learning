%cd('C:\Users\vic-b\Documents\Victors\Job\Biosim\Learning_Ws')

load('local\savedAgents\Agent.mat');
generatePolicyFunction(agent, 'MATFileName', "remote\policy.mat");

