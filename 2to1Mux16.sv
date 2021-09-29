module 2to1Mux16 (
                input logic [15:0] A, B, //16 bit inputs
                input logic S,            //select bit
                output logic OUT        //mux output
);

always_comb begin
    OUT = B;
    if (S):
        OUT = A;
end