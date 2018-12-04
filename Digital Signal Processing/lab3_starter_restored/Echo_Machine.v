module Echo_Machine(input clock, input wire [15:0] inputSignal, output reg [15:0] outputSignal);
	
	//Note the model used here is like the one from figure 4c of the lab manual
	reg[15:0] outputTap; //signal that is directly obtained from output
	wire[15:0] delayed; //after the outputTap signal has been delayed
	reg[15:0] delayedAttentuate; //the delayed signal attenuated(divided by powers of 2)
	
	
	// <= is a non blocking assignment which means that it will get the data that it is assigning at the beginning(without any changes made)
	// so in this case getting outputSignal initially, for more exlantion on this check the textbook for example
	always @(posedge clock)
	begin
		outputTap <= outputSignal;
		delayedAttentuate <= {{2{delayed[15]}},delayed[15:2]};
		//the {} means concatenation, in this case the first two bits of delayedAttentuate is delayed[15] which is the signed bits
		//and the last 13 bits are bits 15 to bit 2 of delayed, this is essentially a right shift by 2(division by 4), in this case
		//as we shift to the right the MSBs are stuffed with the delayed's signed bit, this means ensures that as we divide/right shift
		//we maintain the correct sign.
		
		outputSignal = inputSignal + delayedAttentuate;
		// = is a blocking assignment, it is used in this case because I want the newly modified delayedAttentuate
	end
	
	//creating the delay(using a shift register)
	//the input to the delay box is the outputTap, and once it gets out it becomes delayed(just like the same suggests)
	shiftregister shift(.clock(clock),.shiftin(outputTap), .shiftout(delayed));
endmodule
