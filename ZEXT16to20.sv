module ZEXT16to20 (
    input logic [15:0] A,               //16 bit input
    output logic [19:0] B               //20 bit zero extended output
);

assign B = {4'b0000,A};

endmodule