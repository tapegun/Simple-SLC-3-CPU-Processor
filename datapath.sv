module datapath(
	input logic clk, reset
	SR2, SR1,
	DR,
	LD_REG, LD_BEN, LD_CC, LD_IR, LD_PC, LD_MAR, LD_MDR, LD_LED
	GateALU, GatePC, GateMARMUX, GateMDR,
	ADDR1MUX, input logic [1:0] ADDR2MUX,
	input logic[1:0] ALUK,
	input logic MEMIO,
	input logic [15:0] MDR_In,
	output logic BEN,
	output logic [15:0] IR_OUT,
	// PC_OUT,
	MAR_OUT, 
	MDR_OUT,
	output logic [11:0] LED
	);

	logic [15:0] bus;
	
	logic [15:0] PCMUX;
	logic [15:0] PCOUT;
	logic [15:0] IROUT;

	logic [15:0] IRSEXT10;
	logic [15:0] IRSEXT8;
	logic [15:0] IRSEXT5;
	logic [15:0] IRSEXT4;
	
	logic [15:0] ADDR2MUXOUT;
	logic [15:0] ADDR1MUXOUT;

	logic [15:0] SR1_OUT;
	logic [15:0] SR2_OUT;
	
	logic [15:0] SR2MUXOUT;

	logic [15:0] ALUOUT;
		
	logic [15:0] MDRMUXOUT;

	register PC(
		.reset(reset),
		.clk(clk),
		.din(PCMUX),
		.load(LD_PC),
		.dout(PCOUT));

	register IR(
		.reset(reset),
		.clk(clk),
		.din(bus),
		.load(LD_IR),
		.dout(IR_OUT));

	REGFILE  regs();

	ALU  	 ALU();	

endmodule


