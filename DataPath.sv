`timescale 1ns/1ns

module ShiftRegister6bit (
input  clk,
input  rst,
input  en,
input  serIn,
output logic so,
output logic [5:0] data_out,w
);
logic [5:0] shift_Logic;
always @(posedge clk , posedge rst) begin
    if (rst)
      shift_Logic <= 6'b100000;
   
    else if (en) begin
       so = shift_Logic[0];
      shift_Logic <= {serIn,shift_Logic[5:1]};
    end
  end
  assign data_out = shift_Logic;
  assign w = data_out;
endmodule






module multiply8(
input [3:0] pi,
input en,
output logic[6:0] po
);
assign po=(en)?{pi[3:0],3'b000}:po;
endmodule







module counter120(
input  clk,
input  rst,
input  en,
output logic [6:0] po
);
always @(posedge clk , posedge rst) begin
    if (rst)
      po <= 7'b0000000;
    else if (en)
        po <= po + 1;
  end
endmodule








module comp(
input [6:0] A,B,
output w
);
assign w = (A>=B)?1'b1:1'b0;
endmodule









module DFF(
input clk,
input rst,
input si,
input en,
output logic w
);
always @(posedge clk , posedge rst) begin
    if (rst)
      w <= 1'b0;
    else if (en)
        w <= si;
  end
endmodule






module tristate(
  input  a,
  input  control,
  output  w
);
  assign w = control ? a : 1'bz;
endmodule







module DCD2to4 (
input  [1:0] s,
input  en,
output  [3:0] po
);
assign po = en ? ((s == 2'b00)? 4'b0001 :
                 (s == 2'b01) ? 4'b0010 :
                 (s == 2'b10) ? 4'b0100 :
                 (s == 2'b11) ? 4'b1000 : 4'b0000) : 1'bx;

endmodule






module downcount(input clk,input rst,input en,output logic cnt);
 logic [2:0] shift_Logic;
  always @(posedge clk , posedge rst) begin
    	if (rst)
      		shift_Logic <= 3'b111;
 	if (en) begin
      		shift_Logic <= shift_Logic - 1;
	cnt = (shift_Logic >= 3'd1)?0:1;
  	end
end
   
   
endmodule



/*module det10(
input clk,
input rst,
input si,
input en,
output w
);
logic [1:0] ps,ns;
always @(ps,si) begin
ns = 2'b00;
case(ps)
2'b00: ns = (si)?2'b01:ns;
2'b01: ns = (~si)?2'b10:ns;
2'b10: ns = (si)?2'b01:2'b00;
default ns = 2'b00;
endcase
end
assign w = (ps==2'b10)?1'b1:1'b0;

always @(posedge clk,posedge rst) begin
if(rst)
ps <= 2'b00;
else if(en)
                  ps <= ns;
end
endmodule

*/