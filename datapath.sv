module datapath(
	input logic clk, reset,
	SR1MUX,
	DR, MIO_EN,
	LD_REG, LD_BEN, LD_CC, LD_IR, LD_PC, LD_MAR, LD_MDR, LD_LED,
	GateALU, GatePC, GateMARMUX, GateMDR,
	ADDR1MUX, input logic [1:0] ADDR2MUX,
	input logic[1:0] ALUK,
	input logic [1:0] PCMUX,
	// input logic MEMIO,
	input logic [15:0] MDR_In,
	output logic BEN,
	output logic [15:0] IR,
	// PCOUT,
	MAR, 
	MDR
	// output logic [11:0] LED
	//for week 1 test bench purposes
	,output logic [15:0] PCTESTOUT
	);
	

	logic [15:0] databus;
	
	logic [15:0] PCMUXOUT;
	logic [15:0] PCOUT;
	logic [15:0] IROUT;

	//for week 1 test bench purposes
	assign PCTESTOUT = PCOUT;

	//sign extensions of IR
	logic [15:0] SEXT11;
	logic [15:0] SEXT9;
	logic [15:0] SEXT6;
	logic [15:0] SEXT5;
	
	//outputs of ADDR1 and 2 MUX that feed into one giant adder
	logic [15:0] ADDR2MUXOUT;
	logic [15:0] ADDR1MUXOUT;

	//the sum of ADDR1 and 2
	logic [15:0] ADDROUT;

	logic [15:0] SR1_OUT;
	logic [15:0] SR2_OUT;
	
	logic [2:0] SR1MUXOUT;
	logic [15:0] SR2MUXOUT;

	logic [15:0] ALUOUT;
		
	logic [15:0] MDRMUXOUT;
	
	logic [2:0] DRMUXOUT;
	// logic [15:0] IR, MAR, MDR

	//logic variables for nzp and ben
	logic [2:0] NZPOUT;

	//this sign extends the IR signal of the necessary various inputs
	FivetoSixteenConc conc1 (.A(IR[4:0]), .B(SEXT5));
	SixtoSixteenConc conc2 (.A(IR[5:0]), .B(SEXT6));
	NinetoSixteenConc conc3 (.A(IR[8:0]), .B(SEXT9));
	EleventoSixteenConc conc4 (.A(IR[10:0]), .B(SEXT11));

	register PCreg(
		.reset(reset),
		.clk(clk),
		.din(PCMUXOUT),
		.load(LD_PC),
		.dout(PCOUT));

	register IRreg(
		.reset(reset),
		.clk(clk),
		.din(databus),
		.load(LD_IR),
		.dout(IR));

	register MDRreg(
		.reset(reset),
		.clk(clk),        
		.din(MDRMUXOUT),  
		.load(LD_MDR),   
		.dout(MDR));      

	register MARreg(
		.reset(reset),
		.clk(clk),
		.din(databus),
		.load(LD_MAR),
		.dout(MAR));

	REGFILE  regs(
		.DRMUX(DRMUXOUT),
		.SR1MUX(SR1MUXOUT), //the first input register
		.SR2(IR[2:0]), //the second input register
		.BUSINPUT(databus), //takes in the bits from the bus data path
		.LD_REG(LD_REG), //1 if we want to load the registers, 0 otherwise
		.clk(clk),
		.SR1_OUT(SR1_OUT), .SR2_OUT(SR2_OUT) // the outputs of source register 1 and 2
		);

	ALU  	ALU_Unit(.A(SR1_OUT), .B(SR2MUXOUT), .ALUK(ALUK), .OUT(ALUOUT)); //TODO	
	NZP		NZP_Unit(.clk(clk), .reset(reset), .LD_CC(LD_CC), .DR_VALUE(databus), .OUT(NZPOUT));
	BEN 	BEN_Unit(.clk(clk), .reset(reset), .LD_BEN(LD_BEN), .NZP(NZPOUT), .IR11_10_9(IR[11:9]), .OUT(BEN));

	TwotoOneMux3 	DR_MUX( .A(3'b111), .B(IR[11:9]), .S(DR), .OUT(DRMUXOUT)); // g
	TwotoOneMux3 	SR1_MUX( .A(IR[11:9]), .B(IR[8:6]), .S(SR1MUX), .OUT(SR1MUXOUT)); // g
	TwotoOneMux16	SR2_MUX(.A(SR2_OUT), .B(SEXT5), .S(IR[5]), .OUT(SR2MUXOUT));  //g	//figure out the select signal for this mux-comes from control
	TwotoOneMux16	ADDR1_MUX(.A(PCOUT), .B(SR1_OUT), .S(ADDR1MUX), .OUT(ADDR1MUXOUT));  // // good
	FourtoOneMux16  ADDR2_MUX(.A(16'b0), .B(SEXT6), .C(SEXT9), .D(SEXT11), .S(ADDR2MUX), .OUT(ADDR2MUXOUT)); // good
	ThreetoOneMux16 PC_MUX(.A(PCOUT+1'b1),.B(databus),.C(ADDR2MUXOUT + ADDR1MUXOUT),.S(PCMUX), .OUT(PCMUXOUT)); //good //figure out the select signal for this mux-comes from control
	FourtoFourMux16 DATABUS_MUX(.A(ADDR2MUXOUT + ADDR1MUXOUT), .B(PCOUT), .C(ALUOUT), .D(MDR), .S({GateMDR, GateALU, GatePC, GateMARMUX}), .OUT(databus)); //signals probably wrong
	TwotoOneMux16 	MDR_MUX(.A(MDR_In), .B(databus), .S(MIO_EN), .OUT(MDRMUXOUT)); // good
endmodule