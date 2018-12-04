module lab2 (input CLOCK_50, input [2:0] KEY, output wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);

	//using a not because by default when KEY is not pressed it is a 1, and when it is pressed a 0. But want to switch that.
	assign reset = !KEY[0];
	assign start = !KEY[1];
	assign stop  = !KEY[2];
	wire [6:0] num0,num1,num2,num3,num4,num5,num6,num7;
	wire clock;
 
	clock_divider pulse(CLOCK_50,reset,clock);
	control_ff starting(clock,start,Set,Clear, start);
	hex_counter count(clock,reset,start,stop,hexnumbers);
	hex_to_bcd_converter (clock,reset,hexnumbers,num0,num1,num2,num3,num4,num5,num6,num7);
	seven_seg_decoder dig_0(num0,HEX0);
	seven_seg_decoder dig_1(num1,HEX1);
	seven_seg_decoder dig_2(num2,HEX2);
	seven_seg_decoder dig_3(num3,HEX3);
	seven_seg_decoder dig_4(num4,HEX4);
	seven_seg_decoder dig_5(num6,HEX5);
	seven_seg_decoder dig_6(num6,HEX6);
	seven_seg_decoder dig_7(num7,HEX7);


endmodule
