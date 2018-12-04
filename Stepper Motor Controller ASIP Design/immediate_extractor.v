module immediate_extractor (input [7:0] instruction, input [1:0] select, output reg [7:0] immediate);

	always @(*)
		begin
		case (select)
			2'b00: immediate = {5'b0, instruction[4:2]};
			2'b01: immediate = {4'b0, instruction[3:0]};
			2'b10: immediate = {{3{instruction[4]}}, instruction[4:0]};
			2'b11: immediate = 8'b0;
		endcase
		end

endmodule
