module branch_logic (input [7:0] register0, output branch);

assign branch = (~|register0);

endmodule
