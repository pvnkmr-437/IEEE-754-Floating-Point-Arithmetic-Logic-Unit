`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.06.2024 07:33:35
// Design Name: 
// Module Name: falu_tb
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


module falu_tb;
    
    reg [15:0] a;
    reg [15:0] b;
    reg [1:0] op;
    wire [15:0] result;

    
    falu uut (
        .a(a),
        .b(b),
        .op(op),
        .result(result)
    );

    
    task display_results;
        input [15:0] a;
        input [15:0] b;
        input [1:0] op;
        input [15:0] result;
        begin
            $display("a = %h, b = %h, op = %b, result = %h", a, b, op, result);
        end
    endtask

    
    initial begin
        $display("Starting Testbench...");

        // Test addition
        op = 2'b00;
        // Positive + Positive
        a = 16'h3C00; // 1.0 in half-precision
        b = 16'h4000; // 2.0 in half-precision
        #10; display_results(a, b, op, result);

        // Positive + Negative
        a = 16'h3C00; // 1.0 in half-precision
        b = 16'hC000; // -2.0 in half-precision
        #10; display_results(a, b, op, result);

        // Negative + Negative
        a = 16'hBC00; // -1.0 in half-precision
        b = 16'hC000; // -2.0 in half-precision
        #10; display_results(a, b, op, result);

        // Zero + Positive
        a = 16'h0000; // 0.0 in half-precision
        b = 16'h4000; // 2.0 in half-precision
        #10; display_results(a, b, op, result);

        // Zero + Zero
        a = 16'h0000; // 0.0 in half-precision
        b = 16'h0000; // 0.0 in half-precision
        #10; display_results(a, b, op, result);

        // Test subtraction
        op = 2'b01;
        // Positive - Positive
        a = 16'h4000; // 2.0 in half-precision
        b = 16'h3C00; // 1.0 in half-precision
        #10; display_results(a, b, op, result);

        // Positive - Negative
        a = 16'h3C00; // 1.0 in half-precision
        b = 16'hBC00; // -1.0 in half-precision
        #10; display_results(a, b, op, result);

        // Negative - Negative
        a = 16'hBC00; // -1.0 in half-precision
        b = 16'hC000; // -2.0 in half-precision
        #10; display_results(a, b, op, result);

        // Zero - Positive
        a = 16'h0000; // 0.0 in half-precision
        b = 16'h4000; // 2.0 in half-precision
        #10; display_results(a, b, op, result);

        // Zero - Zero
        a = 16'h0000; // 0.0 in half-precision
        b = 16'h0000; // 0.0 in half-precision
        #10; display_results(a, b, op, result);

        // Test multiplication
        op = 2'b10;
        // Positive * Positive
        a = 16'h3C00; // 1.0 in half-precision
        b = 16'h4000; // 2.0 in half-precision
        #10; display_results(a, b, op, result);

        // Positive * Negative
        a = 16'h3C00; // 1.0 in half-precision
        b = 16'hC000; // -2.0 in half-precision
        #10; display_results(a, b, op, result);

        // Negative * Negative
        a = 16'hBC00; // -1.0 in half-precision
        b = 16'hC000; // -2.0 in half-precision
        #10; display_results(a, b, op, result);

        // Zero * Positive
        a = 16'h0000; // 0.0 in half-precision
        b = 16'h4000; // 2.0 in half-precision
        #10; display_results(a, b, op, result);

        // Zero * Zero
        a = 16'h0000; // 0.0 in half-precision
        b = 16'h0000; // 0.0 in half-precision
        #10; display_results(a, b, op, result);

        // Test division
        op = 2'b11;
        // Positive / Positive
        a = 16'h4000; // 2.0 in half-precision
        b = 16'h3C00; // 1.0 in half-precision
        #10; display_results(a, b, op, result);

        // Positive / Negative
        a = 16'h4000; // 2.0 in half-precision
        b = 16'hBC00; // -1.0 in half-precision
        #10; display_results(a, b, op, result);

        // Negative / Negative
        a = 16'hBC00; // -1.0 in half-precision
        b = 16'hC000; // -2.0 in half-precision
        #10; display_results(a, b, op, result);

        // Zero / Positive
        a = 16'h0000; // 0.0 in half-precision
        b = 16'h4000; // 2.0 in half-precision
        #10; display_results(a, b, op, result);

        // Zero / Zero
        a = 16'h0000; // 0.0 in half-precision
        b = 16'h0000; // 0.0 in half-precision
        #10; display_results(a, b, op, result);

        // Positive / Zero
        a = 16'h4000; // 2.0 in half-precision
        b = 16'h0000; // 0.0 in half-precision
        #10; display_results(a, b, op, result);

        // Test special cases
        // Infinity
        a = 16'h7C00; // +Infinity in half-precision
        b = 16'h3C00; // 1.0 in half-precision
        op = 2'b11;   // Division
        #10; display_results(a, b, op, result);

        // NaN
        a = 16'h7C01; // NaN in half-precision
        b = 16'h4000; // 2.0 in half-precision
        op = 2'b00;   // Addition
        #10; display_results(a, b, op, result);

        $display("Testbench completed.");
        $stop;
    end
endmodule