// leds.v

// Generated using ACDS version 12.1 177 at 2013.03.16.13:37:22

`timescale 1 ps / 1 ps
module leds (
		input  wire        clk,        //          clock.clk
		input  wire        reset_n,    //               .reset_n
		input  wire        read,       // avalon_slave_0.read
		input  wire        write,      //               .write
		input  wire        chipselect, //               .chipselect
		input  wire [4:0]  address,    //               .address
		output wire [15:0] readdata,   //               .readdata
		input  wire [15:0] writedata,  //               .writedata
		output wire [15:0] leds        //    conduit_end.export
	);

	de2_led_flasher leds_inst (
		.clk        (clk),        //          clock.clk
		.reset_n    (reset_n),    //               .reset_n
		.read       (read),       // avalon_slave_0.read
		.write      (write),      //               .write
		.chipselect (chipselect), //               .chipselect
		.address    (address),    //               .address
		.readdata   (readdata),   //               .readdata
		.writedata  (writedata),  //               .writedata
		.leds       (leds)        //    conduit_end.export
	);

endmodule
