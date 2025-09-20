`timescale 1ns / 1ps


module shifter_register_tb;


localparam N = 4;

    logic clk;
    logic rst_n;
    logic serial_parallel;
    logic load_enable;
    logic serial_in;
    logic [N-1:0] parallel_in;
    logic [N-1:0] parallel_out;
    logic serial_out;

shifter_register dut(

.clk(clk),
.rst_n(rst_n),
.serial_parallel(serial_parallel),
.load_enable(load_enable),
.serial_in(serial_in),
.parallel_in(parallel_in),
.parallel_out(parallel_out),
.serial_out(serial_out)

);

always #10 clk = ~clk;


initial begin

#20;
clk = 1'b0;
rst_n = 1'b1;
load_enable = 1'b0;

#5;
rst_n = 1'b0;
load_enable = 1'b1;
serial_parallel = 1'b0;

#1;
rst_n = 1'b1;
serial_in = 1'b0;
parallel_in = 4'b0010;

#10;
serial_in = 1'b0;
parallel_in = 4'b0010;

#10;
serial_in = 1'b1;
parallel_in = 4'b0010;

#10;
serial_in = 1'b1;
parallel_in = 4'b0010;

#10;
serial_in = 1'b1;
parallel_in = 4'b0010;

#10;
serial_parallel = 1'b1;
serial_in = 1'b1;
parallel_in = 4'b1010;

#10;
serial_in = 1'b1;
parallel_in = 4'b1110;

#10;
serial_in = 1'b1;
parallel_in = 4'b1111;

#10;
serial_in = 1'b1;
parallel_in = 4'b0000;

$finish;
end
endmodule
