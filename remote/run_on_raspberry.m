
raspi.internal.updateServer('169.254.230.46','pi','raspberry')
rpi = raspi('169.254.230.46','pi','raspberry')

cd remote

modelName = 'raspberry_net_test_R2021a';
board = setup_board();
build(modelName)
set_param(modelName,'SimulationCommand','connect')


function board = setup_board()
board = targetHardware('Raspberry Pi');
board.CoderConfig.TargetLang = 'C++';
board.CoderConfig.GenCodeOnly = true;
dlcfg = coder.DeepLearningConfig('arm-compute');
dlcfg.ArmArchitecture = 'armv7';

dlcfg.ArmComputeVersion = '20.02.1'
board.CoderConfig.DeepLearningConfig = dlcfg
end

function build(modelName)
slbuild(modelName) 
end

function deploy(rpi,modelName)
source = sprintf('%s.elf', modelName);
%destination = sprintf('/home/pi/MATLAB_ws/R2021a/%s.elf', modelName);
destination = sprintf('/home/pi/%s.elf', modelName);
putFile(rpi,source,destination);
end

