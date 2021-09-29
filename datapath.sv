module datapath(
	input logic clk, reset
	SR2, SR1,
	DR,
	LD_REG, LD_BEN, LD_CC, LD_IR, LD_PC, LD_MAR, LD_MDR, LD_LED
	GateALU, GatePC, GateMARMUX, GateMDR,
	ADDR1MUX, input logic [1:0] ADDR2MUX,
	input logic[1:0] ALUK,
	input logic [1:0] PCMUX,
	// input logic MEMIO,
	input logic [15:0] MDR_In,
	output logic BEN,
	output logic [15:0] IR,
	PC_OUT,
	MAR, 
	MDR,
	// output logic [11:0] LED
	);

	logic [15:0] databus;
	
	logic [15:0] PC_MUX;
	logic [15:0] PC_OUT;
	logic [15:0] IROUT;

	logic [15:0] IRSEXT10;		// put these here temporarily till we figure it out
	logic [15:0] IRSEXT8;
	logic [15:0] IRSEXT5;
	logic [15:0] IRSEXT4;
	
	logic [15:0] ADDR2MUX_OUT;
	logic [15:0] ADDR1MUX_OUT;

	logic [15:0] SR1_OUT;
	logic [15:0] SR2_OUT;
	
	logic [15:0] SR2MUX_OUT;

	logic [15:0] ALUOUT;
		
	logic [15:0] MDRMUXOUT;
	
	logic [2:0] DR_MUX


	register PC(
		.reset(reset),
		.clk(clk),
		.din(PC_MUX),
		.load(LD_PC),
		.dout(PC_OUT));

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
		.DRMUX(DR_MUX),
		.SR1MUX(SR1), //the first input register
		.SR2(SR2), //the second input register
		.BUSINPUT(databus), //takes in the bits from the bus data path
		.LD_REG(LD_REG), //1 if we want to load the registers, 0 otherwise
		.clk(clk),
		.SR1_OUT(SR1_OUT), .SR2_OUT(SR2_OUT) // the outputs of source register 1 and 2
		);

	ALU  	 ALU();	

	TwotoOneMux3 DR_MUX_( .A(1'b111), .B(IR[11:9]), .S(DR), .OUT(DR_MUX));
	ThreetoOneMux16 PC_MUX_(.A(bus), .B(ADDR1MUX_OUT + ADDR2MUX_OUT), .C(PC_OUT + 1'b1), .S(PCMUX), .OUT(PC_MUX));
	FourtoOneMux16 ADDR2_MUX (.S(ADDR2MUX), .A(IRSEXT10), .B(IRSEXT8), .C(IRSEXT5), .D(16'h0000), .OUT(ADDR2MUX_OUT));
	TwotoOneMux16 ADDR1_MUX( .A(PC_OUT), .B(SR1_OUT), .S(ADDR1MUX), .OUT(ADDR1MUX_OUT));
	TwotoOneMux3 SR1_MUX(.A(IR[11:9]), .B(IR[8:6]), .S(SR1), .OUT(SR1_OUT));
	TwotoOneMux16 SR2_MUX(.A(SR2_OUT), .B(IRSEXT4), .S(SR2), .OUT(SR2MUX_OUT));


endmodule


