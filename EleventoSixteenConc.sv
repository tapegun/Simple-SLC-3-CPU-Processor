module EleventoSixteenConc (
        input logic [10:0] A,
        output logic [16:0] B
);
assign ones = 5'b11111;
assign zeros = 5'b00000;
always_comb begin
    if (A[10]):
        B = {ones,A};
    else:
        B = {zeros,B};
end