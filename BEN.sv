module BEN (
            input clk, reset,
            input logic LD_BEN, //decides whether or not we load BEN
            input logic [2:0] NZP,
            input logic [2:0] IR11_10_9,
            output logic OUT
);

logic ben;  //placed into BEN_OUT if LD_BEN is high

assign ben = (IR11_10_9[2] & NZP[2]) + (IR11_10_9[1] & NZP[1]) + (IR11_10_9[0] & NZP[0]);
//BEN <- IR[11] & N + IR[10] & Z + IR[9] & P

threebitregister ben_register (.clk(clk), .din(ben), .load(LD_BEN), .reset(reset), .dout(OUT));
endmodule
