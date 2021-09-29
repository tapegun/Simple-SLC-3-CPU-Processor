module register (input logic [15:0] din,
	input logic clk, load, reset,
	output logic [15:0] dout
);

   always_ff @ (posedge clk)
	begin
		if(reset)
			dout <= 16'h00;
		else if(load)
			dout <= din;
	end

endmodule 