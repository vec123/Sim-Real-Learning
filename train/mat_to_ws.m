
function  [observation_sgnls, action_sgnls] = mat_to_ws(model,filename,episode)
        cd(pwd)
        data = load( sprintf('remote/Execution_Data/%s_%d_1.mat',model,episode) )
         %time = data.tout(:);
         %actions = data.Actions.signals.values(:);
        action_sgnls = data.Actions;
         %ts_a = timeseries(actions,time)
         %array_a =  [time,actions]
        
         %observations = data.Observations.signals.values(:);
        observation_sgnls = data.Observations;
         %ts_o = timeseries(observations,time)
         %array_o =  [time,observations]
        
        %str=sprintf('train/%s/actions',filename)
        %save(sprintf('train/%s/actions',filename),'action_sgnls')
        %save(sprintf('train/%s/observations',filename),'observation_sgnls')
        %str = sprintf('SimulationCSV_Data/%s_%d.csv',name,episode);
        %csvwrite( str, data.ScopeData2.signals.values(:) );
    
end


