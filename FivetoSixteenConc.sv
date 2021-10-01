module FivetoSixteenConc (
        input logic [4:0] A,
        output logic [16:0] B
);
assign ones = 11'b11111111111;
assign zeros = 11'b00000000000;
always_comb begin
    if (A[4])
        assign B = {ones,A};
    else
        assign B = {zeros,B};
end
endmodule