//clock divider from 50 MHz to 1000 Hz(1 ms)
module clock_divider (Clock, Reset, Pulse_ms);
	input Clock, Reset;
	output reg Pulse_ms;
	reg [14:0] counter;//15 bit because only need to count to 25000
	always @(posedge Clock)
	begin
		counter <= counter+1;
		if (Reset ==1)
		begin
			counter<=0;
			Pulse_ms<=0;
		end
		else if (counter == 25000) //only need to counter to half the time, because inverting clock(so half on;half off)
		begin
			Pulse_ms <= ~Pulse_ms;
			counter<=0;
		end
	end
endmodule
