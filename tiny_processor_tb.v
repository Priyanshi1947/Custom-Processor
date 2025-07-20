`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2025 17:27:06
// Design Name: 
// Module Name: tiny_processor_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Testbench for: tiny_processor
// Validates: Full processor flow including MOV, ADD, RET, branching and HALT
//////////////////////////////////////////////////////////////////////////////////

module tiny_processor_tb;

    reg clk;
    reg reset;
    wire [7:0] acc_out;
    wire [3:0] pc;
    wire [7:0] ir_out;
    wire alu_enable_out, reg_write_out;
    wire [7:0] alu_opcode_out;
    wire [7:0] instruction_out;
    wire [7:0] result_out;
    wire [7:0] ext_out;
    wire [7:0] reg_data_out;
    wire cb_out;

    // Instantiate Processor
    tiny_processor uut (
        .clk(clk),
        .reset(reset),
        .start_address(4'b0000),
        .acc_out(acc_out),
        .pc(pc),
        .ir_out(ir_out),
        .alu_enable_out(alu_enable_out),
        .reg_write_out(reg_write_out),
        .alu_opcode_out(alu_opcode_out),
        .instruction_out(instruction_out),
        .result_out(result_out),
        .ext_out(ext_out),
        .reg_data_out(reg_data_out),
        .cb_out(cb_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Simulation routine
    initial begin
        $dumpfile("tiny_processor_tb.vcd");
        $dumpvars(0, tiny_processor_tb);

        // Reset sequence
        reset = 1;
        #15;
        reset = 0;

        // Run for enough cycles to cover all instructions
        #200;

        $display("Final ACC Value: %b", acc_out);
        $display("Final PC Value : %b", pc);

        $finish;
    end

endmodule