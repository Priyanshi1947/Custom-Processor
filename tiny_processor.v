`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2025 17:10:17
// Design Name: 
// Module Name: tiny_processor
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


module tiny_processor (
    input clk,
    input reset,
    input [3:0] start_address,
    output [7:0] acc_out,
    output [3:0] pc,
    output [7:0] ir_out,
    output alu_enable_out,
    output reg_write_out,
    output [7:0] alu_opcode_out,
    output [7:0] instruction_out,
    output [7:0] result_out,
    output [7:0] ext_out,
    output [7:0] reg_data_out,
    output cb_out
);

    reg [7:0] ir;
    reg [7:0] acc = 8'b00000000;
    reg [3:0] branch_addr;
    reg [3:0] return_address; // ? Save return location
   
    wire alu_enable, reg_write, branch_enable, halt;
    wire [7:0] alu_opcode;
    wire [7:0] instruction;
    wire [7:0] result;
    wire [7:0] ext;
    wire [7:0] reg_data;
    wire cb;

    // Program Counter
    program_counter PC (
        .clk(clk),
        .reset(reset),
        .start_address(start_address),
        .branch_enable(branch_enable),
        .halt(halt),
        .branch_address(branch_addr),
        .pc(pc)
    );

    // Instruction Memory
    instruction_memory IM (
        .addr(pc),
        .data(instruction)
    );

    // Instruction Register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ir <= 8'b0;
        end else if (!halt) begin
            ir <= instruction;
        end
    end

    // Instruction Decoder
    instruction_decoder ID (
        .opcode(ir),
        .alu_enable(alu_enable),
        .reg_write(reg_write),
        .branch_enable(branch_enable),
        .halt(halt),
        .alu_opcode(alu_opcode)
    );

    // Register File
    register_file RF (
        .clk(clk),
        .en(reg_write),
        .addr(ir[3:0]),
        .data_in(acc),
        .data_out(reg_data)
    );

    // ALU
    ALU ALU_inst (
        .operandA(acc),
        .operandB(reg_data),
        .opcode(alu_opcode),
        .result(result),
        .CB(cb),
        .EXT(ext)
    );

    // ? Save return address BEFORE branching
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            return_address <= 4'b0000;
        end else if (branch_enable && (ir[7:4] != 4'b1011)) begin
            // Not a RET - save current PC + 1 to return to
            return_address <= pc + 4'b0001;
        end
    end

    // ? Branch address logic
    always @(*) begin
        if (branch_enable) begin
            // RET instruction ? use saved return address
            if (ir[7:4] == 4'b1011)
                branch_addr = return_address;
            else
                branch_addr = ir[3:0]; // Regular branch jump
        end else begin
            branch_addr = 4'b0000;
        end
    end

    // Accumulator update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            acc <= 8'b0;
        end else if (alu_enable && (ir[7:4] == 4'b1001)) begin
            acc <= reg_data;
        end else if (alu_enable) begin
            acc <= result;
        end
    end

    assign acc_out = acc;
    assign ir_out = ir;
    assign alu_enable_out = alu_enable;
    assign reg_write_out = reg_write;
    assign alu_opcode_out = alu_opcode;
    assign instruction_out = instruction;
    assign result_out = result;
    assign ext_out = ext;
    assign reg_data_out = reg_data;
    assign cb_out = cb;

endmodule