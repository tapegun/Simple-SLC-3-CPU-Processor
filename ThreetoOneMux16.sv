module ThreetoOneMux16 (
                input logic [15:0] A, B, C, //the three inputs
                input logic [1:0] S,        //the select
                output logic [15:0] OUT     //the output of mux
);

always_comb begin
    case(S)
        2'b00: assign OUT = A;
        2'b01: assign OUT = B;
        2'b10: assign OUT = C;
        default: assign OUT = 16'h0;
    endcase
end
endmodule