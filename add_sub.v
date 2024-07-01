`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.06.2024 07:33:35
// Design Name: 
// Module Name: add_sub
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

module add_sub(
    input [15:0] a,
    input [15:0] b,
    input sub,
    output [15:0] out
);
    wire sign_a, sign_b;
    wire [4:0] exp_a, exp_b;
    reg [4:0] exp_dif, exp_common;
    wire [10:0] man_a, man_b;
    reg [10:0] man_a_shift, man_b_shift;
    reg [11:0] man_res;
    reg sign_res;

    assign sign_a = a[15];
    assign sign_b = b[15] ^ sub;
    assign exp_a = a[14:10];
    assign exp_b = b[14:10];
    assign man_a = {1'b1, a[9:0]};
    assign man_b = {1'b1, b[9:0]};

    always @(*) begin
        exp_dif = (exp_a > exp_b) ? (exp_a - exp_b) : (exp_b - exp_a);
        man_a_shift = (exp_a > exp_b) ? (man_a) : (man_a >> exp_dif);
        man_b_shift = (exp_b > exp_a) ? (man_b) : (man_b >> exp_dif);
        man_res = (sign_a == sign_b) ? (man_a_shift + man_b_shift) : 
                  ((man_a_shift >= man_b_shift) ? (man_a_shift - man_b_shift) : (man_b_shift - man_a_shift));
        exp_common = (exp_a > exp_b) ? (exp_a) : (exp_b);
        exp_common = exp_common + 1;
        sign_res = (sign_a == sign_b) ? (sign_a) : ((man_a_shift >= man_b_shift) ? (sign_a) : (sign_b));

        while (man_res[11] != 1'b1 && exp_common > 0) begin
            man_res = man_res << 1;
            exp_common = exp_common - 1;
        end
        if (man_res == 12'b0) begin
            exp_common = 0;
            sign_res = 0;
        end
    end

    assign out = {sign_res, exp_common, man_res[10:1]};
endmodule