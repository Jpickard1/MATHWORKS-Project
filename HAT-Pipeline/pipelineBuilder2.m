% Auth: Joshua Pickard
%       jpic@umich.edu
% Date: January 30, 2023

clear all; close all;

import bioinfo.pipeline.Pipeline
import bioinfo.pipeline.blocks.*
import bioinfo.pipeline.blocks.UserFunction

% Create Pipeline
HGObserver = Pipeline;

% Level 1
loadHG = UserFunction(@ load_HG,RequiredArguments="ds",OutputArguments="HG");                               % Block 1
addBlock(HGObserver,loadHG);

% Level 2
OE0 = UserFunction(@ observeEr, RequiredArguments=["HG","k","r0","itrs","trials"],OutputArguments="OE0");    % Block 
OE1 = UserFunction(@ observeEr, RequiredArguments=["HG","k","r1","itrs","trials"],OutputArguments="OE1");    % Block 
OE2 = UserFunction(@ observeEr, RequiredArguments=["HG","k","r2","itrs","trials"],OutputArguments="OE2");    % Block 
OE3 = UserFunction(@ observeEr, RequiredArguments=["HG","k","r3","itrs","trials"],OutputArguments="OE3");    % Block 
OE4 = UserFunction(@ observeEr, RequiredArguments=["HG","k","r4","itrs","trials"],OutputArguments="OE4");    % Block 
addBlock(HGObserver,[OE0, OE1, OE2, OE3, OE4]);

% Connections: Level 1 -- Level 2
connect(HGObserver,loadHG,OE0,["HG","HG"]);
connect(HGObserver,loadHG,OE1,["HG","HG"]);
connect(HGObserver,loadHG,OE2,["HG","HG"]);
connect(HGObserver,loadHG,OE3,["HG","HG"]);
connect(HGObserver,loadHG,OE4,["HG","HG"]);

% Level 3
collect = UserFunction(@collectSubhypergraphs5, RequiredArguments=["ds", "OE0", "OE1", "OE2", "OE3", "OE4"],OutputArguments="O");
addBlock(HGObserver, collect);

% Connections: Level 2 -- Level 3
connect(HGObserver,OE0,collect,["OE0","OE0"]);
connect(HGObserver,OE1,collect,["OE1","OE1"]);
connect(HGObserver,OE2,collect,["OE2","OE2"]);
connect(HGObserver,OE3,collect,["OE3","OE3"]);
connect(HGObserver,OE4,collect,["OE4","OE4"]);

% Level 4
tableMaker = UserFunction(@tableMaker, RequiredArguments=["O", "ds", "itrs", "trials", "latex"]);
addBlock(HGObserver, tableMaker);

% Connections: Level 3 -- Level 4
connect(HGObserver,collect,tableMaker,["O","O"]);

% Level 4
hyperedgePrediction = UserFunction(@hyperedgePredictionDriver, RequiredArguments=["O", "itrs", "trials"]);
addBlock(HGObserver, hyperedgePrediction);

% Connections: Level 3 -- Level 4
connect(HGObserver,collect,hyperedgePrediction,["O","O"]);

clearvars -except HGpipeline
% biopipelineDesigner(HGObserver)

%%
clearvars -except HGtrue HGobserved itrs trials
