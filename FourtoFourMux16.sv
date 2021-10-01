module FourtoFourMux16 (
                    input logic [15:0] A, B, C, D,      //inputs to mux
                    input logic [3:0] S,                 //select
                    output logic [15:0] OUT
);

always_comb begin
    case(S)
        4'b0001:  OUT = A;
        4'b0010:  OUT = B;
        4'b0100:  OUT = C;
        4'b1000:  OUT = D;

        default: OUT = 16'hxxxx;
    endcase
end
endmodule