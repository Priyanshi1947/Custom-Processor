`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2025 16:49:40
// Design Name: 
// Module Name: instruction_memory
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
// Engineer: Priyanshi Shah
// Module Name: Instruction Memory
// Description: 8-bit instruction ROM with branching/return flow
//////////////////////////////////////////////////////////////////////////////////

module instruction_memory (
    input  wire [3:0] addr,
    output reg  [7:0] data
);

    reg [7:0] memory [0:15]; // 16-entry ROM
    integer i;

    initial begin
        // Fill unused locations with NOP
        for (i = 0; i < 16; i = i + 1)
            memory[i] = 8'b00000000;
            
        memory[0] = 8'b00000000; // NOP
        memory[1] = 8'b00000000; // NOP
        memory[2] = 8'b00000000; // NOP
        memory[3] = 8'b00000000; // NOP
        
        memory[4] = 8'b10010001; // MOV ACC, R1        
        memory[5] = 8'b11001010; // BRANCH to address 10 
        memory[6] = 8'b01100001; // XRA R1            
        memory[7] = 8'b10010111; // MOV ACC, R7
        memory[8] = 8'b11111111; // HLT
        
        // Function body placed farther ahead
        memory[10] = 8'b00010010; // ADD R5
        memory[11] = 8'b00010011; // ADD R6
        memory[12] = 8'b10110000; // RET - return to PC = 6
        end

    always @(*) begin
        data = memory[addr]; // Return instruction based on PC
    end
endmodule