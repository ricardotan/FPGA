module temp_register (input clk, reset_n, load, increment, decrement, input [7:0] data,
					output negative, positive, zero);
reg [7:0] temp;

always @(posedge clk)
	begin
		if (!reset_n)
			temp <= 8'b0;
		if (load == 1'b1)
			temp <= data;
		if (increment == 1'b1)
			temp <= temp + 1;
		if (decrement == 1'b1)
			temp <= temp - 1;
	end

assign negative = temp[7];
assign zero = (temp == 8'b0);
assign positive = (~zero & ~negative);

endmodule
// not sure , copied from lectures