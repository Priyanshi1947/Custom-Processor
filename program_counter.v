`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2025 16:42:25
// Design Name: 
// Module Name: program_counter
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


module program_counter (
    input clk,
    input reset,
    input [3:0] start_address,
    input branch_enable,
    input halt,
    input [3:0] branch_address,
    output reg [3:0] pc
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= start_address;             // On reset, start from specified address
        end else if (halt) begin
            pc <= pc;                        // Hold PC if halted
        end else if (branch_enable) begin
            pc <= branch_address;            // Branch to new address if triggered
        end else begin
            pc <= pc + 4'b0001;              // Default: increment PC normally
        end
    end

endmodule
