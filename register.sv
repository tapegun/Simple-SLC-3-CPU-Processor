module register (input logic [15:0] din,
	input logic clk, load, reset,
	output logic [15:0] dout
);

	logic [15:0] data_n;
   always_ff @ (posedge clk)
	begin
		dout <= data_n;
	end
	
	always_comb begin
		data_n = dout;
		if(reset)
			data_n = 0;
		else if(load)
			data_n = din;
	end

endmodule 