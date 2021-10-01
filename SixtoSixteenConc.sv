module SixtoSixteenConc (
        input logic [5:0] A,
        output logic [16:0] B
);
assign ones = 10'b1111111111;
assign zeros = 10'b0000000000;
always_comb begin
    if (A[5])
        assign B = {ones,A};
    else
        assign B = {zeros,B};
end
endmodule