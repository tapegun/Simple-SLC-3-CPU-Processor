module testbench();

    timeunit 10ns;
    timeprecision 1ns;

    logic [9:0] SW;
    logic	Clk, Run, Continue;
    logic [9:0] LED;
    logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
    logic [15:0] ADDR;
    logic [15:0] MARTESTOUT, PCTESTOUT, MDRTESTOUT;
    //logic  CE, UB, LB, OE, WE;
    slc3_testtop slc3_testtop_0(.*);

    logic [2:0]NZP;
//	logic [2:0]IR_NZP;
	logic BEN;
	logic BEN_com;
	logic [15:0] ALU_Out,ALU_A,ALU_B;
    logic [15:0] R0, R1, R2, R3, R4, R5, R6, R7;
	// enum logic [4:0] {  Halted, 
	// 					PauseIR1, 
	// 					PauseIR2, 
	// 					S_18, 
	// 					S_33_1, 
	// 					S_33_2, 
	// 					S_33_3,
	// 					S_35, 
	// 					S_32, 
	// 					S_01,
	// 					S_05,
	// 					S_09,
	// 					S_00,
	// 					S_12,
	// 					S_04,
	// 					S_06,
	// 					S_07,
	// 					S_25_1,
	// 					S_25_2,
	// 					S_25_3,
	// 					S_27,
	// 					S_23,
	// 					S_16_1,
	// 					S_16_2,
	// 					S_16_3,
	// 					S_22,
	// 					S_21
	// }   state;
    always begin
        #1
        BEN =slc3_testtop_0.slc.d0.BEN;
		R0 = slc3_testtop_0.slc.d0.regs.reg0.dout;
		R1 = slc3_testtop_0.slc.d0.regs.reg1.dout;
		R2 = slc3_testtop_0.slc.d0.regs.reg2.dout;
		R3 = slc3_testtop_0.slc.d0.regs.reg3.dout;
		R4 = slc3_testtop_0.slc.d0.regs.reg4.dout;
		R5 = slc3_testtop_0.slc.d0.regs.reg5.dout;
		R6 = slc3_testtop_0.slc.d0.regs.reg6.dout;
		R7 = slc3_testtop_0.slc.d0.regs.reg7.dout;
		NZP =slc3_testtop_0.slc.d0.NZP_Unit.OUT;
		//IR_NZP = test.slc.d0.IR[11:9];
		BEN_com = slc3_testtop_0.slc.d0.BEN_Unit.OUT;
		ALU_Out = slc3_testtop_0.slc.d0.ALU_Unit.OUT;
		ALU_A = slc3_testtop_0.slc.d0.ALU_Unit.A;
		ALU_B = slc3_testtop_0.slc.d0.ALU_Unit.B;
		//state = slc3_testtop_0.slc.state_controller.State;
    end



always begin : CLOCK_GENERATION
#1 Clk = ~ Clk;
end

initial begin: CLOCK_INITIALIZATION
Clk = 0;
end

initial begin: TEST

SW = 10'b0000000011;
Run = 1'b1;
Continue = 1'b1;

// #22 Run = 1'b1;
//     Continue = 1'b1;

#48 Run = 1'b0;
Continue = 1'b0;

#48 Run = 1'b1;
Continue = 1'b1;

// //basic i/o test 1

// #48 Run = 1'b0;

// #48 Run = 1'b1;

// #48 SW = 10'b0000011111;
// #48 SW = 10'b1111111111;
// #48 SW = 10'b1111100000;

// #120 Continue = 1'b1;
// 	Run = 1'b1;

// #48 Continue = 1'b0;
// 	Run = 1'b0;

// //basic i/o test 2

// #48 SW = 10'h0006;
// #60 Run = 1'b0;
// #48 Run = 1'b1;

// #48 SW = 10'b0000011111;

// #48 Continue = 1'b0;
// #48 Continue = 1'b1;

// #48 SW = 10'b1111100000;
// #48 Continue = 1'b0;
// #48 Continue = 1'b1;

// #120 Continue = 1'b0;
// 	Run = 1'b0;

// #48 Continue = 1'b1;
// 	Run = 1'b1;

//Self-Modifying Code Test
// #48 SW = 10'h000B;

// #48 Run = 1'b0;

// #48 Run = 1'b1;

// #128 Continue = 1'b0;

// #12 Continue = 1'b1;

// #128 Continue = 1'b0;

// #12 Continue = 1'b1;

// #128 Continue = 1'b0;

// #12 Continue = 1'b1;

// #128 Continue = 1'b0;

// #12 Continue = 1'b1;

// #128 Continue = 1'b0;
// 	Run = 1'b0;

// #48 Continue = 1'b1;
// 	Run = 1'b1;
// //XOR Test

// #48 SW = 10'h0014;

// #48 Run = 1'b1;
// #48 Run = 1'b0;

// #48 SW = 10'h0001;
// #48 Continue = 1'b1;
// #48 Continue = 1'b0;

// #48 SW = 10'h0002;
// #48 Continue = 1'b1;
// #48 Continue = 1'b0;

// #48 Continue = 1'b1;
// #48 Continue = 1'b0;


// #120 Continue = 1'b1;
// 	Run = 1'b1;

// #48 Continue = 1'b0;
// 	Run = 1'b0;

Multiplication Test

#12 SW = 10'h0031;
#12 Run = 1'b0;
#12 Run = 1'b1;

#12 SW = 10'h0004;
#12 Continue = 1'b0;
#12 Continue = 1'b1;
#12 SW = 10'h0005;
#48 Continue = 1'b0;
#12 Continue = 1'b1;
#48 Continue = 1'b0;
#12 Continue = 1'b1;


#128 Continue = 1'b0;
	Run = 1'b0;

#12 Continue = 1'b1;
	Run = 1'b1;


// //Sort Test

// #48 SW = 10'h005A;

// #48 Run = 1'b1;
// 	Continue = 1'b1;
// #48 Run = 1'b0;
// 	Continue = 1'b0;

// #48 Run = 1'b1;
// #48 Run = 1'b0;

// #48 SW = 10'h0001;
// #48 Continue = 1'b1;
// #48 Continue  = 1'b0;

// //all 16 values get inserted
// #48 SW = 10'h000F;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;

// #48 SW = 10'h000E;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;

// #48 SW = 10'h000C;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;

// #48 SW = 10'h000B;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;

// #48 SW = 10'h000A;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;

// #48 SW = 10'h0009;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;

// #48 SW = 10'h0008;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;

// #48 SW = 10'h0007;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;

// #48 SW = 10'h0006;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;

// #48 SW = 10'h0005;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;

// #48 SW = 10'h0004;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;

// #48 SW = 10'h0003;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;

// #48 SW = 10'h0002;;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;

// #48 SW = 10'h0001;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;

// #48 SW = 10'h0000F;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;

// #48 SW = 10'h0010;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;

// //run the sort algorithm
// #48 SW = 10'h0002;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;

// #10000 SW = 10'h0003;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;
// #120 Continue = 1'b1;
// #48 Continue = 1'b0;




end
endmodule