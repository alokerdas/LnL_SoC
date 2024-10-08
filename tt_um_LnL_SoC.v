/*
 * tt_um_LnL_SoC.v
 *
 * Simple 16-Bit Microprocessor
 *
 * Author: Aloke Kumar Das <aloke.das@ieee.org>
 */

module tt_um_LnL_SoC (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  supply0 minus;
  supply1 plus;
  reg rst_n_i;
  wire [15:0] data_to_dev, data_to_cpu, mem_to_cpu, boot_to_cpu;
  wire [11:0] addr_to_memio;
  wire [7:0] spi_to_cpu;
  wire rw_to_mem, load_spi, unload_spi, en_to_spi, en_to_dev, en_to_mem, en_to_boot;

  assign uio_oe = 8'hF0; // Lower nibble all input, Upper all output
  assign uio_out[3:0] = 4'h0; // uio_out unused bits

  always @(posedge clk or negedge rst_n)
    if (~rst_n) rst_n_i <= 1'b0;
    else rst_n_i <= 1'b1;

  assign en_to_spi = |addr_to_memio[11:4] & en_to_dev;
  assign en_to_boot = ~(|addr_to_memio[11:3]) & en_to_dev;
  assign en_to_mem = ~(|addr_to_memio[11:4]) & addr_to_memio[3] & en_to_dev;
  assign load_spi = rw_to_mem & en_to_spi;
  assign unload_spi = ~rw_to_mem & en_to_spi;
  assign data_to_cpu[7:0] = en_to_spi ? spi_to_cpu : (addr_to_memio[3] ? mem_to_cpu[7:0] : boot_to_cpu[7:0]);
  assign data_to_cpu[15:8] = en_to_spi ? 8'h00 : (addr_to_memio[3] ? mem_to_cpu[15:8] : boot_to_cpu[15:8]);

  cpu cpu0 (
`ifdef USE_POWER_PINS
    .vccd1(plus),
    .vssd1(minus),
`endif
    .clkin(clk),
    .rst(~rst_n_i),
    .addr(addr_to_memio),
    .datain(data_to_cpu),
    .dataout(data_to_dev),
    .keyboard(ui_in),
    .display(uo_out),
    .en_inp(uio_in[0]),
    .en_out(uio_out[7]),
    .rdwr(rw_to_mem),
    .en(en_to_dev)
  );
  bootrom mem0 (
`ifdef USE_POWER_PINS
    .vccd1(plus),
    .vssd1(minus),
`endif
    .clk(clk),
    .rst(~rst_n_i),
    .addr(addr_to_memio[2:0]),
    .din(data_to_dev),
    .dout(boot_to_cpu),
    .cs(en_to_boot),
    .we(rw_to_mem)
  );
  mem8x16 mem1 (
`ifdef USE_POWER_PINS
    .vccd1(plus),
    .vssd1(minus),
`endif
    .clk(clk),
    .rst(~rst_n_i),
    .addr(addr_to_memio[2:0]),
    .din(data_to_dev),
    .dout(mem_to_cpu),
    .cs(en_to_mem),
    .we(rw_to_mem)
  );
  spi spi0 (
`ifdef USE_POWER_PINS
    .vccd1(plus),
    .vssd1(minus),
`endif
    .reset(~rst_n_i),
    .clock_in(clk),
    .load(load_spi),
    .unload(unload_spi),
    .datain(data_to_dev[7:0]),
    .dataout(spi_to_cpu),
    .sclk(uio_out[6]),
    .miso(uio_in[1]),
    .mosi(uio_out[5]),
    .ssn_in(uio_in[2]),
    .ssn_out(uio_out[4])
  );

  // avoid linter warning about unused pins:
  wire _unused_pin = ena;
  wire [4:0] _unused_pins = uio_in[7:3];

endmodule  // tt_um_LnL_SoC
