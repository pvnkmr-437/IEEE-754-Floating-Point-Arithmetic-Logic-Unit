`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.06.2024 07:33:35
// Design Name: 
// Module Name: mul
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


module mul(
input[15:0] a,
input[15:0] b,
output[15:0] out);
    
    wire sign_a, sign_b;
    wire [4:0] exp_a, exp_b;
    reg [5:0] exp_sum;
    wire [10:0] man_a, man_b;
    reg [21:0] man_res;
    reg sign_res;

    assign sign_a = a[15];
    assign sign_b = b[15];
    assign exp_a = a[14:10];
    assign exp_b = b[14:10];
    assign man_a = {1'b1, a[9:0]};
    assign man_b = {1'b1, b[9:0]};
    
    always @ (*) begin
    sign_res = sign_a ^ sign_b;
    exp_sum = exp_a + exp_b - 5'b01111 + 1'b1;
    man_res = man_a * man_b;
    
    if (exp_a == 0 || exp_b == 0) begin
        exp_sum = 0;
        sign_res = 0;
        man_res = 0;
    end
    else begin
    while (man_res[21] != 1'b1)
        begin
        man_res = man_res << 1;
        exp_sum = exp_sum - 1;
        end
    end
    end
    assign out = {sign_res,exp_sum[4:0],man_res[20:11]};
endmodule
