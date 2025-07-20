`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2025 16:57:41
// Design Name: 
// Module Name: instruction_decoder
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


module instruction_decoder (
    input [7:0] opcode,
    output reg alu_enable,
    output reg reg_write,
    output reg branch_enable,
    output reg halt,
    
    output reg [7:0] alu_opcode
);
    always @(*) begin
        alu_enable = 0;
        reg_write = 0;
        branch_enable = 0;
        halt = 0;
        alu_opcode = 8'b00000000;
        
        casex (opcode)
            8'b0000xxxx: begin
                alu_enable = 1;
                alu_opcode = opcode;
            end
            8'b0001xxxx: begin
                alu_enable = 1;
                alu_opcode = opcode;
            end
            8'b0010xxxx: begin
                alu_enable = 1;
                alu_opcode = opcode;
            end
            8'b0011xxxx: begin
                alu_enable = 1;
                alu_opcode = opcode;
            end
            8'b0101xxxx: begin
                alu_enable = 1;
                alu_opcode = opcode;
            end
            8'b0110xxxx: begin
                alu_enable = 1;
                alu_opcode = opcode;
            end
            8'b1001xxxx: begin // MOV ACC, Ri
                alu_enable = 1;
                alu_opcode = opcode;
            end
            8'b1010xxxx: begin // MOV Ri, ACC
                reg_write = 1;

            end
            8'b1011xxxx: begin // RET (branch to return address)
                branch_enable = 1;
            end
            8'b1100xxxx: begin // BRANCH to ir[3:0]
                branch_enable = 1;
            end

            8'b11111111: begin // HLT
                halt = 1;
            end
            default: begin
                alu_enable = 0;
                alu_opcode = 8'b00000000;
            end
        endcase
    end
endmodule
