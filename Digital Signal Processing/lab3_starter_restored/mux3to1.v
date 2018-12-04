module mux3to1(input0,input1,input2,select,out);
	input[15:0] input0,input1,input2; 
	input [1:0] select;
	output reg [15:0] out;
	
	always @(*)
		begin
			case(select)
				2'b00: 	out = input0;
				2'b01:	out = input1;
				2'b10:	out = input2;
				2'b11:	out = input2; //there is one extra input since 2 bits,so by default I define it going to input2
			endcase
		end

endmodule
