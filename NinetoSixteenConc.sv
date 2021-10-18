module NinetoSixteenConc (
        input logic [8:0] A,
        output logic [16:0] B
);
//assign ones = 7'b1111111;
//assign zeros = 7'b0000000;
//always_comb begin
//    if (A[8])
//        B = {ones,A};
//    else
//        B = {zeros,A};
//end

assign B = {{7{A[8]}}, A};endmodule