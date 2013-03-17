-- leds.vhd

-- This file was auto-generated as part of a generation operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity leds is
	port (
		clk        : in  std_logic                     := '0';             --          clock.clk
		reset_n    : in  std_logic                     := '0';             --    clock_reset.reset_n
		read       : in  std_logic                     := '0';             -- avalon_slave_0.read
		write      : in  std_logic                     := '0';             --               .write
		chipselect : in  std_logic                     := '0';             --               .chipselect
		address    : in  std_logic_vector(4 downto 0)  := (others => '0'); --               .address
		readdata   : out std_logic_vector(15 downto 0);                    --               .readdata
		writedata  : in  std_logic_vector(15 downto 0) := (others => '0'); --               .writedata
		leds       : out std_logic_vector(15 downto 0)                     --    conduit_end.export
	);
end entity leds;

architecture rtl of leds is
	component de2_led_flasher is
		port (
			clk        : in  std_logic                     := 'X';             -- clk
			reset_n    : in  std_logic                     := 'X';             -- reset_n
			read       : in  std_logic                     := 'X';             -- read
			write      : in  std_logic                     := 'X';             -- write
			chipselect : in  std_logic                     := 'X';             -- chipselect
			address    : in  std_logic_vector(4 downto 0)  := (others => 'X'); -- address
			readdata   : out std_logic_vector(15 downto 0);                    -- readdata
			writedata  : in  std_logic_vector(15 downto 0) := (others => 'X'); -- writedata
			leds       : out std_logic_vector(15 downto 0)                     -- export
		);
	end component de2_led_flasher;

begin

	leds_inst : component de2_led_flasher
		port map (
			clk        => clk,        --          clock.clk
			reset_n    => reset_n,    --    clock_reset.reset_n
			read       => read,       -- avalon_slave_0.read
			write      => write,      --               .write
			chipselect => chipselect, --               .chipselect
			address    => address,    --               .address
			readdata   => readdata,   --               .readdata
			writedata  => writedata,  --               .writedata
			leds       => leds        --    conduit_end.export
		);

end architecture rtl; -- of leds
