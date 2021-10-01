module NinetoSixteenConc (
        input logic [8:0] A,
        output logic [16:0] B
);
assign ones = 7'b1111111;
assign zeros = 7'b0000000;
always_comb begin
    if (A[8])
        assign B = {ones,A};
    else
        assign B = {zeros,B};
end
endmodule