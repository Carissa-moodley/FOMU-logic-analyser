module top(
	input clock,
	input wire [3:0] we,
	input wire [15:0] addr,
	input wire [15:0] data_in,
	output wire [15:0] data_out );
	
	reg [31:0] counter = 0;
	SB_SPRAM256KA spram_inst (
		.ADDRESS(addr),
		.DATAIN(data_in),
		.MASKWREN(4'b1111),
		.WREN(we),
		.CHIPSELECT(1'b1),
		.CLOCK(clk),
		.STANDBY(1'b0),
		.SLEEP(1'b0),
		.POWEROFF(1'b1),
		.DATAOUT(data_out)
	);
	always @(posedge clock)
	begin
		we <= 1'b0;
		
		addr <= 16'b00;
		data_in <= 16'b001;
		
		counter <= counter + 1'b1;
		//increment address every sec @ 12MHz
		if(counter == 32'h1000000) begin
			addr <= addr + 1;
			data_in <= data_in +1;
			we <= 1'b1;
		end
		
		//wait two cycles to have data
		if (counter == 32'h1000002) begin
			counter <= 0;
			
		end

	end
	
	
endmodule
