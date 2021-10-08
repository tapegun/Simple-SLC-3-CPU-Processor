module testbench();

    timeunit 10ns;
    timeprecision 1ns;

    logic [9:0] SW;
    logic	Clk, Run, Continue;
    logic [9:0] LED;
    logic [6:0] HEX0, HEX1, HEX2, HEX3;
    logic [19:0] ADDR;
    logic [15:0] MARTESTOUT, PCTESTOUT, MDRTESTOUT;
    //logic  CE, UB, LB, OE, WE;

slc3_testtop slc3_testtop_0(.*);

always begin : CLOCK_GENERATION
#1 Clk = ~ Clk;
end

initial begin: CLOCK_INITIALIZATION
Clk = 0;
end

initial begin: TEST

SW = 10'b0000000000;
Run = 1'b1;
Continue = 1'b1;

// #22 Run = 1'b1;
//     Continue = 1'b1;

#22 Run = 1'b0;
Continue = 1'b0;

#22 Run = 1'b0;

#22 Run = 1'b1;

#22 Run = 1'b0;

// #60 Continue = 1'b0;

// #22 Continue = 1'b1;

// #22 Continue = 1'b0;

#60 Continue = 1'b1;

#22 Continue = 1'b0;

end
endmodule