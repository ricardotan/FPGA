module dsp_subsystem (input sample_clock,  input reset, input [1:0] selector, input [15:0] input_sample, output [15:0] output_sample);

wire [15:0] output_untouched, output_fir, output_echo;
assign output_untouched = input_sample;

mux3to1 choose(.input0(output_untouched),.input1(output_fir),.input2(output_echo),.select(selector),.out(output_sample));
FIR_Filter fir(.clock(sample_clock),.inputSignal(input_sample),.outputSignal(output_fir));
Echo_Machine echo(.clock(sample_clock),.inputSignal(input_sample),.outputSignal(output_echo));

endmodule
