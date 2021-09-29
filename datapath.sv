module datapath(
					input logic 
					SR2, SR1,
					DR,
					ADDR1MUX, ADDR2MUX,
					LD_REG, LD_BEN, LD_CC, LD_IR, LD_PC,
					GateALU, GatePC, GateMARMUX, GateMDR,
					output
					);
					
register PC()