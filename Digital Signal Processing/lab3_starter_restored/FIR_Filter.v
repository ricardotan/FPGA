module FIR_Filter(input clock, input wire [15:0] inputSignal, output reg [15:0] outputSignal);

	parameter numTaps=61; //the value found from tutorial (if set 60 in matlab, you get 61 coefficient)

	reg signed[15:0] coeff [numTaps-1:0]; //Note by definition number of coefficients equals numbers of taps
	reg [15:0] taps [numTaps-1:0];
	wire [31:0] addition [numTaps-1:0];

	always @(*)
	begin
		coeff[  0]=        10;
		coeff[  1]=        -0;
		coeff[  2]=       -29;
		coeff[  3]=         0;
		coeff[  4]=        67;
		coeff[  5]=        -0;
		coeff[  6]=      -130;
		coeff[  7]=         0;
		coeff[  8]=       228;
		coeff[  9]=        -0;
		coeff[ 10]=      -366;
		coeff[ 11]=         0;
		coeff[ 12]=       548;
		coeff[ 13]=        -0;
		coeff[ 14]=      -774;
		coeff[ 15]=         0;
		coeff[ 16]=      1038;
		coeff[ 17]=        -0;
		coeff[ 18]=     -1328;
		coeff[ 19]=         0;
		coeff[ 20]=      1628;
		coeff[ 21]=        -0;
		coeff[ 22]=     -1917;
		coeff[ 23]=         0;
		coeff[ 24]=      2173;
		coeff[ 25]=        -0;
		coeff[ 26]=     -2373;
		coeff[ 27]=         0;
		coeff[ 28]=      2502;
		coeff[ 29]=        -0;
		coeff[ 30]=     30222;
		coeff[ 31]=        -0;
		coeff[ 32]=      2502;
		coeff[ 33]=         0;
		coeff[ 34]=     -2373;
		coeff[ 35]=        -0;
		coeff[ 36]=      2173;
		coeff[ 37]=         0;
		coeff[ 38]=     -1917;
		coeff[ 39]=        -0;
		coeff[ 40]=      1628;
		coeff[ 41]=         0;
		coeff[ 42]=     -1328;
		coeff[ 43]=        -0;
		coeff[ 44]=      1038;
		coeff[ 45]=         0;
		coeff[ 46]=      -774;
		coeff[ 47]=        -0;
		coeff[ 48]=       548;
		coeff[ 49]=         0;
		coeff[ 50]=      -366;
		coeff[ 51]=        -0;
		coeff[ 52]=       228;
		coeff[ 53]=         0;
		coeff[ 54]=      -130;
		coeff[ 55]=        -0;
		coeff[ 56]=        67;
		coeff[ 57]=         0;
		coeff[ 58]=       -29;
		coeff[ 59]=        -0;
		coeff[ 60]=        10;


	end
	
	//since outside of always loop therefore need to use generate statement
	//multiplying the the tapped line by the its corresponding coefficients
	generate
	genvar i;
	for (i=0;i<numTaps;i=i+1)
		begin:multiply
		multiplier multiply(.dataa(coeff[i]),.datab(taps[i]), .result(addition[i]));	
		end
	endgenerate
	
	//creating the tapped line
	//esentially working backwards the most delayed line, is delayed from the line before that and so on...
	integer j;
	always @(posedge clock)
	begin
		for (j=numTaps-1;j>0;j=j-1)
		begin
			taps[j] = taps[j-1];
		end
		taps[0]= inputSignal; 
	
	
		//summing it all together
		outputSignal=0;
		for(j=0;j<numTaps;j=j+1)
		begin
			outputSignal=outputSignal+(addition[j] >>>15);//>>> divide by 2^15 and making sure that sign bit is still kept the way it is 
		
		end
	end

endmodule
