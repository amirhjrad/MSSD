`timescale 1ns/1ns
module controller(
	input clk,
	input rst,
	input so,
	input eq_gt,
	input si,
	input cnt,
	output logic en_downcnt,
	output logic en_Dcd,
	output logic en_6shift,
	output logic en_byte,
	output logic outValid,
	output logic error
);
	logic [1:0] ps,ns;
	always@(ps,si,so,eq_gt) begin
		ns =  2'd0;
			case(ps)
				2'd0: begin //idle
					outValid = 0;
					error = 1;
					ns = (~si)?2'd1:ns;
					en_downcnt = (ns==2'd1)?1:0;
					en_6shift = (ns==2'd1)?1:0;
					en_byte = (ns==2'd1)?0:1;
					end
				2'd1: begin //6shifter
					if (cnt == 1)begin
						outValid = 1;
						error = 0;
						ns = (so)?2'd2:ns;
						en_6shift = (ns == 2'd2)?0:1;
						en_Dcd = (ns == 2'd2)?1:0;
						en_byte = (ns == 2'd2)?1:0;
						en_downcnt = 0;
						end
					else begin
						ns = 2'd1;
						en_6shift = 1;
						en_byte = 0;
						en_Dcd = 0;
						en_downcnt = 1;
						end
					end
				2'd2:   begin
					ns = (~eq_gt)?2'd0:2'd2; // byte
					en_byte = (ns == 2'd0)?0:1;
					en_Dcd = (ns == 2'd0)?0:1;
					en_6shift = (ns == 2'd0)?1:0;
					end
				default ns = 2'd0;
			endcase
	end

always@(posedge clk,posedge rst) begin
	if(rst)
		ps<= 2'd0;
	else
		ps<=ns;
	end
endmodule
