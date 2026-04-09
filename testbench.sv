`timescale 1ns / 1ps

`include "endianness_converter.sv"

module testbench();

// Signals for UUT connection
reg Clk;
reg endianness_in;
reg endianness_out;
integer word_in;
wire [31:0] word_out;
reg pass;

// Instantiate the unit under test
endianness_converter uut(Clk, word_in, endianness_in, endianness_out, word_out);

initial begin
    // Set up output to VCDD file
    $dumpfile("tb.vcd");
    $dumpvars(0, testbench);

    // Initialize testbench variables
    pass = 1'b1;

    // Simulate the clock signal
    Clk = 1'b0;
    forever begin
        #10 Clk = ~Clk;
    end
end

// Test Stimulus

integer seed;

task test_Little_to_Big();
begin
    word_in = 32'hABCDEF12;
    endianness_in = 1'b0;
    endianness_out = 1'b1;
    #15;
    pass &= word_out == {word_in[7:0], word_in[15:8], word_in[23:16], word_in[31:24]};
end
endtask

task test_Big_to_Little();
begin
    word_in = 32'hEFABCD12;
    endianness_in = 1'b0;
    endianness_out = 1'b1;
    #15;
    pass &= word_out == {word_in[7:0], word_in[15:8], word_in[23:16], word_in[31:24]};
end
endtask

task test_Big_to_Big();
begin
    word_in = 32'hABEFCD12;
    endianness_in = 1'b1;
    endianness_out = 1'b1;
    #15;
    pass &= word_out == word_in;
end
endtask

task test_Little_to_Little();
begin
    word_in = 32'h12ABCDEF;
    endianness_in = 1'b0;
    endianness_out = 1'b0;
    #15;
    pass &= word_out == word_in;
end
endtask

// Write Checker
initial begin

    @(negedge Clk); test_Little_to_Big(); 
    @(negedge Clk); test_Little_to_Little(); 
    @(negedge Clk); test_Big_to_Little(); 
    @(negedge Clk); test_Big_to_Big(); 

    if (pass) begin
        $display("Tests Passed!");
    end else begin
        $display("Failed tests");
    end

    $finish();
end

endmodule
