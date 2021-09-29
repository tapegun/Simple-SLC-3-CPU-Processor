module REGFILE (
						input logic [2:0]	DRMUX, //the destination register to be used
											SR1MUX, //the first input register
											SR2, //the second input register
						input logic [15:0]	BUSINPUT, //takes in the bits from the bus data path
						input logic 		LD_REG, //1 if we want to load the registers, 0 otherwise
						input logic 		clk,
						output logic [16:0] SR1_OUT, SR2_OUT // the outputs of source register 1 and 2
						);

logic [15:0] reg0data, reg1data, reg2data, reg3data, reg4data, reg5data, reg6data, reg7data;
logic ldreg0, ldreg1, ldreg2, ldreg3, ldreg4, ldreg5, ldreg6, ldreg7;

//combinational logic for taking in data from the bus and putting it into 
//the destination register
always_comb
begin
	ldreg0, ldreg1, ldreg2, ldreg3, ldreg4, ldreg5, ldreg6, ldreg7 = 0;
	case (DRMUX):
		3'h0:
			if (LD_REG):
				ldreg0 = 1'b1;
		1'h1:
			if (LD_REG):
				ldreg1 = 1'b1;
		3'h2:
			if (LD_REG):
				ldreg2 = 1'b1;
		3'h3:
			if (LD_REG):
				ldreg3 = 1'b1;
		3'h4:
			if (LD_REG):
				ldreg4 = 1'b1;
		3'h5:
			if (LD_REG):
				ldreg5 = 1'b1;
		3'h6:
			if (LD_REG):
				ldreg6 = 1'b1;
		3'h7:
			if (LD_REG):
				ldreg7 = 1'b1;
	endcase
end

//this is the combinational logic for the output of source reg 1
always_comb begin
	case (SR1MUX)
		3'h0: SR1_OUT = reg0data;
		3'h1: SR1_OUT = reg1data;
		3'h2: SR1_OUT = reg2data;
		3'h3: SR1_OUT = reg3data;
		3'h4: SR1_OUT = reg4data;
		3'h5: SR1_OUT = reg5data;
		3'h6: SR1_OUT = reg6data;
		3'h7: SR1_OUT = reg7data;
	endcase
end

//this is the combinational logic for the output of source reg 2
always_comb begin
	case (SR2)
		3'h0: SR2_OUT = reg0data;
		3'h1: SR2_OUT = reg1data;
		3'h2: SR2_OUT = reg2data;
		3'h3: SR2_OUT = reg3data;
		3'h4: SR2_OUT = reg4data;
		3'h5: SR2_OUT = reg5data;
		3'h6: SR2_OUT = reg6data;
		3'h7: SR2_OUT = reg7data;
	endcase
end
						
register reg0 (.*, .din(BUSINPUT), .load(ldreg0), .dout(reg0data));

register reg1 (.*, .din(BUSINPUT), .load(ldreg1), .dout(reg1data));

register reg2 (.*, .din(BUSINPUT), .load(ldreg2), .dout(reg2data));

register reg3 (.*, .din(BUSINPUT), .load(ldreg3), .dout(reg3data));

register reg4 (.*, .din(BUSINPUT), .load(ldreg4), .dout(reg4data));

register reg5 (.*, .din(BUSINPUT), .load(ldreg5), .dout(reg5data));

register reg6 (.*, .din(BUSINPUT), .load(ldreg6), .dout(reg6data));

register reg7 (.*, .din(BUSINPUT), .load(ldreg7), .dout(reg7data));