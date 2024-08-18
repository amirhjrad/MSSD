`timescale 1ns/1ns
module SRTB();
	logic clk,rst,en,si,ld;
	wire [5:0] po;
	wire so;
	ShiftRegister6bit T1(clk,rst,en,si,ld,so,po);
	always begin
    	#5 clk = ~clk;
  	end
	initial begin
	clk = 0;
	en =1;
	#10 ld = 1;
	#10 ld = 0;
	    for (int i = 0; i < 8 * 8; i++) begin
       		si = $random();
        	#10;
  	    end
	$stop;
	end
	
endmodule
