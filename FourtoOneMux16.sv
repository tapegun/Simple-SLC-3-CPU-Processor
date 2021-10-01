module FourtoOneMux16 (
                input logic [15:0] A, B, C, D, //inputs
                input logic [1:0] S,            //select input
                output logic  [15:0] OUT                //16 bit output
);

always_comb begin
    case (S)
        2'b00: assign OUT = A;
        2'b01: assign OUT = B;
        2'b10: assign OUT = C;
        2'b11: assign OUT = D;
    endcase
end
endmodule