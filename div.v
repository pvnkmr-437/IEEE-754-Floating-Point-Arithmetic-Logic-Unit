`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.06.2024 07:33:35
// Design Name: 
// Module Name: div
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


module div(
    input [15:0] a,
    input [15:0] b,
    output [15:0] out
);

    wire sign_a, sign_b, sign_result;
    wire [4:0] exponent_a, exponent_b, exponent_result;
    wire [10:0] mantissa_a, mantissa_b, mantissa_result;
    reg [15:0] final_result;

    assign sign_a = a[15];
    assign sign_b = b[15];
    assign exponent_a = a[14:10];
    assign exponent_b = b[14:10];
    assign mantissa_a = {1'b1, a[9:0]};
    assign mantissa_b = {1'b1, b[9:0]};

    assign sign_result = sign_a ^ sign_b;

    wire [5:0] exponent_diff;
    assign exponent_diff = exponent_a - exponent_b + 15;
    assign exponent_result = exponent_diff[4:0];

    wire [21:0] mantissa_div;
    assign mantissa_div = (mantissa_a << 11) / mantissa_b;
    assign mantissa_result = mantissa_div[20:10];

    always @(*) begin
        if (exponent_b == 5'b11111) begin
            if (mantissa_b != 0) begin
                final_result = 16'b0111111111111111;
            end else begin
                final_result = 16'b0000000000000000;
            end
        end else if (exponent_a == 5'b11111) begin
            if (mantissa_a != 0) begin
                final_result = 16'b0111111111111111;
            end else begin
                if (exponent_b == 5'b11111 && mantissa_b == 0) begin
                    final_result = 16'b0111111111111111;
                end else begin
                    final_result = {sign_result, 5'b11111, 10'b0000000000};
                end
            end
        end else if (b == 16'b0) begin
            if (a == 16'b0) begin
                final_result = 16'b0111111111111111;
            end else begin
                final_result = {sign_result, 5'b11111, 10'b0000000000};
            end
        end else if (a == 16'b0) begin
            final_result = {sign_result, 5'b00000, 10'b0000000000};
        end else begin
            final_result = {sign_result, exponent_result, mantissa_result[9:0]};
        end
    end

    assign out = final_result;

endmodule