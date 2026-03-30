`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.12.2025 11:55:24
// Design Name: 
// Module Name: clk_gen
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


module clk_gen(
    input   clk_in, 
    output  clk_400mhz, 
    input   reset,
    output  locked
    );

clk_wiz_0 clk_gen_400mhz(
  .clk_out1(clk_400mhz),
  .reset(reset),
  .locked(locked),
  .clk_in1(clk_in)
 );
 
endmodule