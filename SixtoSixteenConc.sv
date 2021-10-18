module SixtoSixteenConc (
        input logic [5:0] A,
        output logic [16:0] B
);

//always_comb
// begin
//    if (A[5])
//        B = {ones, A};
//    else
//        B = {zeros,A};
//end
assign B = {{10{A[5]}}, A};endmodule