module TwotoOneMux16 (
                input logic [15:0] A, B, //16 bit inputs
                input logic S,            //select bit
                output logic [15:0] OUT        //mux output
);

	always_comb
	begin
		 OUT = A;
		 if (S)
			  OUT = B;
	end
endmodule