module NZP (
            input clk, reset,
            input logic [15:0] DR_VALUE, //the value being loaded into DR is needed to compute the NZP. This is the same as the value in the bus
            input logic LD_CC,           //this tells us when to load the NZP
            output logic [2:0] OUT
);

logic [2:0] nzp; //temporary nzp value, placed into OUT if LD_CC is high

always_comb begin
    nzp = 3'b0;
    if(DR_VALUE == 16'h0000)
        nzp[1] = 1'b1; //z = 1
    else if (DR_VALUE[15]==1'b1)
        nzp[2] = 1'b1; //n = 1
    else if (DR_VALUE[15]==1'b0)
        nzp[0] = 1'b1; //p = 1
end

threebitregister nzp_register(.clk(clk), .load(LD_CC), .reset(reset), .din(nzp), .dout(OUT)); 
endmodule