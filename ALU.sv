module ALU (input logic [15:0] A, 
            input logic [15:0] B,
            input logic [1:0] ALUK,
            output logic [15:0] OUT);

always_comb begin
    
    case(ALUK)
    2'b00: OUT = A + B;

    2'b01: OUT = A & B;

    2'b10: OUT = ~A;

    2'b11: OUT = A;

    default OUT = 2'bxx;
    endcase
end
endmodule