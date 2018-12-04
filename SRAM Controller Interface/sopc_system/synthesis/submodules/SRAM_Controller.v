/*****************************************************************************
 *                                                                           *
 * Module:       SRAM_Controller                                             *
 * Description:                                                              *
 *      This module is used for the sram controller for 3TB4 lab 4           *
 *                                                                           *
 *****************************************************************************/

module SRAM_Controller (
input           clk,
input				 reset_n,
input		[17:0]	address,
input				chipselect,
input		[1:0]	byte_enable,
input				read,
input				write,
input		[15:0]	write_data,

// Bidirectionals
inout	reg	[15:0]	SRAM_DQ,

// Outputs
output reg	[15:0]	read_data,

output		[17:0]	SRAM_ADDR,

output	reg		SRAM_CE_N,
output				SRAM_WE_N,
output				SRAM_OE_N,
output				SRAM_UB_N,
output				SRAM_LB_N
);

assign SRAM_ADDR = address;
assign SRAM_WE_N = !(write); //need the ! because these are active-lows
assign SRAM_OE_N = !(read);
assign SRAM_UB_N = !(byte_enable[1]);
assign SRAM_LB_N = !(byte_enable[0]);
	
	
	
	always @ (posedge clk) 
	begin
		SRAM_CE_N = !(chipselect);
		
		if (chipselect) 
		begin
			//reading
			if (read)
				read_data <= SRAM_DQ;
			else
				read_data = 16'bzzzzzzzzzzzzzzzz; //high impedance
			
			//writing
			if (write)
				SRAM_DQ <= write_data; //allowed writing data
			else
				SRAM_DQ = 16'bzzzzzzzzzzzzzzzz;  //high impedance
		end
	end

endmodule

