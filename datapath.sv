module datapath(
	input logic clk, reset
	SR2, SR1,
	DR,
	LD_REG, LD_BEN, LD_CC, LD_IR, LD_PC, LD_MAR, LD_MDR, LD_LED
	GateALU, GatePC, GateMARMUX, GateMDR,
	ADDR1MUX, input logic [1:0] ADDR2MUX,
	input logic[1:0] ALUK,
	// input logic MEMIO,
	input logic [15:0] MDR_In,
	output logic BEN,
	output logic [15:0] IR,
	// PC_OUT,
	MAR, 
	MDR,
	// output logic [11:0] LED
	);

	logic [15:0] databus;
	
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
	
	logic DRMUX

	register PC(
		.reset(reset),
		.clk(clk),
		.din(PCMUX),
		.load(LD_PC),
		.dout(PCOUT));

	register IR(
		.reset(reset),
		.clk(clk),
		.din(databus),
		.load(LD_IR),
		.dout(IR));

	register MDR(
		.reset(reset),
		.clk(clk),
		.din(MDRMUXOUT),
		.load(LD_MDR),
		.dout(MDR));

	register MAR(
		.reset(reset),
		.clk(clk),
		.din(databus),
		.load(LD_MAR),
		.dout(MAR));

	REGFILE  regs(
		.DRMUX(DRMUX),
		.SR1MUX(), //the first input register
		.SR2(), //the second input register
		.BUSINPUT(), //takes in the bits from the bus data path
		.LD_REG(), //1 if we want to load the registers, 0 otherwise
		.clk(),
		.SR1_OUT(), .SR2_OUT() // the outputs of source register 1 and 2
		);

	ALU  	 ALU();	

	TwotoOneMux3 DR_MUX( 1'b111, IR[11:9]), DR, DRMUX);
	TwotoOneMux3 DR_MUX( 1'b111, IR[11:9]), DR, DRMUX);
	TwotoOneMux3 DR_MUX( 1'b111, IR[11:9]), DR, DRMUX);
	TwotoOneMux3 DR_MUX( 1'b111, IR[11:9]), DR, DRMUX);


endmodule


