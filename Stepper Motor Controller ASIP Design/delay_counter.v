module delay_counter (input clk, reset_n, start, enable, input [7:0] delay, output done);
parameter BASIC_PERIOD=19'd500000;

// for 50 MHz clock,  500,000 clock cycle, that is 19'd500000.


reg [7:0] downcounter/*synthesis keep*/;
reg [18:0] timer/*synthesis keep*/;

always @( posedge clk)
	begin
		if (!reset_n)
			begin
				timer<=19'd0;//14'b00000000000000;
				downcounter<=8'h00;
			end
		else if (start==1'b1)
			begin
				timer<=19'd0;
				downcounter<=delay;
			end
		else if (enable==1'b1)
			begin
				if (timer<BASIC_PERIOD)
				timer<=timer+19'd1;//14'b00000000000001;
//Once the specified amount of time has expired, the module asserts the delay_done signal
				else
					begin
						downcounter<=downcounter-8'b1;
						timer<=19'd0;//14'b00000000000000;
					end
			end
	end
assign done=(downcounter==8'b00000000)?1'b1:1'b0;



endmodule
