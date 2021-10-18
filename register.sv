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
			data_n = 16'h0000;
		else if(load)
			data_n = din;
	end

endmodule 
module dummypc (input logic [15:0] din,
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
			data_n = 16'h0001;
		else if(load)
			data_n = din;
	end

endmodule 

module onebitregister (input logic din,
						input logic clk, load, reset,
						output logic dout
);

logic data_n;

always_ff @ (posedge clk)
begin
	dout <= data_n;
end

always_comb begin
	data_n = dout;
	if(reset)
		data_n = 1'b0;
	else if(load)
		data_n = din;
end
endmodule

module threebitregister (input logic [2:0] din,
						input logic clk, load, reset, 
						output logic [2:0] dout						
);

logic [2:0] data_n;

always_ff @ (posedge clk)
begin
	dout <= data_n;
end

always_comb begin
	data_n = dout;
	if(reset)
		data_n = 3'b000;
	else if(load)
		data_n = din;
end
endmodule