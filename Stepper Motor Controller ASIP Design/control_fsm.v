
module control_fsm (
	input clk, reset_n,
	// Status inputs
	input br, brz, addi, subi, sr0, srh0, clr, mov, mova, movr, movrhs, pause,
	input delay_done,
	input temp_is_positive, temp_is_negative, temp_is_zero,
	input register0_is_zero,
	// Control signal outputs
	output reg write_reg_file,
	output reg result_mux_select,
	output reg [1:0] op1_mux_select, op2_mux_select,
	output reg start_delay_counter, enable_delay_counter,
	output reg commit_branch, increment_pc,
	output reg alu_add_sub, alu_set_low, alu_set_high,
	output reg load_temp_register, increment_temp_register, decrement_temp_register,
	output reg [1:0] select_immediate,
	output reg [1:0] select_write_address
	
);
parameter RESET=5'b00000, FETCH=5'b00001, DECODE=5'b00010,
			BR=5'b00011, BRZ=5'b00100, ADDI=5'b00101, SUBI=5'b00110, SR0=5'b00111,
			SRH0=5'b01000, CLR=5'b01001, MOV=5'b01010, MOVA=5'b01011,
			MOVR=5'b01100, MOVRHS=5'b01101, PAUSE=5'b01110, MOVR_STAGE2=5'b01111,
			MOVR_DELAY=5'b10000, MOVRHS_STAGE2=5'b10001, MOVRHS_DELAY=5'b10010,
			PAUSE_DELAY=5'b10011;

reg [5:0] state;
reg [5:0] next_state_logic; // NOT REALLY A REGISTER!!!

// Next state logic
always @(*)
	begin
		case (state)
		RESET:
			next_state_logic = FETCH;
		FETCH:
			next_state_logic = DECODE;
		DECODE:
			begin
			if (addi)
			next_state_logic = ADDI;
			else if (subi)
			next_state_logic = SUBI;
			else if (br)
			next_state_logic = BR;
			else if (brz)
			next_state_logic = BRZ;
			else if (sr0)
			next_state_logic = SR0;
			else if (srh0)
			next_state_logic = SRH0;
			else if (clr)
			next_state_logic = CLR;
			else if (mov)
			next_state_logic = MOV;
			else if (mova)
			next_state_logic = MOVA;
			else if (movr)
			next_state_logic = MOVR;
			else if (movrhs)
			next_state_logic = MOVRHS;
			else if (pause)
			next_state_logic = PAUSE;
			else next_state_logic = RESET;
			end
		/* ----- 3.27 implemented ------*/
		ADDI:
			next_state_logic = FETCH;
		SUBI:
			next_state_logic = FETCH;
		MOV:
			next_state_logic = FETCH;
		SR0:
			next_state_logic = FETCH;
		SRH0:
			next_state_logic = FETCH;
		CLR:
			next_state_logic = FETCH;
		BR:
			next_state_logic = FETCH;
		BRZ:
			next_state_logic = FETCH;
		//MOVR
		MOVR:
			next_state_logic = MOVR_STAGE2;
		MOVR_STAGE2:
			begin
			if (temp_is_zero)
				next_state_logic = FETCH;
			else
				next_state_logic = MOVR_DELAY;
			end
		MOVR_DELAY:
			begin
			if (delay_done)
				next_state_logic = MOVR_STAGE2;
			else
				next_state_logic = MOVR_DELAY;
			end
		//MOVRHS
		MOVRHS:
			next_state_logic = MOVR_STAGE2;
		MOVRHS_STAGE2:
			begin
			if (temp_is_zero)
				next_state_logic = FETCH;
			else
				next_state_logic = MOVRHS_DELAY;
			end
		MOVRHS_DELAY:
			begin
			if (delay_done)
				next_state_logic = MOVRHS_STAGE2;
			else
				next_state_logic = MOVRHS_DELAY;
			end
		
		/*-------3.29 implemented--------*/
		PAUSE:
			next_state_logic = PAUSE_DELAY;
		/*------3.29-----*/
		PAUSE_DELAY:
			begin
			if (delay_done)
				next_state_logic = FETCH;
			else
				next_state_logic = PAUSE_DELAY;
			end
		/* -----------------------------*/
		
		default:
			next_state_logic = RESET;
			
		endcase
	end


// State register
always @ (posedge clk)
	begin
		if (!reset_n)
			state <= RESET;
		else 
			state <= next_state_logic;
	end

// Output logic

always @(*)////????
	begin
		// Convenient way to avoid having to specify all the
		// signals for all cases
		write_reg_file = 1'b0;
		result_mux_select = 1'b0;
		op1_mux_select = 2'b00;
		op2_mux_select = 2'b00;
		start_delay_counter = 1'b0;
		enable_delay_counter = 1'b0;
		commit_branch = 1'b0;
		increment_pc = 1'b0;
		alu_add_sub = 1'b0;
		alu_set_low = 1'b0;
		alu_set_high = 1'b0;
		load_temp_register = 1'b0;
		increment_temp_register = 1'b0;
		decrement_temp_register = 1'b0;
		select_immediate = 2'b00;
		select_write_address = 2'b00;
		
		case (state)
		ADDI:
			begin
				// Beware! The next line might be different in your system
				select_immediate = 2'b00;
				/*  	00 --> imm3
						01 --> imm4
						10 --> imm5
				*/
				op1_mux_select = 2'b01;
				op2_mux_select = 2'b01;
				alu_add_sub = 1'b0;
				// Beware! The next line might be different in your system
				result_mux_select = 1'b1;
				/*  	0 --> 8'b0
						1 --> alu_result
				*/
				write_reg_file = 1'b1;
				select_write_address = 2'b01;
				increment_pc = 1'b1;
			end
		SUBI:
			begin
				select_immediate = 2'b00;
				/*  	00 --> imm3
						01 --> imm4
						10 --> imm5
				*/
				op1_mux_select = 2'b01;
				op2_mux_select = 2'b01;
				alu_add_sub = 1'b1;//subtract

				result_mux_select = 1'b1;
				/*  	0 --> 8'b0
						1 --> alu_result
				*/
				write_reg_file = 1'b1;
				select_write_address = 2'b01;
				increment_pc = 1'b1;
			end
		MOV:
			begin
				op1_mux_select = 2'b01;
				op2_mux_select = 2'b01;
				select_immediate = 2'b11;//8'b0
				alu_add_sub = 1'b0;
				
				result_mux_select = 1'b1;
				write_reg_file = 1'b1;
				select_write_address = 2'b10;
				increment_pc = 1'b1;
			end
		SR0:
			begin
				select_immediate = 2'b01;
				op1_mux_select = 2'b11;//operanda
				op2_mux_select = 2'b01;//opreandb
				alu_set_low = 1'b1;
				
				result_mux_select = 1'b1;
				write_reg_file = 1'b1;
				select_write_address = 2'b00;
				increment_pc = 1'b1;
			end
		SRH0:
			begin
				select_immediate = 2'b01;
				op1_mux_select = 2'b11;//operanda
				op2_mux_select = 2'b01;//opreandb
				alu_set_high = 1'b1;
				
				result_mux_select = 1'b1;
				write_reg_file = 1'b1;
				select_write_address = 2'b00;
				increment_pc = 1'b1;
			end
		CLR:
			begin
				result_mux_select = 1'b0;//8'b0
				write_reg_file = 1'b1;
				select_write_address = 2'b01;
				increment_pc = 1'b1;
			end
		BR:
			begin
				select_immediate = 2'b10;//imm5
				op1_mux_select = 2'b00;//pc
				op2_mux_select = 2'b01;//imm5
				alu_add_sub = 1'b0;//add

				commit_branch = 1'b1;
			end
		//pg 72, note5
		BRZ:
			begin
				if (register0_is_zero) begin
					op1_mux_select = 2'b00;
					op2_mux_select = 2'b01;
					select_immediate = 2'b10;
					/*  	00 --> imm3
							01 --> imm4
							10 --> imm5
					*/
					alu_add_sub = 1'b0;
					commit_branch = 1'b1;
				end
				else
					increment_pc = 1'b1;
			end
			
		MOVR:
			begin
				load_temp_register = 1'b1;
			end
		
		MOVR_STAGE2:
			begin//0
					if (temp_is_zero)
						increment_pc = 1'b1;
					else
						begin
						if (temp_is_positive)
							begin//2
							decrement_temp_register = 1'b1;
							op1_mux_select = 2'b10;
							op2_mux_select = 2'b11;
							alu_add_sub = 1'b0;
							
							result_mux_select = 1'b1;
							select_write_address = 2'b11;
							write_reg_file = 1'b1;
							end//2
						else if (temp_is_negative)
							begin//1
							increment_temp_register = 1'b1;
							op1_mux_select = 2'b10;
							op2_mux_select = 2'b11;
							alu_add_sub = 1'b1;
							
							result_mux_select = 1'b1;
							select_write_address = 2'b11;
							write_reg_file = 1'b1;								
							end//1
						start_delay_counter = 1'b1;
						end
			end//0
		
		MOVR_DELAY:
			begin
				enable_delay_counter = 1'b1;
			end
		MOVRHS:
			begin
				load_temp_register = 1'b1;
			end
		MOVRHS_STAGE2:
			begin
				if (temp_is_zero)
					increment_pc = 1'b1;
				else
					begin
					if (temp_is_positive)
						begin
							decrement_temp_register = 1'b1;
							op1_mux_select = 2'b10;//R2
							op2_mux_select = 2'b10;//1
							alu_add_sub = 1'b0;//add
							
							result_mux_select = 1'b1;
							select_write_address = 2'b11;//2
							write_reg_file = 1'b1;
						end
					else 
						begin
							increment_temp_register = 1'b1;
							op1_mux_select = 2'b10;
							op2_mux_select = 2'b10;//1
							alu_add_sub = 1'b1;//subtract
							
							result_mux_select = 1'b1;
							select_write_address = 2'b11;
							write_reg_file = 1'b1;		
						end
					start_delay_counter = 1'b1;
					end
			end
		MOVRHS_DELAY:
			begin
				enable_delay_counter = 1'b1;
			end
		PAUSE:
			start_delay_counter = 1'b1;
		PAUSE_DELAY:
			begin
			enable_delay_counter = 1'b1;
			if (delay_done)
				increment_pc = 1'b1;
			end
		endcase
	end


endmodule
