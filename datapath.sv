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
	
	logic [15:0] PCMUXOUT;
	logic [15:0] PCOUT;
	logic [15:0] IROUT;

	//sign extensions of IR
	logic [15:0] IRSEXT11;
	logic [15:0] IRSEXT9;
	logic [15:0] IRSEXT6;
	logic [15:0] IRSEXT5;
	
	//outputs of ADDR1 and 2 MUX that feed into one giant adder
	logic [15:0] ADDR2MUXOUT;
	logic [15:0] ADDR1MUXOUT;

	//the sum of ADDR1 and 2
	logic [15:0] ADDROUT

	logic [15:0] SR1_OUT;
	logic [15:0] SR2_OUT;
	
	logic [2:0] SR1MUXOUT
	logic [15:0] SR2MUXOUT;

	logic [15:0] ALUOUT;
		
	logic [15:0] MDRMUXOUT;
	
	logic DRMUXOUT;

	//this sign extends the IR signal of the necessary various inputs
	FivetoSixteenConc conc1 (.A(IR[4:0]), .B(IRSEXT5));
	SixtoSixteenConc conc2 (.A(IR[5:0]), .B(IRSEXT6));
	NinetoSixteenConc conc3 (.A(IR[8:0]), .B(IRSEXT9));
	EleventoSixteenConc conc4 (.A(IR[10:0]), .B(IRSEXT11));

	register PC(
		.reset(reset),
		.clk(clk),
		.din(PCMUXOUT),
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

	TwotoOneMux3 DR_MUX( .A(1'b111), .B(IR[11:9])), .S(DR), .OUT(DRMUXOUT));
	TwotoOneMux3 SR1_MUX( .A(IR[11:9]), .B(IR[8:6])), .S(SR1), .OUT(SR1MUXOUT));
	TwotoOneMux16 SR2_MUX(.A(IRSEXT5), .B(SR2_OUT), .S(someinput), .OUT(SR2MUXOUT));	//figure out the select signal for this mux-comes from control
	TwotoOneMux16 ADDR1_MUX(.A(SR1_OUT), .B(PC), .S(ADDR1MUX), .OUT(ADDR1MUXOUT));
	FourtoOneMux16 ADDR2_MUX(.A(IRSEXT11), .B(IRSEXT9), .C(IRSEXT6), .D(16'b0), .S(ADDR2MUX), .OUT(ADDR2MUXOUT));
	ThreeToOneMux16 PC_MUX(.A(databus),.B(ALUOUT),.C(PC+1),.S(someinput), .OUT(PCMUXOUT)); //figure out the select signal for this mux-comes from control
	FourtoFourMux16 DATABUS_MUX(.A(ADDROUT), .B(PC_OUT), .C(ALUOUT), .D(MDR), .S({GateMARMUX,GatePC, GateALU, GateMDR}), .OUT(databus)); //signals probably wrong

endmodule


