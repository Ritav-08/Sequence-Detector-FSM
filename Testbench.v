//Timing error due to Non blocking at always and use at $monitor, Need to fix...

`timescale 1ns / 1ps

module tb_sdFSM1011 ();
reg clk_ti;
reg rst_ti;
reg data_ti;
wire dout_to;

//instantiation
sdFSM1011 DUT ( .rst_i(rst_ti), 
.clk_i(clk_ti), 
.data_i(data_ti), 
.dout_o(dout_to)
);

//reg(s)
reg [3:0] sequence = 4'b0;

//clock
initial begin
clk_ti = 1'b0;
forever #5 clk_ti = ~clk_ti;
end

//Feeding
initial begin
data_ti = 1'b0;
rst_ti = 1'b1;
#3 rst_ti = 1'b0;
repeat(10) #10 data_ti = $urandom_range(0, 1);
#10 data_ti = 1'b1;
#10 data_ti = 1'b0;
#10 data_ti = 1'b1;
#10 data_ti = 1'b1;
#10 data_ti = 1'b0;
#10 data_ti = 1'b1;
#10 data_ti = 1'b1;
#10 data_ti = 1'b1;
#10 data_ti = 1'b0;
#10 data_ti = 1'b1;
#10 data_ti = 1'b0;
#5 $display ("Simulation End");
$finish;
end

always@(posedge clk_ti) begin 
sequence <= {sequence[2:0], data_ti};
end

//capture
initial begin
$monitor ("Time: %0t | Clk: %b, Rst: %b | Sequence: %0b | Detection: %0b", 
           $time,      clk_ti,  rst_ti,   sequence,       dout_to);
$dumpfile("MooreFSM.vcd");
$dumpvars(0, tb_sdFSM1011);
end

endmodule