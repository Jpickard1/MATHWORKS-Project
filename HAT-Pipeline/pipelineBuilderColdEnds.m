% Auth: Joshua Pickard
%       jpic@umich.edu
% Date: January 31, 2023

clear all; close all;

import bioinfo.pipeline.Pipeline
import bioinfo.pipeline.blocks.*

% Create Pipeline
HGColdEnds = Pipeline;

% Level 1
loadHG = UserFunction(@ load_HG,RequiredArguments="ds",OutputArguments="HG");                               % Block 1
addBlock(HGColdEnds,loadHG);

% Level 2
PARTITION = UserFunction(@partitionE, RequiredArguments=["HG","k"],OutputArguments=["K","U"]);               % Block 2
addBlock(HGColdEnds, PARTITION);

% Connections: Level 1 -- Level 2
connect(HGColdEnds,loadHG,PARTITION,["HG","HG"]);

% Level 3
PREDICT = UserFunction(@ColdEndsDriver, RequiredArguments=["HG","K","U"],OutputArguments="P");
addBlock(HGColdEnds, PREDICT);

% Connections: Level 1 -- Level 3
connect(HGColdEnds,loadHG,PREDICT,["HG","HG"]);
% Connections: Level 2 -- Level 3
connect(HGColdEnds,PARTITION,PREDICT,["K","K"]);
connect(HGColdEnds,PARTITION,PREDICT,["U","U"]);

clearvars -except HGColdEnds
biopipelineDesigner(HGColdEnds)

%%
clearvars -except HGtrue HGobserved itrs trials
