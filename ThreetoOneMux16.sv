module ThreetoOneMux16 (
                input logic [15:0] A, B, C, //the three inputs
                input logic [1:0] S,        //the select
                output logic [15:0] OUT     //the output of mux
);

always_comb begin
    case(S):
        2'b00: OUT = A;
        2'b01: OUT = B;
        2'b10: OUT = C;
        default: OUT = 16'h0;
    endcase
end