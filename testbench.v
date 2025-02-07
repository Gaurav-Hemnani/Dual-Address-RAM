module dual_address_ram_tb();

	// Inputs
	reg clk;
	reg wr_en;
	reg [7:0] data_in;
	reg [3:0] addr_in_0;
	reg [3:0] addr_in_1;
	reg port_en_0;
	reg port_en_1;

	// Outputs
	wire [7:0] data_out_0;
	wire [7:0] data_out_1;
	
	integer i;

	// Instantiate the Unit Under Test (UUT)
	dual_address_ram uut (
		.clk(clk), 
		.wr_en(wr_en), 
		.data_in(data_in), 
		.addr_in_0(addr_in_0), 
		.addr_in_1(addr_in_1), 
		.port_en_0(port_en_0), 
		.port_en_1(port_en_1), 
		.data_out_0(data_out_0), 
		.data_out_1(data_out_1)
	);
	
	always begin
	  #5;
	  clk = ~clk;
	end

	initial begin
		// Initialize Inputs
		clk = 1;
		data_in = 0;
		addr_in_0 = 0;
		addr_in_1 = 0;
		wr_en = 1;
		port_en_0 = 1;
		port_en_1 = 1;
		#20;

		for (integer i = 1; i <= 16; i = i + 1) begin
			data_in = i;
			addr_in_0 = i - 1;
			#10;
		end

		for (integer i = 1; i <= 16; i = i + 1) begin
			data_in = 16 - i;
			addr_in_1 = i - 1;
			#10;
		end
			
		// Add stimulus here
		#30;
		port_en_0 = 0;
		port_en_1 = 0;

		for (integer i = 0; i <= 16; i = i + 1) begin
		  addr_in_0 = i;
		  addr_in_1 = i;
		  #20;
		end

		#30;
		$finish;
	end

	initial begin
	  $dumpfile("dump.vcd");
	  $dumpvars(0);
	end
	
endmodule