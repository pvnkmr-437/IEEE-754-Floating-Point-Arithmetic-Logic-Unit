`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.06.2024 07:33:35
// Design Name: 
// Module Name: falu
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


module falu(
    input [15:0] a,
    input [15:0] b,
    input [1:0] op,
    output reg [15:0] result
    );
    wire[15:0] add_sub_out,mul_out,div_out;
    add_sub add1(.a(a),.b(b),.sub(op[0]),.out(add_sub_out));
    mul mul1(.a(a),.b(b),.out(mul_out));
    div div1(.a(a),.b(b),.out(div_out));
    
    always @ (*) begin
    case(op)
        2'b00 : begin
                    assign result = add_sub_out;
                end
        2'b01 : begin
                    assign result = add_sub_out;
                end
        2'b10 : begin
                    assign result = mul_out;
                end
        2'b11 : begin
                    assign result = div_out;
                end
        default : begin
                    assign result = 16'bx;
                end
    endcase
    end
endmodule
