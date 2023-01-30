import bioinfo.pipeline.Pipeline
import bioinfo.pipeline.blocks.*

% Create Pipeline
HGObserver = Pipeline;

% Level 1
loadHG = UserFunction(@ load_HG,RequiredArguments="ds",OutputArguments="HG");                               % Block 1
addBlock(HGObserver,loadHG);

% Level 2
OV1 = UserFunction(@ observeV, RequiredArguments=["HG","k","B1","itrs","trials"],OutputArguments="OVH");    % Block 2
OV2 = UserFunction(@ observeV, RequiredArguments=["HG","k","B2","itrs","trials"],OutputArguments="OVN");    % Block 3 -- fail
OV3 = UserFunction(@ observeV, RequiredArguments=["HG","k","B0","itrs","trials"],OutputArguments="OVL");    % Block 4
OE1 = UserFunction(@ observeE, RequiredArguments=["HG","k","B1","itrs","trials"],OutputArguments="OEH");    % Block 5
OE2 = UserFunction(@ observeE, RequiredArguments=["HG","k","B2","itrs","trials"],OutputArguments="OEN");    % Block 6 -- fail
OE3 = UserFunction(@ observeE, RequiredArguments=["HG","k","B0","itrs","trials"],OutputArguments="OEL");    % Block 7
addBlock(HGObserver,[OV1, OV2, OV3, OE1, OE2, OE3]);

% Connections: Level 1 -- Level 2
connect(HGObserver,loadHG,OV1,["HG","HG"]);
connect(HGObserver,loadHG,OV2,["HG","HG"]);
connect(HGObserver,loadHG,OV3,["HG","HG"]);
connect(HGObserver,loadHG,OE1,["HG","HG"]);
connect(HGObserver,loadHG,OE2,["HG","HG"]);
connect(HGObserver,loadHG,OE3,["HG","HG"]);

% Level 3
collect = UserFunction(@collectSubhypergraphs, RequiredArguments=["OVH","OVN","OVL","OEH","OEN","OEL"],OutputArguments="O");
addBlock(HGObserver, collect);

% Connections: Level 2 -- Level 3
connect(HGObserver,OV1,collect,["OVH","OVH"]);
connect(HGObserver,OV2,collect,["OVN","OVN"]);
connect(HGObserver,OV3,collect,["OVL","OVL"]);
connect(HGObserver,OE1,collect,["OEH","OEH"]);
connect(HGObserver,OE2,collect,["OEN","OEN"]);
connect(HGObserver,OE3,collect,["OEL","OEL"]);

clearvars -except HGObserver
% biopipelineDesigner(HGObserver)

%%
clearvars -except HGtrue HGobserved itrs trials
