module TwotoOneMux3 (
                input logic [2:0] A, B, //these are the 3 bit inputs
                input logic S,          //the select bit
                output logic [2:0]  OUT //the output
);

	always_comb
		begin
			 OUT =  B;
			 if (S)
				OUT = A;
		end
endmodule