module MSSD(input serIn,clock,reset, output  [1:0] d,output  [3:0] p,output outValid,error);
wire so,en_shift,en_byte,eq_gt,D_out,cnt,en_downcnt,out_valid,err;
wire [5:0] data_out,w;
wire [6:0] po1,po2;
wire [3:0] po3;
assign d = (cnt)?data_out[1:0]:2'bz;
assign en_dcd = eq_gt;
assign outValid = out_valid;
assign error = err;

ShiftRegister6bit C0(clock,reset,en_shift,serIn,so,data_out,w);


multiply8 C1(data_out[5:2],en_byte,po1);

counter120 C2(clock,reset,en_byte,po2);

comp C3(po1,po2,eq_gt);

DCD2to4 C4(data_out[1:0],en_dcd,po3);

DFF C5(clock,reset,serIn,en_byte,D_out);

tristate C6(D_out,po3[0],p[0]);

tristate C7(D_out,po3[1],p[1]);

tristate C8(D_out,po3[2],p[2]);

tristate C9(D_out,po3[3],p[3]);

controller C10(clock,reset,so,eq_gt,serIn,cnt,en_downcnt,en_dcd,en_shift,en_byte,out_valid,err);
downcount C11(clock,reset,en_downcnt,cnt);


endmodule


