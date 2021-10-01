module SixtoSixteenConc (
        input logic [5:0] A,
        output logic [16:0] B
);
assign ones = 10'b1111111111;
assign zeros = 10'b0000000000;
//always_comb
// begin
//    if (A[5])
//        B = {ones, A};
//    else
//        B = {zeros,A};
//end
assign B = {{11{A[5]}}, A};endmodule