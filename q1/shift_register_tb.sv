`timescale 1ns/1ps

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

  shifter_register #(N) dut (
    .clk(clk),
    .rst_n(rst_n),
    .serial_parallel(serial_parallel),
    .load_enable(load_enable),
    .serial_in(serial_in),
    .parallel_in(parallel_in),
    .parallel_out(parallel_out),
    .serial_out(serial_out)
  );

  initial clk = 0;
  always #5 clk = ~clk;

  task serial_shift(input bit din);
    begin
      @(negedge clk);
      load_enable     = 1;
      serial_parallel = 0;
      serial_in       = din;
      @(posedge clk);
      $display("[%0t] Serial In=%0b, Serial Out=%0b, Reg=%0b", 
                $time, din, serial_out, parallel_out);
    end
  endtask

  task parallel_load(input logic [N-1:0] din);
    begin
      @(negedge clk);
      load_enable     = 1;
      serial_parallel = 1;
      parallel_in     = din;
      @(posedge clk);
      $display("[%0t] Parallel In=%0b, Serial Out=%0b, Reg=%0b", 
                $time, din, serial_out, parallel_out);
    end
  endtask

  initial begin
    rst_n = 0;
    load_enable = 0;
    serial_parallel = 0;
    serial_in = 0;
    parallel_in = 0;

    #12 rst_n = 1;

    serial_shift(1);
    serial_shift(0);
    serial_shift(1);
    serial_shift(1);

    parallel_load(4'b1010);

    serial_shift(1);
    serial_shift(1);
    serial_shift(0);

    parallel_load(4'b1111);

    #20 $finish;
  end

endmodule
