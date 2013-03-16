// sram.v

// Generated using ACDS version 12.1 177 at 2013.03.16.13:37:16

`timescale 1 ps / 1 ps
module sram (
		input  wire        write,      // avalon_slave_0.write
		input  wire        read,       //               .read
		input  wire [17:0] address,    //               .address
		input  wire [15:0] writedata,  //               .writedata
		output wire [15:0] readdata,   //               .readdata
		input  wire [1:0]  byteenable, //               .byteenable
		input  wire        chipselect, //               .chipselect
		output wire [17:0] SRAM_ADDR,  //    conduit_end.export
		inout  wire [15:0] SRAM_DQ,    //               .export
		output wire        SRAM_UB_N,  //               .export
		output wire        SRAM_LB_N,  //               .export
		output wire        SRAM_WE_N,  //               .export
		output wire        SRAM_CE_N,  //               .export
		output wire        SRAM_OE_N   //               .export
	);

	de2_sram_controller sram_inst (
		.write      (write),      // avalon_slave_0.write
		.read       (read),       //               .read
		.address    (address),    //               .address
		.writedata  (writedata),  //               .writedata
		.readdata   (readdata),   //               .readdata
		.byteenable (byteenable), //               .byteenable
		.chipselect (chipselect), //               .chipselect
		.SRAM_ADDR  (SRAM_ADDR),  //    conduit_end.export
		.SRAM_DQ    (SRAM_DQ),    //               .export
		.SRAM_UB_N  (SRAM_UB_N),  //               .export
		.SRAM_LB_N  (SRAM_LB_N),  //               .export
		.SRAM_WE_N  (SRAM_WE_N),  //               .export
		.SRAM_CE_N  (SRAM_CE_N),  //               .export
		.SRAM_OE_N  (SRAM_OE_N)   //               .export
	);

endmodule