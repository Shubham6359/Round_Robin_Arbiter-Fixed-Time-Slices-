module round_robin_arbiter_fixed_time_slices_tb;
  reg clk;
  reg rst_n;
  reg [3:0] REQ;
  wire [3:0] GNT;

  round_robin_arbiter_fixed_time_slices DUT(.clk(clk),.rst_n(rst_n),.REG(REG),.GNT(GNT));

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    rst_n = 1;
    REG = 4'b0000;

    #10 rst_n = 0;
    #5 rst_n = 1;

    @(negedge clk) REQ = 4'b1000;

    @(negedge clk) REQ = 4'b1010;

    @(negedge clk) REQ = 4'b0010;

    @(negedge clk) REQ = 4'b0110;

    @(negedge clk) REQ = 4'b1110;

    @(negedge clk) REQ = 4'b1111;

    @(negedge clk) REQ = 4'b0100;

    @(negedge clk) REQ = 4'b0010;

    #5 rst_n = 0;
    #100 $finish;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
endmodule
