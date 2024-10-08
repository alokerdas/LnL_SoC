`default_nettype none
`timescale 1ns / 1ps

module testbench;

  wire [15:0] datin, datut, acwire, drwire, irwire;
  wire [11:0] adr, pcwire;
  wire [10:0] twire;
  wire [7:0] display, socbidin, socbidut, socbiden;
  wire intrut, ewire;
  reg ck, rs, intrin, spin, spcsin;
  reg [7:0] keyboard;

  initial begin
    $display($time,"                 e  ac   t  ar  dr   pc  ir  disp");
    $monitor($time," THE ANSWER IS = %b %h %h %h %h %h %h %h", ewire, acwire, twire, adr, drwire, pcwire, irwire, display);

    ck = 1'b0; rs = 1'b0; intrin = 0;
    #10 rs = 1'b1;
    #100 rs = 1'b0;
    #1500 intrin = 1; keyboard = 8'h77;
    #450 intrin = 0;
    #4200 keyboard = 8'h66; intrin = 1;
    #500 intrin = 0; 
    #4000 $finish;
  end 

`ifdef DUMP_VCD
  initial begin
    $dumpfile("soc.vcd");
    $dumpvars(0, testbench);
  end 
`endif

  always
    #50 ck = ~ck;

`ifdef FUNCTIONAL
  assign ewire = soc.\cpu0.e ;

  assign adr[0] = soc.\cpu0.addr[0] ;
  assign adr[1] = soc.\cpu0.addr[1] ;
  assign adr[2] = soc.\cpu0.addr[2] ;
  assign adr[3] = soc.\cpu0.addr[3] ;
  assign adr[4] = soc.\cpu0.addr[4] ;
  assign adr[5] = soc.\cpu0.addr[5] ;
  assign adr[6] = soc.\cpu0.addr[6] ;
  assign adr[7] = soc.\cpu0.addr[7] ;
  assign adr[8] = soc.\cpu0.addr[8] ;
  assign adr[9] = soc.\cpu0.addr[9] ;
  assign adr[10] = soc.\cpu0.addr[10] ;
  assign adr[11] = soc.\cpu0.addr[11] ;

  assign twire[0] = soc.\cpu0.t[0] ;
  assign twire[1] = soc.\cpu0.t[1] ;
  assign twire[2] = soc.\cpu0.t[2] ;
  assign twire[3] = soc.\cpu0.t[3] ;
  assign twire[4] = soc.\cpu0.t[4] ;
  assign twire[5] = soc.\cpu0.t[5] ;
  assign twire[6] = soc.\cpu0.t[6] ;
  assign twire[7] = soc.\cpu0.t[7] ;
  assign twire[8] = soc.\cpu0.t[8] ;
  assign twire[9] = soc.\cpu0.t[9] ;
  assign twire[10] = soc.\cpu0.t[10] ;

  assign acwire[0] = soc.\cpu0.ac[0] ;
  assign acwire[1] = soc.\cpu0.ac[1] ;
  assign acwire[2] = soc.\cpu0.ac[2] ;
  assign acwire[3] = soc.\cpu0.ac[3] ;
  assign acwire[4] = soc.\cpu0.ac[4] ;
  assign acwire[5] = soc.\cpu0.ac[5] ;
  assign acwire[6] = soc.\cpu0.ac[6] ;
  assign acwire[7] = soc.\cpu0.ac[7] ;
  assign acwire[8] = soc.\cpu0.ac[8] ;
  assign acwire[9] = soc.\cpu0.ac[9] ;
  assign acwire[10] = soc.\cpu0.ac[10] ;
  assign acwire[11] = soc.\cpu0.ac[11] ;
  assign acwire[12] = soc.\cpu0.ac[12] ;
  assign acwire[13] = soc.\cpu0.ac[13] ;
  assign acwire[14] = soc.\cpu0.ac[14] ;
  assign acwire[15] = soc.\cpu0.ac[15] ;

  assign drwire[0] = soc.\cpu0.dr[0] ;
  assign drwire[1] = soc.\cpu0.dr[1] ;
  assign drwire[2] = soc.\cpu0.dr[2] ;
  assign drwire[3] = soc.\cpu0.dr[3] ;
  assign drwire[4] = soc.\cpu0.dr[4] ;
  assign drwire[5] = soc.\cpu0.dr[5] ;
  assign drwire[6] = soc.\cpu0.dr[6] ;
  assign drwire[7] = soc.\cpu0.dr[7] ;
  assign drwire[8] = soc.\cpu0.dr[8] ;
  assign drwire[9] = soc.\cpu0.dr[9] ;
  assign drwire[10] = soc.\cpu0.dr[10] ;
  assign drwire[11] = soc.\cpu0.dr[11] ;
  assign drwire[12] = soc.\cpu0.dr[12] ;
  assign drwire[13] = soc.\cpu0.dr[13] ;
  assign drwire[14] = soc.\cpu0.dr[14] ;
  assign drwire[15] = soc.\cpu0.dr[15] ;

  assign irwire[0] = soc.\cpu0.ir[0] ;
  assign irwire[1] = soc.\cpu0.ir[1] ;
  assign irwire[2] = soc.\cpu0.ir[2] ;
  assign irwire[3] = soc.\cpu0.ir[3] ;
  assign irwire[4] = soc.\cpu0.ir[4] ;
  assign irwire[5] = soc.\cpu0.ir[5] ;
  assign irwire[6] = soc.\cpu0.ir[6] ;
  assign irwire[7] = soc.\cpu0.ir[7] ;
  assign irwire[8] = soc.\cpu0.ir[8] ;
  assign irwire[9] = soc.\cpu0.ir[9] ;
  assign irwire[10] = soc.\cpu0.ir[10] ;
  assign irwire[11] = soc.\cpu0.ir[11] ;
  assign irwire[12] = soc.\cpu0.decode2.a[0] ;
  assign irwire[13] = soc.\cpu0.decode2.a[1] ;
  assign irwire[14] = soc.\cpu0.decode2.a[2] ;
  assign irwire[15] = soc.\cpu0.ir[15] ;

  assign pcwire[0] = soc.\cpu0.pc[0] ;
  assign pcwire[1] = soc.\cpu0.pc[1] ;
  assign pcwire[2] = soc.\cpu0.pc[2] ;
  assign pcwire[3] = soc.\cpu0.pc[3] ;
  assign pcwire[4] = soc.\cpu0.pc[4] ;
  assign pcwire[5] = soc.\cpu0.pc[5] ;
  assign pcwire[6] = soc.\cpu0.pc[6] ;
  assign pcwire[7] = soc.\cpu0.pc[7] ;
  assign pcwire[8] = soc.\cpu0.pc[8] ;
  assign pcwire[9] = soc.\cpu0.pc[9] ;
  assign pcwire[10] = soc.\cpu0.pc[10] ;
  assign pcwire[11] = soc.\cpu0.pc[11] ;
`else
  assign adr = soc.cpu0.addr;
  assign ewire = soc.cpu0.e;
  assign twire = soc.cpu0.t;
  assign acwire = soc.cpu0.ac;
  assign drwire = soc.cpu0.dr;
  assign pcwire = soc.cpu0.pc;
  assign irwire = soc.cpu0.ir;
`endif

  assign socbidin = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, spcsin, spin, intrin};
  tt_um_LnL_SoC soc (
`ifdef USE_POWER_PINS
    .VPWR(1'b1),
    .VGND(1'b0),
`endif
    .ui_in(keyboard),    // Dedicated inputs
    .uo_out(display),   // Dedicated outputs
    .uio_in(socbidin),   // IOs: Input path
    .uio_out(socbidut),  // IOs: Output path
    .uio_oe(socbiden),   // IOs: Enable path (active high: 0=input, 1=output)
    .ena(1'b1),      // always 1 when the design is powered, so you can ignore it
    .clk(ck),      // clock
    .rst_n(~rs)     // reset_n - low to reset
  );
endmodule
