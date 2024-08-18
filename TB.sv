`timescale 1ns / 1ns

module TB();
logic serIn,clk,rst;
wire outValid,error;
wire [1:0] d;
wire [3:0] p;
MSSD CUT(serIn,clk,rst,d,p,outValid,error);
initial begin
rst = 1'b1;
#1  clk = 1'b0;
    serIn = 1'b1;
#3 rst = 1'b0;
    serIn = 1'b1;
   for (int i = 0; i < 72; i++) begin
    serIn = $random();
        #10;
    end
    #100 $stop;
end

always #3 clk = ~clk;
endmodule